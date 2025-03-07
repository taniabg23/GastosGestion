import Foundation
import FirebaseFirestore

class MesesCRUD: ObservableObject {
    @Published var meses_historial: [MesDTO] = []
    @Published var mes_actual: MesDTO = MesDTO.emptyMes
    @Published var error: String?

    private var db = Firestore.firestore()
    private var mesListener: ListenerRegistration?
    private var historialListener: ListenerRegistration?
    private var categoriasCRUD: CategoriasCRUD  // 🔥 Referencia a CategoriasCRUD

    init(categoriasCRUD: CategoriasCRUD) {
        self.categoriasCRUD = categoriasCRUD
    }

    // 🔥 Listener para el mes actual en Firestore
    func listenToCurrentMonth(user_id: String) {
        let today = Date()
        let calendar = Calendar.current
        let year = calendar.component(.year, from: today)
        let month = calendar.component(.month, from: today)

        mesListener?.remove()
        mesListener = db.collection("meses")
            .whereField("user_id", isEqualTo: user_id)
            .whereField("year", isEqualTo: year)
            .whereField("mes", isEqualTo: month)
            .addSnapshotListener { snapshot, error in
                if let error = error {
                    print("❌ Error en listener de mes actual: \(error.localizedDescription)")
                    return
                }

                guard let document = snapshot?.documents.first else {
                    print("ℹ️ No hay mes actual en Firestore")
                    return
                }

                do {
                    var mesExistente = try document.data(as: MesDTO.self)
                    mesExistente.id = document.documentID
                    
                    let categoriasIds: [String] = mesExistente.categorias.map { $0.id ?? "" }
                    
                    // 🔥 Llamamos a CategoriasCRUD para obtener las categorías
                    self.categoriasCRUD.getCategoriasByIds(categoryIDs: categoriasIds) { categoriasDTO in
                        DispatchQueue.main.async {
                            mesExistente.categorias = categoriasDTO
                            self.mes_actual = mesExistente
                        }
                    }
                } catch {
                    print("❌ Error decodificando MesDTO: \(error.localizedDescription)")
                }
            }
    }

    // 🔥 Listener para el historial de meses en Firestore
    func listenToMesesHistorial(user_id: String) {
        let today = Date()
        let calendar = Calendar.current
        let currentYear = calendar.component(.year, from: today)
        let currentMonth = calendar.component(.month, from: today)

        historialListener?.remove()
        historialListener = db.collection("meses")
            .whereField("user_id", isEqualTo: user_id)
            .addSnapshotListener { snapshot, error in
                if let error = error {
                    print("❌ Error en listener de historial de meses: \(error.localizedDescription)")
                    return
                }

                let meses = snapshot?.documents.compactMap { document -> MesDTO? in
                    do {
                        var mes = try document.data(as: MesDTO.self)
                        mes.id = document.documentID

                        // Excluir el mes actual
                        if mes.mes == currentMonth && mes.year == currentYear {
                            return nil
                        }

                        return mes
                    } catch {
                        print("❌ Error decodificando MesDTO: \(error.localizedDescription)")
                        return nil
                    }
                } ?? []

                DispatchQueue.main.async {
                    self.meses_historial = meses
                }
            }
    }

    deinit {
        mesListener?.remove()
        historialListener?.remove()
    }
}

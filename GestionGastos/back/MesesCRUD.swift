//
//  MesCRUD.swift
//  GestionGastos
//
//  Created by Tania Bajo García on 16/2/25.
//

import Foundation
import FirebaseFirestore

class MesesCRUD: ObservableObject {
    @Published var meses: [MesDTO] = []
    @Published var error: String?
    
    private var db = Firestore.firestore()
    
    func getAllMeses() {
        db.collection("meses").getDocuments { snapshot, error in
            if let error = error {
                self.error = "Error obteniendo meses"
                return
            }
            
            do {
                let meses = try snapshot?.documents.compactMap { document in
                    try document.data(as: MesDTO.self)
                } ?? []
                
                DispatchQueue.main.async {
                    self.meses = meses
                }
            } catch {
                print("Error decodificando los datos: \(error.localizedDescription)")
            }
        }
    }
    
    func cargarDatosDePrueba() {
        self.meses = [
            MesDTO(id: "1", mes: 3, year: 2025, categorias: ["Alimentación", "Ocio"]),
            MesDTO(id: "2", mes: 1, year: 2025, categorias: ["Transporte", "Salud"]),
            MesDTO(id: "3", mes: 12, year: 2024, categorias: ["Educación", "Viajes"]),
            MesDTO(id: "4", mes: 6, year: 2024, categorias: ["Tecnología", "Hogar"])
        ]
    }
}

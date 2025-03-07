//
//  CategoriaCRUD.swift
//  GestionGastos
//
//  Created by Tania Bajo García on 16/2/25.
//

import Foundation
import FirebaseFirestore

class CategoriasCRUD: ObservableObject {
    // las categorias del mes actual
    @Published var cat_mes_actual: [CategoriaDTO] = []
    
    private var db = Firestore.firestore()
    
    func getCatMesActual(user_id: String) {
        let today = Date()
        let calendar = Calendar.current
        let year = calendar.component(.year, from: today)
        let month = calendar.component(.month, from: today)
    }
    
    func getCategoriasByIds(_ categoryIDs: [String], completion: @escaping ([CategoriaDTO]) -> Void) {
            guard !categoryIDs.isEmpty else {
                completion([])
                return
            }

            db.collection("categorias")
                .whereField(FieldPath.documentID(), in: categoryIDs)
                .getDocuments { snapshot, error in
                    if let error = error {
                        print("❌ Error obteniendo categorías: \(error.localizedDescription)")
                        completion([])
                        return
                    }

                    guard let documents = snapshot?.documents else {
                        completion([])
                        return
                    }

                    let categorias: [CategoriaDTO] = documents.compactMap { doc in
                        try? doc.data(as: CategoriaDTO.self)
                    }

                    completion(categorias)
                }
        }
}

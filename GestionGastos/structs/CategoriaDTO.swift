//
//  CategoriaDTO.swift
//  Gestion_gastos
//
//  Created by Tania Bajo García on 23/9/24.
//

import Foundation
import FirebaseFirestore

struct CategoriaDTO: Identifiable, Codable {
    @DocumentID var id: String?
    var nombre: String
    var gastos: [GastoDTO]
    var theme: Theme

    var wrappedID: String {
        id ?? UUID().uuidString
    }

    var totalImporte: Double {
        0.0
    }
    
    init(id: String? = nil, nombre: String, gastos: [GastoDTO], theme: Theme) {
        self.id = id
        self.nombre = nombre
        self.gastos = gastos
        self.theme = theme
    }
}

extension CategoriaDTO {
    static var emptyCat: CategoriaDTO {
        CategoriaDTO(id: nil, nombre: "", gastos: [], theme: .sky)
    }
}


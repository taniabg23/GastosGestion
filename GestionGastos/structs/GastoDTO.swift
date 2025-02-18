//
//  GastoDTO.swift
//  Gestion_gastos
//
//  Created by Tania Bajo García on 23/9/24.
//

import Foundation
import FirebaseFirestore

struct GastoDTO: Identifiable, Codable {
    @DocumentID var id: String?
    var titulo: String
    var descripcion: String
    var importe: Double
    var fecha: Date
    
    var wrappedID: String {
        id ?? UUID().uuidString
    }
}

extension GastoDTO {
    static var emptyGasto: GastoDTO {
        GastoDTO(id: nil, titulo: "", descripcion: "", importe: 0.0, fecha: Date())
    }
}

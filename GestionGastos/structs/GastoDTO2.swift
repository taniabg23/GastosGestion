//
//  GastoDTO.swift
//  Gestion_gastos
//
//  Created by Tania Bajo García on 23/9/24.
//

import Foundation

struct GastoDTO: Identifiable {
    var id: UUID
    var titulo: String
    var descripcion: String
    var importe: Double
    var fecha: Date
}

extension GastoDTO {
    static var emptyGasto : GastoDTO {
        GastoDTO(id: UUID(), titulo: "", descripcion: "", importe: 0.0, fecha: Date())
    }
}

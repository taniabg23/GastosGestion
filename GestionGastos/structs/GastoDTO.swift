//
//  GastoDTO.swift
//  GestionGastos
//
//  Created by Tania Bajo García on 8/3/25.
//

import Foundation

struct GastoDTO2: Identifiable, Codable {
    var id: Int64
    var titulo: String
    var descripcion: String?
    var fecha: Date
    var importe: Float
    var categoriaId: Int64

    enum CodingKeys: String, CodingKey {
        case id
        case titulo
        case descripcion
        case fecha
        case importe
        case categoriaId = "categoria_id"
    }
}

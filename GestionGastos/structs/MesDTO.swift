//
//  MesDTO.swift
//  GestionGastos
//
//  Created by Tania Bajo García on 8/3/25.
//

import Foundation

struct MesDTO2: Identifiable, Codable {
    var id: Int64
    var month: Int
    var year: Int
    var userId: Int64
    var categorias: [CategoriaDTO2]? = []  // Nueva propiedad

    enum CodingKeys: String, CodingKey {
        case id
        case month
        case year
        case userId = "user_id"
        case categorias
    }
}

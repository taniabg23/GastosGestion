//
//  CategoriaDTO.swift
//  GestionGastos
//
//  Created by Tania Bajo García on 8/3/25.
//

import Foundation

struct CategoriaDTO2: Identifiable, Codable {
    var id: Int64
    var nombre: String
    var theme: String
    var mesId: Int64
    var gastos: [GastoDTO2]? = []  // Nueva propiedad

    enum CodingKeys: String, CodingKey {
        case id
        case nombre
        case theme
        case mesId = "mes_id"
        case gastos
    }
}

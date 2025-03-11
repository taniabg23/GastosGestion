//
//  MesDTO2.swift
//  GestionGastos
//
//  Created by Tania Bajo García on 9/3/25.
//

import Foundation

struct MesDTO: Identifiable {
    var id: UUID
    var mes: Int
    var year: Int
    var user_id: UUID
    var categorias: [CategoriaDTO] = []  // Nueva propiedad
    
    var nombreMes: String {
        let nombresMeses = [
            "Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio",
            "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre"
        ]
        return (1...12).contains(mes) ? nombresMeses[mes - 1] : "Mes desconocido"
    }
}

extension MesDTO {
    static var emptyMes : MesDTO {
        MesDTO(id: UUID(), mes: 1, year: 2020, user_id: UUID(), categorias: [])
    }
}

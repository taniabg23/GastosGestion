//
//  MesDTO.swift
//  GestionGastos
//
//  Created by Tania Bajo García on 16/2/25.
//

import Foundation
import FirebaseFirestore

struct MesDTO: Identifiable, Codable {
    @DocumentID var id: String?
    var mes: Int
    var year: Int
    var categorias: [CategoriaDTO]
    var user_id: String
    
    var wrappedID: String {
        id ?? UUID().uuidString
    }
    
    var nombreMes: String {
        let nombresMeses = [
            "Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio",
            "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre"
        ]
        return (1...12).contains(mes) ? nombresMeses[mes - 1] : "Mes desconocido"
    }

    init(id: String? = nil, mes: Int, year: Int, categorias: [CategoriaDTO], user_id: String) {
        self.id = id
        self.mes = mes
        self.year = year
        self.categorias = categorias
        self.user_id = user_id
    }
}

extension MesDTO {
    static var emptyMes: MesDTO {
        MesDTO(mes: 1, year: 2024, categorias: [], user_id: "")
    }
}

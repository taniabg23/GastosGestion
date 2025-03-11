//
//  CategoriaDTO.swift
//  Gestion_gastos
//
//  Created by Tania Bajo García on 23/9/24.
//

import Foundation

struct CategoriaDTO: Identifiable {
    var id: UUID = UUID()
    var nombre: String
    var gastos: [GastoDTO]
    var theme: Theme
    
    var totalImporte: Double {
        var importe_total: Double = 0;
        for gasto in gastos {
            importe_total = importe_total + (gasto.importe);
        }
        return importe_total;
    }
}

extension CategoriaDTO {
    static var emptyCat : CategoriaDTO {
        CategoriaDTO (id: UUID(), nombre: "", gastos: [], theme: Theme.sky)
    }
}

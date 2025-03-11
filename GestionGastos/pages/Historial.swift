//
//  Historial.swift
//  Gestion_gastos
//
//  Created by Tania Bajo García on 5/10/24.
//

import SwiftUI

struct Historial: View {
    var mesesCRUD: MesesCRUD = MesesCRUD.singleton
    
    @Binding var meses: [MesDTO]

    var body: some View {
        NavigationStack {
            if meses.isEmpty {
                Text("No hay datos disponibles")
            } else {
                GastosMes(meses: $meses)
            }
        }
    }
}

#Preview {
    @Previewable @State var meses = [
        MesDTO(id: UUID(), mes: 1, year: 2025, user_id: UUID(), categorias: [
            CategoriaDTO(id: UUID(), nombre: "Ropa", gastos: [
                GastoDTO(id: UUID(), titulo: "Chaqueta", descripcion: "Me compré una chaqueta", importe: 23.5, fecha: Date()),
                GastoDTO(id: UUID(), titulo: "Pantalón", descripcion: "Me compré unos pantalones", importe: 35.99, fecha: Date()),
                GastoDTO(id: UUID(), titulo: "Camiseta", descripcion: "Me compré una camiseta", importe: 9.99, fecha: Date())
            ], theme: Theme.bubblegum),
            CategoriaDTO(id: UUID(), nombre: "Alimentación", gastos: [], theme: Theme.buttercup),
            CategoriaDTO(id: UUID(), nombre: "Ocio", gastos: [], theme: Theme.lavender)
        ]),
        MesDTO(id: UUID(), mes: 2, year: 2025, user_id: UUID(), categorias: [
            CategoriaDTO(id: UUID(), nombre: "Alimentación", gastos: [
                GastoDTO(id: UUID(), titulo: "Fanta", descripcion: "Lata de Fanta", importe: 1.45, fecha: Date())
            ], theme: Theme.buttercup)
        ])
    ]
    
    Historial(meses: $meses)
}

//
//  Historial.swift
//  Gestion_gastos
//
//  Created by Tania Bajo García on 5/10/24.
//

import SwiftUI

struct Historial: View {
    @EnvironmentObject var mesesCRUD: MesesCRUD
    
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
        MesDTO(id: "1", mes: 1, year: 2025, categorias: [
            CategoriaDTO(id: "1", nombre: "Ropa", gastos: [
                GastoDTO(id: "1", titulo: "Chaqueta", descripcion: "Me compré una chaqueta", importe: 23.5, fecha: Date()),
                GastoDTO(id: "2", titulo: "Pantalón", descripcion: "Me compré unos pantalones", importe: 35.99, fecha: Date()),
                GastoDTO(id: "3", titulo: "Camiseta", descripcion: "Me compré una camiseta", importe: 9.99, fecha: Date())
            ], theme: Theme.bubblegum),
            CategoriaDTO(id: "2", nombre: "Alimentación", gastos: [], theme: Theme.buttercup),
            CategoriaDTO(id: "3", nombre: "Ocio", gastos: [], theme: Theme.lavender)
        ], user_id: "5HnBWTSUutp4aQ5war63"),
        MesDTO(id: "2", mes: 2, year: 2025, categorias: [
            CategoriaDTO(id: "2", nombre: "Alimentación", gastos: [
                GastoDTO(id: "4", titulo: "Fanta", descripcion: "Lata de Fanta", importe: 1.45, fecha: Date())
            ], theme: Theme.buttercup)
        ], user_id: "5HnBWTSUutp4aQ5war63")
    ]
    
    Historial(meses: $meses)
}

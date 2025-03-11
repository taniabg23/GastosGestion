//
//  GastosMes.swift
//  Gestion_gastos
//
//  Created by Tania Bajo García on 5/10/24.
//

import SwiftUI

struct GastosMes: View {
    @Binding var meses: [MesDTO]

    var body: some View {
        NavigationStack {
            let mesesFiltrados = meses.filter { !$0.categorias.isEmpty }
            
            if mesesFiltrados.isEmpty {
                Text("No hay datos disponibles")
            } else {
                List {
                    let groupedMeses = Dictionary(grouping: mesesFiltrados, by: { $0.year })
                    let sortedYears = groupedMeses.keys.sorted(by: >)

                    ForEach(sortedYears, id: \.self) { year in
                        let mesesDelAnio = groupedMeses[year] ?? []
                        let sortedMeses = mesesDelAnio.sorted { $0.mes > $1.mes }

                        Section(header: Text("Año \(year)").font(.headline)) {
                            MesesSection(meses: .constant(sortedMeses))
                        }
                    }
                }
            }
        }
    }
}

struct MesesSection: View {
    @Binding var meses: [MesDTO]

    var body: some View {
        ForEach(meses, id: \.id) { mes in
            VStack(alignment: .leading) {
                Text("\(mes.nombreMes)")
                    .font(.headline)

                let categoriasTexto = mes.categorias.map { $0.nombre }.joined(separator: ", ")

                Text("Categorías: \(categoriasTexto)")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            .padding(.vertical, 5)
        }
    }
}

#Preview {
    @State var meses = [
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

    return GastosMes(meses: .constant(meses))
}

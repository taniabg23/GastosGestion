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
                        Section(header: Text("Año \(year)").font(.headline)) {
                            let sortedMeses = groupedMeses[year]?.sorted { $0.mes > $1.mes } ?? []
                            MesesSection(meses: sortedMeses)
                        }
                    }
                }
            }
        }
    }
}

struct MesesSection: View {
    var meses: [MesDTO]
    
    var body: some View {
        ForEach(meses, id: \.wrappedID) { mes in
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
    
    GastosMes(meses: $meses)
}


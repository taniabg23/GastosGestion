//
//  ContentView.swift
//  GestionGastos
//
//  Created by Tania Bajo García on 11/2/25.
//

import SwiftUI

struct ContentView: View {
    @State var categories = [
        CategoriaDTO(nombre: "Ropa", gastos: [
            GastoDTO(id: UUID(), titulo: "Ropa", descripcion: "Me compré ropa.", importe: 30.40, fecha: Date()),
            GastoDTO(id: UUID(), titulo: "Alimentación", descripcion: "Una hamburguesita", importe: 12.30, fecha: Date()),
            GastoDTO(id: UUID(), titulo: "Ocio", descripcion: "Me fui al cine.", importe: 25.45, fecha: Date())
        ], theme: Theme.lavender),
        CategoriaDTO(nombre: "Alimentación", gastos: [], theme: Theme.buttercup),
        CategoriaDTO(nombre: "Ocio", gastos: [], theme: Theme.bubblegum)
    ]
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
    
    var body: some View {
        TabView {
            Home(categories: $categories)
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            Historial(meses: $meses)
                .tabItem {
                    Label("Historial", systemImage: "book")
                }
            Config()
                .tabItem {
                    Label("Config", systemImage: "person")
                }
        }
    }
}

#Preview {
    ContentView()
}

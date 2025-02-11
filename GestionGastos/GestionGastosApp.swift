//
//  GestionGastosApp.swift
//  GestionGastos
//
//  Created by Tania Bajo García on 11/2/25.
//

import SwiftUI

@main
struct GestionGastosApp: App {
    @State var categories = [
        CategoriaDTO(nombre: "Ropa", gastos: [
            GastoDTO(id: UUID(), titulo: "Ropa", descripcion: "Me compré ropa.", importe: 30.40, fecha: Date()),
            GastoDTO(id: UUID(), titulo: "Alimentación", descripcion: "Una hamburguesita", importe: 12.30, fecha: Date()),
            GastoDTO(id: UUID(), titulo: "Ocio", descripcion: "Me fui al cine.", importe: 25.45, fecha: Date())
        ], theme: Theme.lavender),
        CategoriaDTO(nombre: "Alimentación", gastos: [], theme: Theme.indigo),
        CategoriaDTO(nombre: "Ocio", gastos: [], theme: Theme.indigo)
    ]
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

//
//  GestionGastosApp.swift
//  GestionGastos
//
//  Created by Tania Bajo García on 11/2/25.
//

import SwiftUI
import FirebaseCore
import FirebaseFirestore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct GestionGastosApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
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

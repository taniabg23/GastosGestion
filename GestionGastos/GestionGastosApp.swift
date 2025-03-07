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
    @StateObject private var mesesCRUD = MesesCRUD()
    @StateObject private var categoriasCRUD = CategoriasCRUD()
    @StateObject private var gastosCRUD = GastosCRUD()
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    @State var categories = [
        CategoriaDTO(id: "1", nombre: "Ropa", gastos: [
            GastoDTO(id: "1", titulo: "Chaqueta", descripcion: "Me compré una chaqueta", importe: 23.5, fecha: Date()),
            GastoDTO(id: "2", titulo: "Pantalón", descripcion: "Me compré unos pantalones", importe: 35.99, fecha: Date()),
            GastoDTO(id: "3", titulo: "Camiseta", descripcion: "Me compré una camiseta", importe: 9.99, fecha: Date())
        ], theme: Theme.bubblegum),
        CategoriaDTO(id: "2", nombre: "Alimentación", gastos: [], theme: Theme.buttercup),
        CategoriaDTO(id: "3", nombre: "Ocio", gastos: [], theme: Theme.lavender)
    ]
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(mesesCRUD)
                .environmentObject(categoriasCRUD)
                .environmentObject(gastosCRUD)
        }
    }
}

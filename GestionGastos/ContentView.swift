//
//  ContentView.swift
//  GestionGastos
//
//  Created by Tania Bajo García on 11/2/25.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var mesesCRUD: MesesCRUD
    @EnvironmentObject var categoriasCRUD: CategoriasCRUD

    var body: some View {
        TabView {
            Home(categories: $mesesCRUD.mes_actual.categorias)
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            Historial(meses: $mesesCRUD.meses_historial)
                .tabItem {
                    Label("Historial", systemImage: "book")
                }
            Config()
                .tabItem {
                    Label("Config", systemImage: "person")
                }
        }
        .onAppear {
            let userId = "5HnBWTSUutp4aQ5war63"  // Tu ID de usuario

            mesesCRUD.listenToCurrentMonth(user_id: userId)
            mesesCRUD.listenToMesesHistorial(user_id: userId)
        }
    }
}

#Preview {
    ContentView()
}

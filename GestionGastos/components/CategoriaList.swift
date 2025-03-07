//
//  CatList.swift
//  Gestion_gastos
//
//  Created by Tania Bajo García on 23/9/24.
//

import SwiftUI

struct CategoriaList: View {
    @Binding var categories: [CategoriaDTO]
    @Binding var selectedCategory: CategoriaDTO?
    @Binding var isPresentingEditCategory: Bool

    var body: some View {
        ZStack {
            if categories.isEmpty {
                Text("No hay categorías")
                    .font(.title)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
            } else {
                List {
                    Section(header: Text("Categorías")) {
                        ForEach(categories) { category in
                            NavigationLink(destination: GastoList(gastos: category.gastos)) {
                                CardView(category: category)
                            }
                            .listRowBackground(category.theme.mainColor)
                        }
                    }
                }
            }
        }
        .actionSheet(isPresented: $isPresentingEditCategory) {
            ActionSheet(
                title: Text("Seleccionar categoría para editar"),
                buttons: categories.map { category in
                    .default(Text(category.nombre)) {
                        selectedCategory = category
                    }
                } + [.cancel()]
            )
        }
    }
}

#Preview {
    @Previewable @State var categories = [
        CategoriaDTO(id: "1", nombre: "Ropa", gastos: [
            GastoDTO(id: "1", titulo: "Chaqueta", descripcion: "Me compré una chaqueta", importe: 23.5, fecha: Date()),
            GastoDTO(id: "2", titulo: "Pantalón", descripcion: "Me compré unos pantalones", importe: 35.99, fecha: Date()),
            GastoDTO(id: "3", titulo: "Camiseta", descripcion: "Me compré una camiseta", importe: 9.99, fecha: Date())
        ], theme: Theme.bubblegum),
        CategoriaDTO(id: "2", nombre: "Alimentación", gastos: [], theme: Theme.buttercup),
        CategoriaDTO(id: "3", nombre: "Ocio", gastos: [], theme: Theme.lavender)
    ]
    @Previewable @State var selectedCategory: CategoriaDTO? = nil
    @Previewable @State var isPresentingEditCategory = false

    CategoriaList(categories: $categories, selectedCategory: $selectedCategory, isPresentingEditCategory: $isPresentingEditCategory)
}

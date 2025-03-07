//
//  Home.swift
//  Gestion_gastos
//
//  Created by Tania Bajo García on 23/9/24.
//

import SwiftUI

struct Home: View {
    @Binding var categories: [CategoriaDTO]
    @State private var isPresentingNewCategory = false
    @State private var isPresentingEditCategory = false
    @State private var selectedCategory: CategoriaDTO?

    var body: some View {
        NavigationStack {
            VStack {
                CategoriaList(categories: $categories, selectedCategory: $selectedCategory, isPresentingEditCategory: $isPresentingEditCategory)
            }
            .navigationTitle("Gastos")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button(action: {
                        isPresentingNewCategory = true
                    }) {
                        Image(systemName: "plus")
                    }
                    .accessibilityLabel("Nueva categoría")
                }

                ToolbarItem(placement: .cancellationAction) {
                    Button(action: {
                        isPresentingEditCategory = true
                    }) {
                        Image(systemName: "pencil.line")
                    }
                    .accessibilityLabel("Editar categoría")
                }
            }
        }
        .sheet(isPresented: $isPresentingNewCategory) {
            NewCat(categories: $categories, isPresentingNewCategory: $isPresentingNewCategory)
        }
        .sheet(item: $selectedCategory) { category in
            EditExistingCat(category: $categories[categories.firstIndex(where: { $0.id == category.id })!],
                            categories: $categories,
                            dismiss: {
                                selectedCategory = nil
                            })
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
    
    Home(categories: $categories)
}

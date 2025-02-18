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
    @State var categories = [
        CategoriaDTO(nombre: "Ropa", gastos: [
            GastoDTO(id: "1", titulo: "Ropa", descripcion: "Me compré ropa.", importe: 30.40, fecha: Date()),
            GastoDTO(id: "2", titulo: "Alimentación", descripcion: "Una hamburguesita", importe: 12.30, fecha: Date()),
            GastoDTO(id: "3", titulo: "Ocio", descripcion: "Me fui al cine.", importe: 25.45, fecha: Date())
        ], theme: Theme.bubblegum),
        CategoriaDTO(nombre: "Alimentación", gastos: [], theme: Theme.buttercup),
        CategoriaDTO(nombre: "Ocio", gastos: [], theme: Theme.lavender)
    ]
    
    Home(categories: $categories)
}

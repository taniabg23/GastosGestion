//
//  NewCat.swift
//  Gestion_gastos
//
//  Created by Tania Bajo García on 28/9/24.
//

import SwiftUI

struct NewCat: View {
    @State var category = CategoriaDTO.emptyCat
    @Binding var categories: [CategoriaDTO]
    @Binding var isPresentingNewCategory: Bool
    
    var isValid: Bool {
        !category.nombre.isEmpty &&
        !categories.contains(where: { $0.nombre.lowercased() == category.nombre.lowercased() })
    }
    
    var body: some View {
        NavigationStack {
            EditCat(cat: $category)
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Cancelar") {
                            isPresentingNewCategory = false
                        }
                    }
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Añadir") {
                            categories.append(category)
                            isPresentingNewCategory = false
                        }
                        .disabled(!isValid)
                    }
                }
                .navigationTitle("Nueva categoría")
        }
    }
}

#Preview {
    struct PreviewWrapper: View {
        @State var categories = [
            CategoriaDTO(nombre: "Ropa", gastos: [], theme: Theme.buttercup),
            CategoriaDTO(nombre: "Alimentación", gastos: [], theme: Theme.orange),
            CategoriaDTO(nombre: "Ocio", gastos: [], theme: Theme.seafoam)
        ]
        @State var showNewCat = true
        
        var body: some View {
            NewCat(categories: $categories, isPresentingNewCategory: $showNewCat)
        }
    }
    
    return PreviewWrapper()
}

//
//  EditExistingCat.swift
//  Gestion_gastos
//
//  Created by Tania Bajo García on 12/10/24.
//

import SwiftUI

struct EditExistingCat: View {
    @Binding var category: CategoriaDTO
    @Binding var categories: [CategoriaDTO]
    var dismiss: () -> Void
    
    @State private var originalCategory: CategoriaDTO

    init(category: Binding<CategoriaDTO>, categories: Binding<[CategoriaDTO]>, dismiss: @escaping () -> Void) {
        _category = category
        _categories = categories
        self.dismiss = dismiss
        _originalCategory = State(initialValue: category.wrappedValue)
    }

    var isFormValid: Bool {
        !category.nombre.isEmpty && !categories.filter({ $0.id != category.id }).contains(where: { $0.nombre.lowercased() == category.nombre.lowercased() })
    }

    var body: some View {
        NavigationStack {
            VStack {
                EditCat(cat: $category)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Cancelar") {
                                category = originalCategory
                                dismiss()
                            }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Confirmar") {
                                dismiss()
                            }
                            .disabled(!isFormValid)
                        }
                    }
                
                Spacer()
                
                Button(role: .destructive) {
                    deleteCategory()
                } label: {
                    Text("Borrar categoría")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .cornerRadius(8)
                        .padding(.horizontal)
                }
            }
            .navigationTitle("Editar categoría")
        }
    }

    func deleteCategory() {
        if let index = categories.firstIndex(where: { $0.id == category.id }) {
            categories.remove(at: index)
            dismiss()
        }
    }
}

#Preview {
    struct PreviewWrapper: View {
        @State var showEditCat = true
        @State var category = CategoriaDTO(nombre: "Alimentación2", gastos: [], theme: Theme.buttercup)
        @State var categories = [
            CategoriaDTO(nombre: "Ropa", gastos: [], theme: Theme.buttercup),
            CategoriaDTO(nombre: "Alimentación", gastos: [], theme: Theme.orange),
            CategoriaDTO(nombre: "Ocio", gastos: [], theme: Theme.seafoam)
        ]

        var body: some View {
            EditExistingCat(
                category: $category,
                categories: $categories,
                dismiss: { showEditCat = false }
            )
        }
    }
    
    return PreviewWrapper()
}

//
//  EditCat.swift
//  Gestion_gastos
//
//  Created by Tania Bajo García on 28/9/24.
//

import SwiftUI

struct EditCat: View {
    @Binding var cat: CategoriaDTO
    
    var body: some View {
        Form {
            Section (header: Text("Info categoría")) {
                TextField("Título", text: $cat.nombre)
                ThemePicker(selection: $cat.theme)
            }
        }
    }
}

#Preview {
    @Previewable @State var category = CategoriaDTO(nombre: "Ropa", gastos: [], theme: Theme.magenta)
        
    return EditCat(cat: $category)
}

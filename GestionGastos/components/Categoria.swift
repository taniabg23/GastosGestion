//
//  Categoria.swift
//  Gestion_gastos
//
//  Created by Tania Bajo García on 23/9/24.
//

import SwiftUI

struct Categoria: View {
    let categoria: CategoriaDTO

    var body: some View {
        HStack {
            Text(categoria.nombre)
                .font(.headline)
            
            Spacer()
            
            Text(String(format: "%.2f€", categoria.totalImporte))
                .font(.headline)
                .foregroundColor(.green)
        }
        .padding()
        .background(Color.white)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.gray.opacity(0.5), lineWidth: 1)
        )
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
    }
}

#Preview {
    ZStack {
        let lista_gastos: [GastoDTO] = [
                GastoDTO(id: "1", titulo: "Ropa", descripcion: "Me compré ropa.", importe: 30.40, fecha: Date()),
                GastoDTO(id: "2", titulo: "Alimentación", descripcion: "Una hamburguesita", importe: 12.30, fecha: Date()),
                GastoDTO(id: "3", titulo: "Ocio", descripcion: "Me fui al cine.", importe: 25.45, fecha: Date()),
            ]
            
        Categoria(categoria: CategoriaDTO(nombre: "Alimentación", gastos: lista_gastos, theme: Theme.oxblood))
    }
}

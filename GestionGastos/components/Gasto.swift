//
//  Gasto.swift
//  Gestion_gastos
//
//  Created by Tania Bajo García on 23/9/24.
//

import SwiftUI

struct Gasto: View {
    let gasto: GastoDTO

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(gasto.titulo)
                    .font(.headline)
                Text(gasto.descripcion)
                    .font(.subheadline)
                    .lineLimit(1)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            Text(String(format: "%.2f€", gasto.importe))
                .font(.headline)
                .foregroundColor(.blue)
        }
        .padding()
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.gray.opacity(0.5), lineWidth: 1)
        )
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
    }
}

#Preview {
    Gasto(gasto: GastoDTO(id: UUID(), titulo: "Ropa", descripcion: "Me compré ropa.", importe: 50.80, fecha: Date()))
}

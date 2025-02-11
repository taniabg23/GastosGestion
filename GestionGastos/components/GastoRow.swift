//
//  GastoByRow.swift
//  Gestion_gastos
//
//  Created by Tania Bajo García on 13/10/24.
//

import SwiftUI

struct GastoRow: View {
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
        .padding(.vertical, 5)
    }
}

#Preview {
    GastoRow(gasto: GastoDTO(id: UUID(), titulo: "Ocio", descripcion: "Fui al cine", importe: 25.50, fecha: Date()))
}

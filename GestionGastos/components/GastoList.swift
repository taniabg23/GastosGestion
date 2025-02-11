//
//  GastoList.swift
//  Gestion_gastos
//
//  Created by Tania Bajo García on 28/9/24.
//

import SwiftUI

struct GastoList: View {
    @State private var isPresentingGastoInfo: Bool = false
    @State private var selectedGastoIndex: Int? = nil
    @State private var isPresentingNewGasto: Bool = false
    @State var gastos: [GastoDTO]

    var body: some View {
        NavigationStack {
            VStack {
                if gastos.isEmpty {
                    Text("No hay gastos para esta categoría.")
                        .font(.headline)
                        .foregroundColor(.black)
                } else {
                    GroupedGastosList(
                        gastos: gastos,
                        onSelectGasto: { index in
                            selectedGastoIndex = index
                            isPresentingGastoInfo = true
                        }
                    )
                }
            }
            .navigationTitle("Gastos de este mes")
            .toolbar {
                Button(action: {
                    isPresentingNewGasto = true
                }) {
                    Image(systemName: "plus")
                }
                .accessibilityLabel("Nuevo gasto")
            }
            .sheet(isPresented: $isPresentingGastoInfo) {
                if let index = selectedGastoIndex {
                    GastoInfo(
                        gasto: Binding(
                            get: { gastos[index] },
                            set: { newGasto in
                                gastos[index] = newGasto
                            }
                        ),
                        isPresented: $isPresentingGastoInfo,
                        gastoTemporal: gastos[index],
                        gastos: $gastos,
                        dismiss: {
                            isPresentingGastoInfo = false
                        }
                    )
                }
            }
            .sheet(isPresented: $isPresentingNewGasto) {
                NewGasto(isPresented: $isPresentingNewGasto, gastos: $gastos)
            }
        }
    }
}

#Preview {
    let lista_gastos: [GastoDTO] = [
        GastoDTO(id: UUID(), titulo: "Ropa", descripcion: "Me compré ropa.", importe: 30.40, fecha: Calendar.current.date(byAdding: .day, value: -1, to: Date())!),
        GastoDTO(id: UUID(), titulo: "Alimentación", descripcion: "Una hamburguesita", importe: 12.30, fecha: Calendar.current.date(byAdding: .day, value: 0, to: Date())!),
        GastoDTO(id: UUID(), titulo: "Ocio", descripcion: "Me fui al cine.", importe: 25.45, fecha: Calendar.current.date(byAdding: .day, value: -1, to: Date())!),
        GastoDTO(id: UUID(), titulo: "Transporte", descripcion: "Taxi a casa", importe: 15.00, fecha: Calendar.current.date(byAdding: .day, value: -3, to: Date())!),
        GastoDTO(id: UUID(), titulo: "Regalo", descripcion: "Compré un regalo", importe: 50.00, fecha: Calendar.current.date(byAdding: .day, value: -3, to: Date())!)
    ]

    GastoList(gastos: lista_gastos)
}

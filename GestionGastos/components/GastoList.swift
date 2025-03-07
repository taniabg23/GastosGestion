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
                    let gastosCRUD = GastosCRUD()
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
                        },
                        gastosCRUD: gastosCRUD
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
    let gastosCRUD = GastosCRUD()
    gastosCRUD.cargarGastosPrueba()
    return GastoList(gastos: gastosCRUD.gastos)
}

//
//  GroupedGastosList.swift
//  Gestion_gastos
//
//  Created by Tania Bajo García on 9/1/25.
//

import SwiftUI

struct GroupedGastosList: View {
    @EnvironmentObject var gastosCRUD: GastosCRUD
    let gastos: [GastoDTO]
    let onSelectGasto: (Int) -> Void

    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()

    private var groupedGastos: [Date: [GastoDTO]] {
        Dictionary(grouping: gastos, by: { Calendar.current.startOfDay(for: $0.fecha) })
    }

    private var sortedDates: [Date] {
        groupedGastos.keys.sorted(by: { $0 > $1 })
    }

    var body: some View {
        List {
            ForEach(sortedDates, id: \.self) { fecha in
                if let gastosEnFecha = groupedGastos[fecha] {
                    Section(header: Text(dateFormatter.string(from: fecha))) {
                        ForEach(gastosEnFecha, id: \.wrappedID) { gasto in
                            GastoRow(gasto: gasto)
                                .onTapGesture {
                                    if let index = gastos.firstIndex(where: { $0.wrappedID == gasto.wrappedID }) {
                                        onSelectGasto(index)
                                    }
                                }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    let gastosCRUD = GastosCRUD()
    gastosCRUD.cargarGastosPrueba()

    return GroupedGastosList(gastos: gastosCRUD.gastos, onSelectGasto: { _ in })
        .environmentObject(gastosCRUD)
}

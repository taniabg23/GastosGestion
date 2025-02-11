//
//  GroupedGastosList.swift
//  Gestion_gastos
//
//  Created by Tania Bajo García on 9/1/25.
//

import SwiftUI

struct GroupedGastosList: View {
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
                        ForEach(gastosEnFecha, id: \.id) { gasto in
                            GastoRow(gasto: gasto)
                                .onTapGesture {
                                    if let index = gastos.firstIndex(where: { $0.id == gasto.id }) {
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
    let lista_gastos: [GastoDTO] = [
        GastoDTO(id: UUID(), titulo: "Ropa", descripcion: "Me compré ropa.", importe: 30.40, fecha: Calendar.current.date(byAdding: .day, value: -1, to: Date())!),
        GastoDTO(id: UUID(), titulo: "Alimentación", descripcion: "Una hamburguesita", importe: 12.30, fecha: Calendar.current.date(byAdding: .day, value: 0, to: Date())!),
        GastoDTO(id: UUID(), titulo: "Ocio", descripcion: "Me fui al cine.", importe: 25.45, fecha: Calendar.current.date(byAdding: .day, value: -1, to: Date())!),
        GastoDTO(id: UUID(), titulo: "Transporte", descripcion: "Taxi a casa", importe: 15.00, fecha: Calendar.current.date(byAdding: .day, value: -3, to: Date())!),
        GastoDTO(id: UUID(), titulo: "Regalo", descripcion: "Compré un regalo", importe: 50.00, fecha: Calendar.current.date(byAdding: .day, value: -3, to: Date())!)
    ]

    GroupedGastosList(gastos: lista_gastos, onSelectGasto: { _ in })
}

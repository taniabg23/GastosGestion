//
//  Historial.swift
//  Gestion_gastos
//
//  Created by Tania Bajo García on 5/10/24.
//

import SwiftUI

struct Historial: View {
    @EnvironmentObject var mesesCRUD: MesesCRUD

    var body: some View {
        NavigationStack {
            if mesesCRUD.meses.isEmpty {
                Text("No hay datos disponibles")
            } else {
                List {
                    let groupedMeses = Dictionary(grouping: mesesCRUD.meses, by: { $0.year })
                    let sortedYears = groupedMeses.keys.sorted(by: >)

                    ForEach(sortedYears, id: \.self) { year in
                        Section(header: Text("Año \(year)").font(.headline)) {
                            let sortedMeses = (groupedMeses[year] ?? []).sorted { $0.mes > $1.mes }

                            ForEach(sortedMeses, id: \.wrappedID) { mes in
                                VStack(alignment: .leading) {
                                    Text("\(mes.nombreMes)")
                                            .font(.headline)
                                    Text("Categorías: \(mes.categorias.joined(separator: ", "))")
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                }
                                .padding(.vertical, 5)
                            }
                        }
                    }
                }
            }
        }
        .onAppear {
            mesesCRUD.cargarDatosDePrueba()
            //mesesCRUD.getAllMeses()
        }
    }
}

#Preview {
    Historial().environmentObject(MesesCRUD())
}

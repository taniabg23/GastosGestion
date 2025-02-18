//
//  GastoInfo.swift
//  Gestion_gastos
//
//  Created by Tania Bajo García on 29/9/24.
//

import SwiftUI

struct NewGasto: View {
    @State var gasto: GastoDTO = GastoDTO.emptyGasto
    @Binding var isPresented: Bool
    @Binding var gastos: [GastoDTO]
    
    @State private var importeString: String = ""
    
    let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            formatter.minimumFractionDigits = 2
            formatter.maximumFractionDigits = 2
            return formatter
    }()
    
    var isFormValid: Bool {
        !gasto.titulo.isEmpty && !gasto.descripcion.isEmpty && (Double(importeString) ?? 0) > 0
    }

    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    Section (header: Text("Nuevo gasto")) {
                        TextField("Título", text: $gasto.titulo)
                        TextField("Descripción", text: $gasto.descripcion)
                        TextField("Importe", text: $importeString)
                            .keyboardType(.decimalPad)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .onChange(of: importeString) {
                                let filtered = importeString.filter { "0123456789.".contains($0) }
                                if filtered != importeString {
                                    importeString = filtered
                                }
                                
                                gasto.importe = Double(importeString) ?? 0
                            }
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancelar") {
                        isPresented = false
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Añadir") {
                        gastos.insert(gasto, at: 0)
                        isPresented = false
                    }
                    .disabled(!isFormValid)
                }
            }
        }
    }
}

#Preview {
    struct PreviewWrapper: View {
        @State var gastos = [
            GastoDTO(id: "1", titulo: "Ropa", descripcion: "Me compré ropa.", importe: 30.40, fecha: Calendar.current.date(byAdding: .day, value: -1, to: Date())!),
            GastoDTO(id: "2", titulo: "Alimentación", descripcion: "Una hamburguesita", importe: 12.30, fecha: Calendar.current.date(byAdding: .day, value: 0, to: Date())!),
            GastoDTO(id: "3", titulo: "Ocio", descripcion: "Me fui al cine.", importe: 25.45, fecha: Calendar.current.date(byAdding: .day, value: -1, to: Date())!),
            GastoDTO(id: "4", titulo: "Transporte", descripcion: "Taxi a casa", importe: 15.00, fecha: Calendar.current.date(byAdding: .day, value: -3, to: Date())!),
            GastoDTO(id: "5", titulo: "Regalo", descripcion: "Compré un regalo", importe: 50.00, fecha: Calendar.current.date(byAdding: .day, value: -3, to: Date())!)
        ]
        @State var showModal = true
        
        var body: some View {
            NewGasto(isPresented: $showModal, gastos: $gastos)
        }
    }
    
    return PreviewWrapper()
}

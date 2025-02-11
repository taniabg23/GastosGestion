//
//  GastoInfo.swift
//  Gestion_gastos
//
//  Created by Tania Bajo García on 29/9/24.
//

import SwiftUI

struct GastoInfo: View {
    @Binding var gasto: GastoDTO
    @Binding var isPresented: Bool
    @Binding var gastos: [GastoDTO]
    @State private var gastoTemporal: GastoDTO
    @State private var isEditing: Bool = false
    var dismiss: () -> Void

    public init(gasto: Binding<GastoDTO>, isPresented: Binding<Bool>, gastoTemporal: GastoDTO, gastos: Binding<[GastoDTO]>, dismiss: @escaping () -> Void) {
        self._gasto = gasto
        self._isPresented = isPresented
        self._gastoTemporal = State(initialValue: gastoTemporal)
        self._gastos = gastos
        self.dismiss = dismiss
    }
    
    let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }()

    var body: some View {
        NavigationStack {
            VStack {
                if isEditing {
                    Form {
                        Section(header: Text("Detalles del gasto")) {
                            VStack(alignment: .leading) {
                                Text("Título")
                                    .font(.headline)
                                TextField("Título", text: $gastoTemporal.titulo)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .padding(.bottom, 10)
                                
                                Text("Descripción")
                                    .font(.headline)
                                TextField("Descripción", text: $gastoTemporal.descripcion)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .padding(.bottom, 10)

                                Text("Importe")
                                    .font(.headline)
                                TextField("Importe", value: Binding(
                                    get: { gastoTemporal.importe },
                                    set: { gastoTemporal.importe = $0 }),
                                          formatter: numberFormatter)
                                            .keyboardType(.decimalPad)
                                            .textFieldStyle(RoundedBorderTextFieldStyle())
                                            .padding(.bottom, 10)
                            }
                        }
                    }
                    Spacer()
                    
                    Button(role: .destructive) {
                        deleteGasto()
                    } label: {
                        Text("Borrar gasto")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .cornerRadius(8)
                            .padding(.horizontal)
                    }
                } else {
                    Form {
                        Section(header: Text("Detalles del gasto")) {
                            VStack(alignment: .leading) {
                                Text("Título")
                                    .font(.headline)
                                Text(gasto.titulo)
                                    .foregroundColor(.gray)
                                
                                Text("Descripción")
                                    .font(.headline)
                                Text(gasto.descripcion)
                                    .foregroundColor(.gray)

                                Text("Importe")
                                    .font(.headline)
                                Text(String(format: "%.2f€", gasto.importe))
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                }
            }
            .navigationTitle(isEditing ? "Editar Gasto" : "Detalles del gasto")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancelar") {
                        if isEditing {
                            gastoTemporal = gasto
                        }
                        isPresented = false
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    if isEditing {
                        Button("Aceptar") {
                            gasto = gastoTemporal
                            isPresented = false
                        }
                    } else {
                        Button("Editar") {
                            gastoTemporal = gasto
                            isEditing.toggle()
                        }
                    }
                }
            }
        }
    }
    
    func deleteGasto() {
        if let index = gastos.firstIndex(where: { $0.id == gasto.id }) {
            gastos.remove(at: index)
            dismiss()
        }
    }
}

#Preview {
    @State var gastoEjemplo = GastoDTO(id: UUID(), titulo: "Ejemplo", descripcion: "Descripción del gasto", importe: 20.50, fecha: Date())
    @State var showModal = true
    @State var listaGastos: [GastoDTO] = [gastoEjemplo]

    GastoInfo(
        gasto: $gastoEjemplo,
        isPresented: $showModal,
        gastoTemporal: gastoEjemplo,
        gastos: $listaGastos,  // Pasamos los gastos
        dismiss: { showModal = false }
    )
}

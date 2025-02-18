//
//  GastoCRUD.swift
//  GestionGastos
//
//  Created by Tania Bajo García on 16/2/25.
//

import Foundation
import FirebaseFirestore

class GastosCRUD: ObservableObject {
    @Published var gastos: [GastoDTO] = []
    
    private var db = Firestore.firestore()
    
    func cargarGastosPrueba() {
        self.gastos = [
            GastoDTO(id: "1", titulo: "Ropa", descripcion: "Me compré ropa.", importe: 30.40, fecha: Calendar.current.date(byAdding: .day, value: -1, to: Date())!),
            GastoDTO(id: "2", titulo: "Alimentación", descripcion: "Una hamburguesita", importe: 12.30, fecha: Calendar.current.date(byAdding: .day, value: 0, to: Date())!),
            GastoDTO(id: "3", titulo: "Ocio", descripcion: "Me fui al cine.", importe: 25.45, fecha: Calendar.current.date(byAdding: .day, value: -1, to: Date())!),
            GastoDTO(id: "4", titulo: "Transporte", descripcion: "Taxi a casa", importe: 15.00, fecha: Calendar.current.date(byAdding: .day, value: -3, to: Date())!),
            GastoDTO(id: "5", titulo: "Regalo", descripcion: "Compré un regalo", importe: 50.00, fecha: Calendar.current.date(byAdding: .day, value: -3, to: Date())!)
        ]
    }
}

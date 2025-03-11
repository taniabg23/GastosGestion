//
//  MesesCRUD.swift
//  GestionGastos
//
//  Created by Tania Bajo García on 8/3/25.
//

import Foundation

class MesesCRUD {
    static let singleton = MesesCRUD()
    
    var mes_actual: MesDTO2?
    var historialMeses: [MesDTO2] = []
    
    private let supabase = SupabaseManager.singleton.client  // Instancia de Supabase

    private init() {}

    func obtenerMesActual() async throws{
        let mesActual = Calendar.current.component(.month, from: Date())
        let anioActual = Calendar.current.component(.year, from: Date())

        let mesesResponse: [MesDTO2] = try await supabase
            .from("meses")
            .select("*")
            .eq("month", value: mesActual)
            .eq("year", value: anioActual)
            .execute()
            .value

        if let mesExistente = mesesResponse.first {
            mes_actual = mesExistente
        } else {
            let nuevoMes = MesDTO2(id: 0, month: mesActual, year: anioActual, userId: 1) // Asumiendo que el `user_id` es 1
            let nuevoMesResponse: [MesDTO2] = try await supabase
                .from("meses")
                .insert(nuevoMes)
                .execute()
                .value
            
            mes_actual = nuevoMesResponse.first ?? nuevoMes
        }
    }

    func obtenerMesesExcluyendoActual() async throws {
        let mesActual = Calendar.current.component(.month, from: Date())
        let anioActual = Calendar.current.component(.year, from: Date())

        let mesesResponse: [MesDTO2] = try await supabase
            .from("meses")
            .select("*")
            .neq("month", value: mesActual)
            .neq("year", value: anioActual)
            .execute()
            .value
        
        historialMeses = mesesResponse
    }
}

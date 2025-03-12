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

    func obtenerMesActual(user_id: Int64) async throws{
        let mesActual = Calendar.current.component(.month, from: Date())
        let anioActual = Calendar.current.component(.year, from: Date())

        let mesesResponse: [MesDTO2] = try await supabase
            .from("meses")
            .select("*")
            .eq("month", value: mesActual)
            .eq("year", value: anioActual)
            .execute()
            .value

        if var mesExistente = mesesResponse.first {
            let categoriasMes = try await CategoriasCRUD.singleton.obtenerCategoriasConGastos(forMesId: mesExistente.id)
            mesExistente.categorias = categoriasMes
            mes_actual = mesExistente
        } else {
            let nuevoMes = MesDTO2(id: 0, month: mesActual, year: anioActual, userId: user_id)
            let nuevoMesResponse: [MesDTO2] = try await supabase
                .from("meses")
                .insert(nuevoMes)
                .execute()
                .value
            
            var nuevoMesResponseConCat = nuevoMesResponse.first
            nuevoMesResponseConCat?.categorias = []
            
            var nuevoMesConCat = nuevoMes
            nuevoMesConCat.categorias = []
            
            mes_actual = nuevoMesResponseConCat ?? nuevoMesConCat
        }
    }

    func obtenerMesesExcluyendoActual(user_id: Int64) async throws {
        let mesActual = Calendar.current.component(.month, from: Date())
        let anioActual = Calendar.current.component(.year, from: Date())

        let mesesResponse: [MesDTO2] = try await supabase
            .from("meses")
            .select("*")
            .neq("month", value: mesActual)
            .neq("year", value: anioActual)
            .eq("user_id", value: String(user_id))
            .execute()
            .value
        
        historialMeses = mesesResponse
        
        for (index, mes) in historialMeses.enumerated() {
            historialMeses[index].categorias = try await CategoriasCRUD.singleton.obtenerCategoriasConGastos(forMesId: mes.id)
        }
    }
}

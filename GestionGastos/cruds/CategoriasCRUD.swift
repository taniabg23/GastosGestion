//
//  CategoriasCRUD.swift
//  GestionGastos
//
//  Created by Tania Bajo García on 9/3/25.
//

import Foundation

class CategoriasCRUD {
    static let singleton = CategoriasCRUD()

    private let supabase = SupabaseManager.singleton.client

    private init() {}

    // En CategoriasCRUD
    func obtenerCategoriasConGastos(forMesId mesId: Int64) async throws -> [CategoriaDTO2] {
        // Obtener las categorías relacionadas con el mes especificado
        let categoriasResponse: [CategoriaDTO2] = try await supabase
            .from("categorias")
            .select("*")
            .eq("mes_id", value: String(mesId)) // Filtrar por mes_id
            .execute()
            .value
        
        var categoriasConGastos: [CategoriaDTO2] = []
        
        for categoria in categoriasResponse {
            // Obtener los gastos relacionados con esta categoría
            let gastosResponse: [GastoDTO2] = try await GastosCRUD.singleton.obtenerGastos(forCategoriaId: categoria.id)
            
            // Crear el objeto CategoriaDTO2 con los gastos obtenidos
            var categoriaConGastos = categoria
            categoriaConGastos.gastos = gastosResponse
            
            // Agregar a la lista final
            categoriasConGastos.append(categoriaConGastos)
        }
        
        return categoriasConGastos
    }

    func crearCategoria(nombre: String, theme: String, mesId: Int64) async throws -> CategoriaDTO2 {
        var nuevaCategoria = CategoriaDTO2(id: 0, nombre: nombre, theme: theme, mesId: mesId)
        
        var categoriaResponse: [CategoriaDTO2] = try await supabase
            .from("categorias")
            .insert(nuevaCategoria)
            .execute()
            .value
        
        nuevaCategoria.gastos = []
        var categoriaResponseConGastos = categoriaResponse.first
        categoriaResponseConGastos?.gastos = []
        
        return categoriaResponseConGastos ?? nuevaCategoria
    }
    
    // En CategoriasCRUD
    func modificarCategoria(id: Int64, nuevoNombre: String, nuevoTheme: String) async throws -> CategoriaDTO2 {
        // Actualizar la categoría con el nuevo nombre y theme
        let categoriaActualizada: [CategoriaDTO2] = try await supabase
            .from("categorias")
            .update([
                "nombre": nuevoNombre,
                "theme": nuevoTheme
            ])
            .eq("id", value: String(id)) // Filtrar por ID de la categoría
            .execute()
            .value
        
        // obtener los gastos de la categoría
        var categoriaActualizadaConGastos = categoriaActualizada.first
        categoriaActualizadaConGastos?.gastos = try await GastosCRUD.singleton.obtenerGastos(forCategoriaId: id)
        
        // Devolver la categoría actualizada
        return categoriaActualizada.first ?? CategoriaDTO2(id: id, nombre: nuevoNombre, theme: nuevoTheme, mesId: 0)
    }
}

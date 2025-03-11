//
//  GastosCRUD.swift
//  GestionGastos
//
//  Created by Tania Bajo García on 9/3/25.
//

import Foundation

class GastosCRUD {
    static let singleton = GastosCRUD()

    private let supabase = SupabaseManager.singleton.client

    private init() {}
    
    // En GastosCRUD
    func obtenerGastos(forCategoriaId categoriaId: Int64) async throws -> [GastoDTO2] {
        let gastosResponse: [GastoDTO2] = try await supabase
            .from("gastos")
            .select("*")
            .eq("categoria_id", value: String(categoriaId)) // Filtrar por categoria_id
            .execute()
            .value
        
        return gastosResponse
    }

    func crearGasto(titulo: String, descripcion: String, fecha: Date, importe: Float, categoriaId: Int64) async throws -> GastoDTO2 {
        // Crear el nuevo gasto
        let nuevoGasto = GastoDTO2(id: 0, titulo: titulo, descripcion: descripcion, fecha: fecha, importe: importe, categoriaId: categoriaId)
        
        // Insertar el gasto en la base de datos
        let gastoResponse: [GastoDTO2] = try await supabase
            .from("gastos")
            .insert(nuevoGasto) // Aquí pasamos un array de diccionarios con los valores codificados
            .execute()
            .value
        
        // Devolver el gasto insertado
        return gastoResponse.first ?? nuevoGasto
    }

    
    // En GastosCRUD
    func modificarGasto(id: Int64, nuevoTitulo: String, nuevaDescripcion: String, nuevaFecha: Date, nuevoImporte: Float) async throws -> GastoDTO2 {
        // Convertir la fecha a string en formato ISO
        let fechaFormateada = ISO8601DateFormatter().string(from: nuevaFecha)
        
        // Convertir el importe a String
        let importeString = String(nuevoImporte)
        
        // Actualizar el gasto con los nuevos datos
        let gastoActualizado: [GastoDTO2] = try await supabase
            .from("gastos")
            .update([
                "titulo": nuevoTitulo,
                "descripcion": nuevaDescripcion,
                "fecha": fechaFormateada,
                "importe": importeString
            ])
            .eq("id", value: String(id)) // Filtrar por ID del gasto
            .execute()
            .value
        
        // Devolver el gasto actualizado
        return gastoActualizado.first ?? GastoDTO2(id: id, titulo: nuevoTitulo, descripcion: nuevaDescripcion, fecha: nuevaFecha, importe: nuevoImporte, categoriaId: 0)
    }
}

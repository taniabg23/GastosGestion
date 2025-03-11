//
//  SupabaseManager.swift
//  GestionGastos
//
//  Created by Tania Bajo García on 9/3/25.
//

import Foundation
import Supabase

class SupabaseManager {
    static let singleton = SupabaseManager()

    let client: SupabaseClient

    private init() {
        let supabaseUrl = URL(string: "https://udqnzcinqdrptfsfvbve.supabase.co")!
        let supabaseKey = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InVkcW56Y2lucWRycHRmc2Z2YnZlIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDEzNzU5NDYsImV4cCI6MjA1Njk1MTk0Nn0.EE7w64UE6a4OpvFI5XkIBMbLdY_4MJsq8sWXySLqJfw"

        self.client = SupabaseClient(supabaseURL: supabaseUrl, supabaseKey: supabaseKey)
    }
}

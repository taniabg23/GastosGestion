//
//  UserSession.swift
//  GestionGastos
//
//  Created by Tania Bajo García on 9/3/25.
//

import Foundation

class UserSession {
    static let singleton = UserSession()

    var userId: Int64?

    private init() {}

    func iniciarSesion(userId: Int64) {
        self.userId = userId
        print("🔹 Sesión iniciada para el usuario: \(userId)")
    }

    func cerrarSesion() {
        self.userId = nil
        print("🔹 Sesión cerrada")
    }
}

//
//  ThemePicker.swift
//  Scrumdinger
//
//  Created by Tania Bajo García on 5/12/23.
//

import SwiftUI

struct ThemePicker: View {
    @Binding var selection : Theme
    
    var body: some View {
        Picker("Tema", selection: $selection){
            ForEach(Theme.allCases) { theme in
                ThemeView(theme: theme)
                    .tag(theme)
            }
        }
        .pickerStyle(.navigationLink)
    }
}

struct ThemePicker_Previews: PreviewProvider {
    static var previews: some View {
        ThemePicker(selection: .constant(.bubblegum))
    }
}

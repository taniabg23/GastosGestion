
import SwiftUI

struct CardView: View {
    let category: CategoriaDTO
    var body: some View {
        VStack(alignment: .leading) {
            Text(category.nombre)
                .font(.headline)
                .accessibilityAddTraits(.isHeader)
            .font(.caption)
            .font(.caption)
        }
        .padding()
        .foregroundColor(category.theme.accentColor)
    }
}

struct CardView_Previews: PreviewProvider {
    static var category = CategoriaDTO(nombre: "Alimentación", gastos: [], theme: Theme.indigo)
    static var previews: some View {
        CardView(category: category)
            .background(category.theme.mainColor)
            .previewLayout(.fixed(width: 400, height: 60))
    }
}

import SwiftUI

struct CompactTitleView: View {
    @Binding var recipe: Recipe

    var body: some View {
        Spacer()
        VStack {
            Text(recipe.title)
                .font(.title2)
            StarRating(rating: $recipe.rating)
            Text(recipe.subTitle)
                .font(.subheadline)
        }
        Spacer()
    }
}

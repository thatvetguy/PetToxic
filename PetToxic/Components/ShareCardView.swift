import SwiftUI

struct ShareCardView: View {
    let imageAssetName: String

    var body: some View {
        Image(imageAssetName)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 1024, height: 1024)
    }
}

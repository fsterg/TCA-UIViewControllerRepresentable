import ComposableArchitecture
import SwiftUI

@main
struct TCA_UIViewControllerRepresentableApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(
                store: Store(
                    initialState: ContentReducer.State(),
                    reducer: ContentReducer()
                )
            )
        }
    }
}

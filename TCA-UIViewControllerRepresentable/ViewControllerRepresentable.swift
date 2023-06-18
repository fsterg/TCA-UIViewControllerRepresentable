import ComposableArchitecture
import SwiftUI
import UIKit

struct ViewControllerRepresentable: UIViewControllerRepresentable {

    typealias UIViewControllerType = ViewController

    let viewStore: ViewStoreOf<ContentReducer>

    func makeUIViewController(context: Context) -> ViewController {
        let vc = ViewController(nibName: nil, bundle: nil)
        vc.delegate = context.coordinator
        return vc
    }

    func updateUIViewController(_ uiViewController: ViewController, context: Context) {
        // UILabel is properly updated through the `viewStore.string` binding.
        // This binding can change either directly (through the `buttonTapped` TCA action)
        // or from UIKit, using the `didTapButton` delegate function and the Coordinator.
        uiViewController.setLabelText(string: viewStore.string)


        // The view controller has some drag & drop functionality.
        // I'd like to call `startDragging` from a TCA action
        // and also use a dependency in this function's callback to know if it's possible to "drop":

        /* Doesn't compile
        uiViewController.startDragging(viewStore.string) { location in
            return client.canDrop(viewStore.string, location)
        }
         */
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(stringBinding: viewStore.binding(\.$string))
    }

    class Coordinator: ViewControllerDelegate {

        var stringBinding: Binding<String>

        init(stringBinding: Binding<String>) {
            self.stringBinding = stringBinding
        }

        func didTapButton(date: Date) {
            let formatted = date.formatted(.dateTime.second())
            stringBinding.wrappedValue = formatted
        }
    }

}

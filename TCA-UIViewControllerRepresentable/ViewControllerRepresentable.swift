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
        uiViewController.setLabelText(string: viewStore.string)
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

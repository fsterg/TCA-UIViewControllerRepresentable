import ComposableArchitecture
import SwiftUI

struct ContentReducer: ReducerProtocol {
    struct State: Equatable {
        @BindingState var string: String = "---"
    }

    enum Action: BindableAction {
        case binding(BindingAction<State>)
        case buttonTapped
    }

    public var body: some ReducerProtocol<State, Action> {
        BindingReducer()
        Reduce(self.core)
    }

    func core(state: inout State, action: Action) -> EffectTask<Action> {
        switch action {
        case .binding:
            return .none
        case .buttonTapped:
            state.string = Date().formatted(.dateTime.second())
            return .none
        }
    }
}

struct ContentView: View {
    let store: StoreOf<ContentReducer>

    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            VStack {
                Text("TCA state: \(viewStore.string)")
                Button {
                    viewStore.send(.buttonTapped)
                } label: {
                    Text("TCA action")
                }
                Text("👆 TCA View 👆").font(.caption)
                Divider()
                Text("👇 ViewControllerRepresentable 👇").font(.caption)
                ViewControllerRepresentable(viewStore: viewStore)
            }
            .padding()
            .background(.gray)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(
            store: Store(
                initialState: ContentReducer.State(),
                reducer: ContentReducer()
            )
        )
    }
}

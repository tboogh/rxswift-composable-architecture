import SwiftUI
import RxSwift

@available(iOS 13, *)
public class ObservedStore<State: Equatable, Action>: ObservableObject{

    public let store: ViewStore<State, Action>
    private var disposable: Disposable?

    public init(store: Store<State, Action>){
        self.store = ViewStore(store)
        disposable = self.store.observable.subscribe(onNext: { [weak self] _ in
            guard let self = self else { return }
            self.objectWillChange.send()
        })
    }
}

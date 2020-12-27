import Foundation


public class Bindable<T> {
    public typealias Listener = (T) -> Void
    private var listener: Listener?
    
    public var value: T {
        didSet {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else {
                    return
                }
                self.listener?(self.value)
            }
        }
    }
    
   public init(_ value: T) {
        self.value = value
    }
    
   public func bind(listener: Listener?) {
        self.listener = listener
        listener?(value)
    }
}

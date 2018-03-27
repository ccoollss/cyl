import Foundation

class DelayedTask {
    private var action: () -> Void
    private var isCancelled = false

    init(seconds: Double, action: @escaping () -> Void) {
        self.action = action
        exec(after: seconds)
    }

    deinit {
        cancel()
    }

    private func exec(after seconds: Double) {
        let time = DispatchTime.now() + Double(Int64(seconds * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: time) {
            if !self.isCancelled {
                self.action()
            }
        }
    }

    func cancel() {
        isCancelled = true
    }
}

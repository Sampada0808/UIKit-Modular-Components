import Foundation
import UIKit

extension UIView{
    
    
    func fadeIn(duration: TimeInterval = 0.3, completion: (() -> Void)? = nil) {
            self.alpha = 0
            self.isHidden = false
            UIView.animate(withDuration: duration, animations: {
                self.alpha = 1
            }, completion: { _ in
                completion?()
            })
        }

        func fadeOut(duration: TimeInterval = 0.3, completion: (() -> Void)? = nil) {
            UIView.animate(withDuration: duration, animations: {
                self.alpha = 0
            }, completion: { _ in
                self.isHidden = true
                completion?()
            })
        }
}

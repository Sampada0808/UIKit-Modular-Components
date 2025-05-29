import Foundation
import UIKit

struct Goals{
    let id  = UUID()
    var title : String
    var notes : String?
    var image : UIImage?
    var isCompleted : Bool
    var date : String
}

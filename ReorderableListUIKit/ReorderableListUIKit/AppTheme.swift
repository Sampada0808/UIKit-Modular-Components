import Foundation


enum AppTheme {
    case light, dark
}


class ThemeManager{
    static let shared = ThemeManager()
    var currentTheme : AppTheme = .light
}

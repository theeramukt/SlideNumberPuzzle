import SwiftUI

@main
struct SlideNumberPuzzleApp: App {
    var body: some Scene {
        WindowGroup {
            @StateObject var game = SlideNumberPuzzleViewModel()
            ContentView(viewModel: game)
        }
    }
}

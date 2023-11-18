import SwiftUI

class SlideNumberPuzzleViewModel: ObservableObject {
    @State static var numbers = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15"]
    
    @Published private var model = SlideNumberPuzzleModel<String>(numberOfCards: numbers.count) { (index) in numbers[index] }
    
    var cards: [SlideNumberPuzzleModel<String>.Card] { model.cards }
    func move(_ card: SlideNumberPuzzleModel<String>.Card) {
        model.move(card)
    }
    
    func shuffle() {
        model.shuffle()
    }
}

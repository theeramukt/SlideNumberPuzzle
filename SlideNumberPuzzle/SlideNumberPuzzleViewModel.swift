import SwiftUI

class SlideNumberPuzzleViewModel: ObservableObject {
    @State static var numbers = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15"]
    
    @Published private var model = SlideNumberPuzzleModel<String>(numberOfCards: numbers.count) { (index) in numbers[index] }
    
    @Published var isWin = false
    
    private var _moveCount: Int = 0
        
    var moveCount: Int {
        return _moveCount
    }
    
    var cards: [SlideNumberPuzzleModel<String>.Card] { model.cards }
    func move(_ card: SlideNumberPuzzleModel<String>.Card) {
        model.move(card)
        _moveCount += 1
        updateWinState()
    }
    
    func shuffle() {
        model.shuffle()
        _moveCount = 0
        isWin = false
    }
    
    private func updateWinState() {
        isWin = checkWin()
    }
    
    private func checkWin() -> Bool {
        let expectedValues = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "0"]
        return cards.enumerated().allSatisfy { (index, card) in
            card.id == expectedValues[index]
        }
    }
}

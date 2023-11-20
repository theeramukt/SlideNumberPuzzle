import Foundation

struct SlideNumberPuzzleModel<CardContent> where CardContent: Equatable {
    private(set) var cards: [Card]
    
    init(numberOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = []
        for index in 0..<numberOfCards {
            cards.append(Card(content: cardContentFactory(index), id: "\(index)"))
        }
        cards.shuffle()
    }
    
    var indexOfTheOneAndOnlyFaceUpCard: Int?
    var _moveCount: Int = 0
    
    mutating func move(_ card: Card) {
           guard let index = cards.firstIndex(where: { $0.id == card.id }),
                  card.id != "0" else { return }

           let row = index / 4
           let col = index % 4

           let possibleMoves = [
               (row - 1, col),
               (row + 1, col),
               (row, col - 1),
               (row, col + 1)
           ]
        
           for (r, c) in possibleMoves {
               if r >= 0 && r < 4 && c >= 0 && c < 4 {
                   let newIndex = r * 4 + c
                   if cards[newIndex].id == "0" {
                           cards.swapAt(index, newIndex)
                       break
                   }
               }
           }
       }
    
    mutating func shuffle() {
        cards.shuffle()
    }
    
    struct Card: Equatable, Identifiable {
        var isFaceUp = true
        var isMatched = false
        let content: CardContent
        var id: String

    }
}

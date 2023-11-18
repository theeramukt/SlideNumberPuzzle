import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: SlideNumberPuzzleViewModel
    
    var body: some View {
        VStack {
            Button("New Game") {
                viewModel.shuffle()
            }
            Spacer()
            ScrollView {
                cards
                    .animation(.default, value: viewModel.cards)
            }
            Spacer()
        }
        .padding()
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 80))]) {
            ForEach(viewModel.cards) { card in
                CardView(card: card)
                    .aspectRatio(1, contentMode: .fit)
                    .onTapGesture {
                        viewModel.move(card)
                    }
            }
        }
        .foregroundColor(.orange)
    }
}

struct CardView: View {
    let card: SlideNumberPuzzleModel<String>.Card
    
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            Group {
                base.foregroundColor(.white)
                base.strokeBorder(lineWidth: 2)
                Text(card.content).font(.largeTitle)
            }
            .opacity(card.isFaceUp ? 1 : 0)
            base.opacity(card.isFaceUp ? 0 : 1)
        }
        .opacity(card.isFaceUp || !card.isMatched ? 1 : 0)
        .opacity(card.id == "0" ? 0 : 1)
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: SlideNumberPuzzleViewModel())
    }
}

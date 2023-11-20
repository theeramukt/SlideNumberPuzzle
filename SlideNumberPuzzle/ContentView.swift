import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: SlideNumberPuzzleViewModel
    
    var body: some View {
        VStack {
            Button(action: {
                viewModel.shuffle()
            }) {
                Text("New Game")
                    .foregroundColor(.green)
                    .fontWeight(.bold)
                    .font(.title);
            }
            
            Spacer()
            ScrollView {
                cards
                    .animation(.default, value: viewModel.cards)
            }
            Spacer()
          
            VStack {
                Text(viewModel.isWin ? "You Won!!!" : "")
                    .foregroundColor(.red)
                    .padding()
                    .fontWeight(.bold)
                    .font(.title);

                Text("Moves: \(viewModel.moveCount)")
                    .foregroundColor(.blue)
                    .fontWeight(.bold)
                    .font(.title);
                
            }
            

        }
        .padding()
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 80))]) {
            ForEach(viewModel.cards) { card in
                CardView(card: card)
                    .padding(0.5)
                    .bold()
                    
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
                base.strokeBorder(lineWidth: 3)
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

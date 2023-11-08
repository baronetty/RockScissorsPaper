import SwiftUI

struct ContentView: View {
    
    @State private var computerChoice = ["Rock", "Scissors", "Paper"].shuffled()
    @State private var computerChoiceRandom = Int.random(in: 0...2)
    
    @State private var winOrLose = ["Win", "Lose"]
    @State private var winOrLoseRandom = Int.random(in: 0...1)
    
    @State private var playerChoice = ["Paper", "Rock", "Scissor"]
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    
    @State private var endOfGame = false
    @State private var rounds = 0
    
    var body: some View {
        VStack {
            Spacer()
            
            Text(computerChoice[computerChoiceRandom])
                .font(.title)
            Spacer()
            
            Text(winOrLose[winOrLoseRandom])
                .font(.title)
            
            Spacer()
            Divider()
            Spacer()
            
            ForEach(0..<3) { number in
                Button {
                    choiceTapped(playerChoice[number])
                    askQuestion()
                } label: {
                    Text(playerChoice[number])
                }
                .font(.title2)
                .buttonStyle(.borderedProminent)
                .clipShape(.capsule)
                .shadow(radius: 5)
                .padding(10)
            }
            
            Spacer()
            Spacer()
            
            Text("Score: \(score)")
                .font(.title.bold())
            
            Spacer()
        }
        .padding()
        .alert("End of Game", isPresented: $endOfGame) {
            Button("Repeat", action: repeatGame)
        } message: {
            Text("""
                Your Score: \(score)
                Want to start a new game?
                """)
        }
    }
        
    
    func choiceTapped(_ playerChoice: String) {
        let computerChoice = self.computerChoice[computerChoiceRandom]
        let winOrLose = self.winOrLose[winOrLoseRandom]
        
        if playerChoice == computerChoice {
            rounds += 1
        } else if (playerChoice == "Rock" && computerChoice == "Scissors" && winOrLose == "Win") ||
                   (playerChoice == "Paper" && computerChoice == "Rock" && winOrLose == "Win") ||
                   (playerChoice == "Scissor" && computerChoice == "Paper" && winOrLose == "Win") || (playerChoice == "Scissor" && computerChoice == "Rock" && winOrLose == "Lose") ||
                    (playerChoice == "Rock" && computerChoice == "Paper" && winOrLose == "Lose") ||
                    (playerChoice == "Paper" && computerChoice == "Scissor" && winOrLose == "Lose") {
            score += 1
            rounds += 1
        } else {
            score -= 1
            rounds += 1
        }
        
        if rounds == 10 {
            rounds = 0
            endOfGame = true
        }
        
        showingScore = true
    }

    
    func askQuestion () {
        computerChoice.shuffle()
        computerChoiceRandom = Int.random(in: 0...2)
        winOrLoseRandom = Int.random(in: 0...1)
    }
    func repeatGame() {
        askQuestion()
        score = 0
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

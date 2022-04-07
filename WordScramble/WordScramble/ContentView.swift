//
//  ContentView.swift
//  WordScramble
//
//  Created by Rolando Garcia on 04/04/22.
//
// TODO: Test this part
import SwiftUI

struct ContentView: View {
    // Words to use in this project taken from a file
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    @State private var score = 0
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    TextField("Enter your word", text: $newWord)
                        .autocapitalization(.none)
                }
                
                Section {
                    ForEach(usedWords, id: \.self) { word in
                        HStack {
                            Image(systemName: "\(word.count).circle")
                            Text(word)
                        }
                    }
                }
            }
            // How to get the size of the screen
            // https://stackoverflow.com/a/27473572
            .toolbar {
                HStack {
                    Text("Score: \(score)")
                        .padding()
                    Spacer()
                    Button("Change word") {
                        startGame()
                    }.padding()
                }.frame(width:  UIScreen.main.bounds.size.width)
                    
            }
            .navigationTitle(rootWord)
            // When press the enter button
            .onSubmit(addNewWord)
            // Start game when the application does
            .onAppear(perform: startGame)
            .alert(errorTitle, isPresented: $showingError) {
                Button("OK", role: .cancel) { }
            } message: {
                Text(errorMessage)
            }
        }
    }
    
    func addNewWord() {
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard answer.count > 0 else {
            wordError(title: "Missing word", message: "You have to put a word into the field")
            return }
        
        guard isOriginal(word: answer) else {
            wordError(title: "Word used already", message: "Be more original!")
            return
        }
        
        guard isPossible(word: answer) else {
            wordError(title: "Word not possible", message: "You can't spell that word from '\(rootWord)'!")
            return
        }
        
        guard isReal(word: answer) else {
            wordError(title: "Word not recognized", message: "You can't just make them up, you know!")
            return
        }
        
        guard isTooShort(word: answer) else {
            wordError(title: "Word too short", message: "Should be more large than it")
            return
        }
        
        // Add an animation when the user wants to add something to the list
        withAnimation {
            usedWords.insert(answer, at: 0)
        }
        
        newWord = ""
        score += 1
    }
    
    func startGame() {
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordsURL) {
                let allWords = startWords.components(separatedBy: "\n")
                rootWord = allWords.randomElement() ?? "silkworm"
                return
            }
        }
        // Stops execution and gives a message
        fatalError("Could not load start.txt from bundle.")
    }
    
    func isOriginal(word: String) -> Bool {
        !usedWords.contains(word)
    }
    
    func isPossible(word: String) -> Bool {
        var tempWord = rootWord
        
        for letter in word {
            if let pos = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: pos)
            } else {
                return false
            }
        }
        
        return true
    }
    
    func isReal(word: String) -> Bool {
        // An object to check a string (usually the text of a document) for misspelled words.
        let checker = UITextChecker()
        // A structure used to describe a portion of a series, such as characters in a string or objects in an array.
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        return misspelledRange.location == NSNotFound
    }
    
    func isTooShort(word : String)-> Bool{
        if word.count <= 3 {
            return false
        }
        return true
    }
    
    // Show an alert when something is bad
    func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

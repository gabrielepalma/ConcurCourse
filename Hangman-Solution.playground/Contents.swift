import UIKit
import Foundation
import PlaygroundSupport

// We open the file with the list of words and select the word to play with
let fileURL = Bundle.main.url(forResource: "words-small", withExtension: "txt")
let content = try String(contentsOf: fileURL!, encoding: String.Encoding.utf8)
let lines = content.components(separatedBy: NSCharacterSet.newlines)

// Change the index to select a new word
let index = 200
let word = lines[index].lowercased()

// Two legs, two arms, a body and the head
let maxFails = 6

// The player guesses. Append more characters in the array to play the game
var guesses : [Character] = []
guesses.append("y")
guesses.append("e")
guesses.append("t")
guesses.append("p")
guesses.append("v")
guesses.append("z")
guesses.append("q")

// add your guesses here

// If you prefer a more compact form:
//var guesses : [Character] = ["a", "b", "c", "d", "e"]

// Here we implement the game logic, to determine if the player has won or lost and compute game state information

// Has the game been won?
var gameHasBeenSuccesfullyCompleted = true

// The string to display in the UI that represent the game state
var stringState = " "

// An array that will contain the letters that have been wrongly guessed
var failedGuesses = guesses

for character in word {
    if guesses.contains(character) {
        stringState.append(character)

        // This letter was a successful guess, if we haven't already, we remove it from the list of failed guesses
        if let indexToRemove = failedGuesses.index(of: character) {
            failedGuesses.remove(at: indexToRemove)
        }
    }
    else {
        // We found a letter that hasn't been guessed, the game is not over
        gameHasBeenSuccesfullyCompleted = false
        stringState.append("_")
    }
    stringState.append(" ")
}
print(stringState)

// The letters remaining in the failedGuesses array represents the failures count
let fails = failedGuesses.count

var text = ""

if gameHasBeenSuccesfullyCompleted && fails < maxFails {
   text = "Congratulations you guessed the word!"
}
else if fails < maxFails {
    text = "Keep trying, \(maxFails - fails) more attempts available"
}
else if fails >= maxFails {
    text = "Too many failed guesses, you lost!"
}
print(text)


// Now let's draw the game in a UIView and display it in the PlaygroundPage
let view = UIView(frame: CGRect(x: 0, y: 0, width: 400, height: 600))
view.backgroundColor = .white

// Convenience method to add labels to a view
func addLabel(view: UIView, rect: CGRect, text: String, color: UIColor) {
    let label = UILabel()
    label.frame = rect
    label.textAlignment = .center
    label.text = text
    label.textColor = color
    view.addSubview(label)
}

// We add the game state information as labels
addLabel(view: view,
         rect: CGRect(x: 0, y: 400, width: 400, height: 100),
         text: stringState,
         color: .black)

addLabel(view: view,
         rect: CGRect(x: 0, y: 500, width: 400, height: 100),
         text: text,
         color: gameHasBeenSuccesfullyCompleted ? .black : ( fails >= maxFails ? .red : .black ))

// We want to also draw the gallows
class TheGallows : UIView {

    // Convenience method to add a line in the (specified) context
    func line(fromPoint: CGPoint, toPoint: CGPoint, inContext: CGContext?) {
        inContext?.move(to: fromPoint)
        inContext?.addLine(to: toPoint)
    }

    // Convenience method to add an oval in the (current) context
    func oval(inRect: CGRect){
        var path = UIBezierPath()
        path = UIBezierPath(ovalIn: inRect)
        path.lineWidth = 1.5
        path.stroke()
        path.fill()
    }

    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        // Background
        context?.setFillColor(UIColor.white.cgColor)
        context?.fill(rect)

        // Gallow
        // A bit thicker, it needs to be robust
        context?.setLineWidth(10.0)
        context?.setStrokeColor(UIColor.black.cgColor)
        line(fromPoint: CGPoint(x:200, y: 380), toPoint: CGPoint(x: 300, y: 380), inContext: context)
        line(fromPoint: CGPoint(x:250, y: 380), toPoint: CGPoint(x: 250, y: 200), inContext: context)
        line(fromPoint: CGPoint(x:250, y: 205), toPoint: CGPoint(x: 150, y: 205), inContext: context)
        context?.strokePath()

        // Person
        context?.setLineWidth(3.0)
        line(fromPoint: CGPoint(x:160, y: 200), toPoint: CGPoint(x: 160, y: 258), inContext: context)

        if fails > 1 {
            line(fromPoint: CGPoint(x:160, y: 260), toPoint: CGPoint(x: 160, y: 300), inContext: context)
        }
        if fails > 2 {
            line(fromPoint: CGPoint(x:160, y: 260), toPoint: CGPoint(x: 180, y: 280), inContext: context)
        }
        if fails > 3 {
            line(fromPoint: CGPoint(x:160, y: 260), toPoint: CGPoint(x: 140, y: 280), inContext: context)
        }
        if fails > 4 {
            line(fromPoint: CGPoint(x:160, y: 300), toPoint: CGPoint(x: 180, y: 320), inContext: context)
        }
        if fails > 5 {
            line(fromPoint: CGPoint(x:160, y: 300), toPoint: CGPoint(x: 140, y: 320), inContext: context)
        }
        context?.strokePath()

        // We draw it last so the head drawing overlaps on top
        if fails > 0 {
            oval(inRect: CGRect(x: 160, y: 252, width: 18, height: 16))
        }
    }
}

// We instantiate the gallows and add it to the playground display
// Open the display: View -> Assistant Editor -> Show Assistant Editor
let theGallows = TheGallows(frame: CGRect(x: 0, y: 0, width: 400, height: 400))
view.addSubview(theGallows)
theGallows.setNeedsDisplay()
PlaygroundPage.current.liveView = view

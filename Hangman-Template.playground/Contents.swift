//: Playground - noun: a place where people can play

import UIKit
import Foundation
import PlaygroundSupport

/*

Hangman
 https://en.wikipedia.org/wiki/Hangman_(game)

 A word is selected. You guess the characters. As you guess characters that are not in the word an hanging man is drawn. After six wrong guesses you lose. If you can guess the word right you win

 Two file containing a list of words are given (open the left panel with the buttons at the top right, then look in the Resources folder). You can open it in the code and select a word at an index of choice.

 Remember that the Playgroung is different than your typical console application: the code is continuosly interpreted and all variable values are displayed for your convenience in the panel to your right. The text output is visible at the bottom (you can use print()). Unfortunately there is no interactive input as you would have in a console application, but you can simulate the player choices by keeping the guesses in a data structure, such as an array, and update it as the player make guesses. Every time you change any code, the playground will run again.
 */

/*
 First part: Setting up the game and identifying the game state

 Rough guildeline:
 - open the file and select a word:
        - to read the file you can use something like:
             let fileURL = Bundle.main.url(forResource: "words-small", withExtension: "txt")
             let content = try String(contentsOf: fileURL!, encoding: String.Encoding.utf8)
        - split the file using string functions
        - select a word at a chosen index
 - define a structure that will contain the player guesses
        - i.e. an array of characters
 - solve the game state
        - has the player guessed the entire word?
        - how many times the player has guessed a character that was not present in the word?
        - in hangman you can typically fail 6 times: two legs, two arms, a body and the head
        - display a string that only shows guessed characters and replace everything else with an underline
        - you can iterate characters in a String using "for c in string"
*/

/*
 Second part: Drawing the gallows

 Some boilerplate code to help you:

 You should create a view using something like:

    let view = UIView(frame: CGRect(x: 0, y: 0, width: 400, height: 600))

 Here is a convenience method to add a label to a view

    func addLabel(view: UIView, rect: CGRect, text: String, color: UIColor) {
        let label = UILabel()
        label.frame = rect
        label.textAlignment = .center
        label.text = text
        label.textColor = color
        view.addSubview(label)
    }

 To draw something more complex we will need to subclass a UIView and override its draw function
 Something like:

    class CustomView : UIView {
        override func draw(_ rect: CGRect) {
            let context = UIGraphicsGetCurrentContext()

            // Color the background
            context?.setFillColor(UIColor.white.cgColor)
            context?.fill(rect)

            // sample code to draw a line (using CGContext functions)
            context?.setLineWidth(10.0)
            context?.setStrokeColor(UIColor.black.cgColor)
            context?.move(to: CGPoint(x:200, y: 380))
            context?.addLine(to: CGPoint(x: 300, y: 380))
            context?.strokePath()

            // sample code to draw a circle (using UIBezierPath functions, for more variety)
            var path = UIBezierPath()
            path = UIBezierPath(ovalIn: CGRect(x: 10, y: 10, width: 30, height: 30))
            path.lineWidth = 1.5
            path.stroke()
            path.fill()
        }
    }

 This boilerplate allows you to create your custom view, add it to you playground and draw it

    let customView = CustomView(frame: CGRect(x: 0, y: 0, width: 400, height: 400))
    view.addSubview(customView)
    customView.setNeedsDisplay()
    PlaygroundPage.current.liveView = view

 Remember to open the playground live feed with View -> Assistant Editor -> Show Assistant Editor
*/

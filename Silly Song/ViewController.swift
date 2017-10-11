//
//  ViewController.swift
//  Silly Song
//
//  Created by James Dellinger on 10/10/17.
//  Copyright © 2017 James Dellinger. All rights reserved.
//

import UIKit

// Function for removing any consonants that appear before the first vowel
// of a string and returning a lowercase version of the resulting string.
func shortNameFromName(_ name: String) -> String {
    // Initialize local name variable and set to all lowercase
    var name = name.lowercased()
    // Check to see if name is all consonsants
    // All the vowels in English
    let vowelString = "aeiou"
    // Number of vowels in the name
    var numberOfVowels = 0
    for letter in name {
        if vowelString.contains(letter) {
            // For each vowel in the name, increase counter by 1
            numberOfVowels += 1
        }
    }
    // If there are no vowels, just return lowercased name
    // string as-is
    if numberOfVowels == 0 {
        return name
    } else {
        // If there are vowels, we remove all consonants that come
        // before the first vowel
        // All the consonants in English
        let consonantString = "qwrtypsdfghjklzxcvbnm"
        while consonantString.contains(String(name[name.startIndex])) {
            // As long as the first letter of the name is a consonant
            // we'll remove it until the first letter of the name is a vowel
            name = name.substring(from: name.index(after: name.startIndex))
        }
        // Return the all lowercase name beginning with the first vowel
        return name
    }
}

// Silly song template represented as a string
let bananaFanaTemplate = [
    "<FULL_NAME>, <FULL_NAME>, Bo B<SHORT_NAME>",
    "Banana Fana Fo F<SHORT_NAME>",
    "Me My Mo M<SHORT_NAME>",
    "<FULL_NAME>"].joined(separator: "\n")

// Function for inserting the full name and shortened, lower-cased name
// (missing all the consonants before the first vowel, if any) into the
// template and returning the Silly Song lyrics customized for a given name.
func lyricsForName(lyricsTemplate: String, fullName: String) -> String {
    // Call our shortNameFromName function to get the name without
    // any consonants that appear before the first vowel.
    let shortName = shortNameFromName(fullName)
    // Insert the full name
    let fullNameReplacedLyrics = lyricsTemplate.replacingOccurrences(of: "<FULL_NAME>", with: fullName)
    //Insert the shortened name
    let shortAndFullNameReplacedLyrics = fullNameReplacedLyrics.replacingOccurrences(of: "<SHORT_NAME>", with: shortName)
    //Return the final silly lyrics customized for the individual's name.
    return shortAndFullNameReplacedLyrics
}

class ViewController: UIViewController {
    // Text field where user enters their name
    @IBOutlet weak var nameField: UITextField!
    // Text view for displaying lyrics to the silly song
    // for the user's name
    @IBOutlet weak var lyricsView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameField.delegate = self
    }

    // Trigger text field reset when editing begins
    @IBAction func reset(_ sender: Any) {
        nameField.text = ""
        lyricsView.text = ""
    }
    
    //Trigger lyrics display when text field editing ends
    @IBAction func displayLyrics(_ sender: Any) {
        let enteredName = nameField.text
        if enteredName != "" {
            lyricsView.text = lyricsForName(lyricsTemplate: bananaFanaTemplate, fullName: enteredName!)
        }
    }
    
}

// MARK: - UITextFieldDelegate
extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
}


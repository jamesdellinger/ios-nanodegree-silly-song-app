//
//  ViewController.swift
//  Silly Song
//
//  Created by James Dellinger on 8/26/17.
//  Copyright © 2017 James Dellinger. All rights reserved.
//

import UIKit

//Function for removing any consonants that appear before the first vowel of a string and returning a lowercase version of the resulting string.
func shortNameFromName(_ name: String) -> String {
    var name = name.lowercased() //Initialize local name variable and set to all lowercase
    let consonantString = "qwrtypsdfghjklzxcvbnm" //List of all the consonants in English
    while consonantString.contains(String(name[name.startIndex])) { //As long as the first letter of the name is a consonant,
        name = name.substring(from: name.index(after: name.startIndex)) //we'll remove it until the first letter of the name is a vowel
    }
    return name //Return the all lowercase name beginning with the first vowel.
}

//Silly song template represented as a string
let bananaFanaTemplate = [
    "<FULL_NAME>, <FULL_NAME>, Bo B<SHORT_NAME>",
    "Banana Fana Fo F<SHORT_NAME>",
    "Me My Mo M<SHORT_NAME>",
    "<FULL_NAME>"].joined(separator: "\n")

//Function for inserting the full name and shortened name (missing all the consonants before the first vowel) into the template and returning the Silly Song lyrics customized for a given name.
func lyricsForName(lyricsTemplate: String, fullName: String) -> String {
    let shortName = shortNameFromName(fullName) //Call our shortNameFromName function to get the name without any consonants that appear before the first vowel.
    let fullNameReplacedLyrics = lyricsTemplate.replacingOccurrences(of: "<FULL_NAME>", with: fullName) //Insert the full name
    let shortAndFullNameReplacedLyrics = fullNameReplacedLyrics.replacingOccurrences(of: "<SHORT_NAME>", with: shortName) //Insert the shortened name
    return shortAndFullNameReplacedLyrics //Return the final silly lyrics customized for the individual's name.
}

class ViewController: UIViewController {
    
    @IBOutlet weak var nameField: UITextField!
    
    @IBOutlet weak var lyricsView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func reset(_ sender: Any) {
        nameField.text = ""
        lyricsView.text = ""
    }
    
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


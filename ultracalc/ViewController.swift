//
//  ViewController.swift
//  ultracalc
//
//  Created by Cor Pruijs on 29-06-14.
//  Copyright (c) 2014 Cor Pruijs. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var resultLabel: UILabel! = UILabel()
    @IBOutlet var currentOperationLabel: UILabel! = UILabel()
    
    var previousNumberString:NSString = ""
    var enteredNumberString:NSString = ""
    var currentOperation:NSString = ""
    var enteredNumberIsPreviousNumber = false
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.resultLabel.text = "0"
        self.currentOperationLabel.text = ""
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func numberButtonPressed(sender: UIButton) {
        if self.enteredNumberIsPreviousNumber {
            self.enteredNumberString = ""
            self.enteredNumberIsPreviousNumber = false
        }
        
        if let titl = sender.currentTitle {
            self.enteredNumberString = self.enteredNumberString + sender.currentTitle!
        }
        self.resultLabel.text = enteredNumberString
    }
    
    @IBAction func functionButtonPressed(sender: UIButton) {
        if let buttonName = sender.restorationIdentifier? {
            self.calculateAndUpdate()
            switch buttonName {
            case "add":
                println("add")
                self.currentOperation = "add"
                
            case "subtract":
                println("subtract")
                self.currentOperation = "subtract"
                
            case "multiply":
                println("multiply")
                self.currentOperation = "multiply"
                
            case "divide":
                println("divide")
                self.currentOperation = "divide"
                
            case "clear":
                println("clear")
                self.currentOperation = "clear"
                
            case "equals":
                println("equals")
                self.currentOperation = "equals"
            
            default:
                println("ERROR: Invalid sender.currentTitle")
            }
            
            self.enteredNumberIsPreviousNumber = true
            
            if self.currentOperation == "clear" || self.currentOperation == "equals" {
                self.currentOperationLabel.text = ""
            } else  {
                self.currentOperationLabel.text = "\(self.currentOperation)"
            }
            
            if self.currentOperation == "clear" {
                self.currentOperation = ""
                self.previousNumberString = ""
                self.enteredNumberString = ""
                
                self.resultLabel.text = "0"
                self.currentOperationLabel.text = ""
            }
        }
    }
    
    func previous() -> Int {
        return self.previousNumberString.integerValue;
    }
    
    func calculateAndUpdate() {
        println(self.enteredNumberString)
        switch self.currentOperation {
        case "":
            self.previousNumberString = self.enteredNumberString
            
        case "add":
            self.previousNumberString = String(self.previousNumberString.integerValue + self.enteredNumberString.integerValue)
            
        case "subtract":
            self.previousNumberString = String(self.previousNumberString.integerValue - self.enteredNumberString.integerValue)
            
        case "multiply":
            self.previousNumberString = String(self.previousNumberString.integerValue * self.enteredNumberString.integerValue)

        case "divide":
            if self.enteredNumberString.integerValue == 0 {
                self.previousNumberString = "Devide by 0 again, i dare you, i double dare you motherfucker!"
            } else {
                self.previousNumberString = String(self.previousNumberString.integerValue / self.enteredNumberString.integerValue)
            }
            
        case "equals":
            self.previousNumberString = self.enteredNumberString
            
        default:
            println("ERROR: Invalid self.currentOperation")
        }
        
        self.enteredNumberString = self.previousNumberString
        self.resultLabel.text = self.previousNumberString
    }
}
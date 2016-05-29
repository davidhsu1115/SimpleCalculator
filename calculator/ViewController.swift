//
//  ViewController.swift
//  calculator
//
//  Created by fangwiehsu on 2016/5/28.
//  Copyright © 2016年 fangwiehsu. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    
    enum Operation:String {
        case Divide = "/"
        case Multiply = "*"
        case Add = "+"
        case Subtract = "-"
        case Empty = "Empty"
    }
    
    @IBOutlet weak var outputLabel: UILabel!
    
    
    var buttonSound: AVAudioPlayer!
    
    var runnungNumber = ""
    
    //5 + 3 => leftValStr + rightValStr
    var leftValStr = ""
    var rightValStr = ""
    var currentOpreation:Operation = Operation.Empty  //set the default operation to empty
    var result = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //add sound to the button when it was clicked.
        let path = NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
        let soundURL = NSURL(fileURLWithPath: path!)
        
        do{
            try buttonSound = AVAudioPlayer(contentsOfURL: soundURL)
            buttonSound.prepareToPlay()
        }catch let err as NSError{
            print(err.debugDescription)//debugDescription is error message that is readable
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func numberPress(btn: UIButton){
        playSound()
        
        runnungNumber += "\(btn.tag)"
        outputLabel.text! = runnungNumber
    }
    
    @IBAction func onClearButtonPressed(sender: AnyObject) {
        clearEverything()
    }
    
    @IBAction func onDividePressed(sender: AnyObject) {
        processOperation(Operation.Divide)
    }
    
    @IBAction func onMultiplyPressed(sender: AnyObject) {
        processOperation(Operation.Multiply)
    }
    
    @IBAction func onSubtractPressed(sender: AnyObject) {
        processOperation(Operation.Subtract)
    }
    
    @IBAction func onAddPressed(sender: AnyObject) {
        processOperation(Operation.Add)
    }
    
    @IBAction func onEqualPressed(sender: AnyObject) {
        processOperation(currentOpreation)
    }
    
    //func prevent us from repeating the same code
    func processOperation(op: Operation){
        playSound()
        
        if currentOpreation != Operation.Empty{
            
            
            //A user selected an operator, but then selected another without first entering the number
            if runnungNumber != ""{
                
                //run some math
                rightValStr = runnungNumber
                runnungNumber = ""
                
                if currentOpreation == Operation.Multiply{
                    result = "\(Double(leftValStr)! * Double(rightValStr)!)"
                }else if currentOpreation == Operation.Subtract{
                    result = "\(Double(leftValStr)! - Double(rightValStr)!)"
                }else if currentOpreation == Operation.Divide{
                    result = "\(Double(leftValStr)! / Double(rightValStr)!)"
                }else if currentOpreation == Operation.Add{
                    result = "\(Double(leftValStr)! + Double(rightValStr)!)"
                }
                
                
                //this line is to put the result into the leftValStr when you doing operation like 5 + 5 + 6 it will add the firt and the second number and become a result and put into leftValStr and add 6
                leftValStr = result
                //
                outputLabel.text = result
            }
            
            
            currentOpreation = op  //init the operation
            
        }else{
            //this is the first time the operation has been pressed
            leftValStr = runnungNumber
            runnungNumber = ""
            currentOpreation = op
        }
    }
    
    func playSound(){
        if buttonSound.playing{
            buttonSound.stop()
        }
        buttonSound.play()
    }
    
    //clear
    func clearEverything(){
        rightValStr = ""
        leftValStr = ""
        currentOpreation = Operation.Empty
        outputLabel.text = "\(0)"
    }

}


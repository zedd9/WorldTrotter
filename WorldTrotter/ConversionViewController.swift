//
//  ConversionViewController.swift
//  WorldTrotter
//
//  Created by 신현욱 on 2021/02/18.
//

import UIKit

class ConversionViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet var celsiusLabel: UILabel!
    @IBOutlet var textField: UITextField!
    
    let numberFormatter: NumberFormatter = {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.minimumFractionDigits = 0
        nf.maximumFractionDigits = 1
        return nf
    }()
    
    var fahrenheitValue: Double? {
        didSet{
            updateCelsiusLabel()
        }
    }
    
    var celsiusValue: Double? {
        if let value = fahrenheitValue {
            return (value - 32) * (5/9)
        } else {
            return nil
        }
    }
    
    func updateCelsiusLabel() {
        if let value = celsiusValue {
            celsiusLabel.text = numberFormatter.string(from:NSNumber(value:value))
        } else {
            celsiusLabel.text = "???"
        }
    }
    
    @IBAction func fahrenheitFieldEdiginChnaged(textField: UITextField){
        if let text = textField.text, let value = Double(text){
            fahrenheitValue = value
        } else {
            fahrenheitValue = nil
        }
    }
    
    @IBAction func dismissKeyboard(sender: AnyObject){
        textField.resignFirstResponder()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        let length = string.count - range.length + currentText.count
        if length > 7 {
            return false;
        }
        
        let alphabetSet = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ")
        if string.rangeOfCharacter(from: alphabetSet) != nil {
            return false;
        }
        
        let existingTextHasDecimalSeparator = currentText.rangeOfCharacter(from: CharacterSet(charactersIn: "."))
        let repalcementTextHasDecimalSeparator = string.rangeOfCharacter(from: CharacterSet(charactersIn: "."))
        
        if existingTextHasDecimalSeparator != nil && repalcementTextHasDecimalSeparator != nil {
            return false
        } else {
            return true;
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("ConversionViewController loaded its view.")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        var bgColor = UIColor.white
        if hour > 18 || hour < 6 {
            bgColor = UIColor.darkGray;
        }
       
        self.view.backgroundColor = bgColor;
    }
}

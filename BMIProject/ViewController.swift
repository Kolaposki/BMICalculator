//
//  ViewController.swift
//  BMIProject
//
//  Created by Kolapo Oshodi on 2/8/24.
//

import UIKit
enum MeasurementSystem {
    case si
    case imperial
}

class ViewController: UIViewController {
    
    
    @IBOutlet weak var measurementToggleSwitch: UISwitch!
    
    @IBOutlet weak var labelResult: UILabel!
    @IBOutlet weak var inputHeight: UITextField!
    
    @IBOutlet weak var inputWeight: UITextField!
    
    
    @IBOutlet weak var labelError: UILabel!
    @IBOutlet weak var lebelCategory: UILabel!
    @IBAction func btnCalculate(_ sender: UIButton) {
        // Check if both input fields have non-empty values
        guard let heightText = inputHeight.text, !heightText.isEmpty,
              let weightText = inputWeight.text, !weightText.isEmpty else {
            // Display an error message if any of the fields are empty
            labelError.text = "Please enter both height and weight"
            return
        }
        
        // Check if the input values can be converted to valid doubles
        guard let height = Double(heightText), let weight = Double(weightText) else {
            // Display an error message if the input values are not valid numbers
            labelError.text = "Invalid input"
            return
        }
        
        // Check if the input values are positive
        guard height > 0, weight > 0 else {
            // Display an error message if the input values are negative or zero
            labelError.text = "Please enter positive values"
            return
        }

        // Clear any previous error messages
        labelError.text = nil

        
        // Determine the chosen measurement system based on the value of the toggle switch
        let measurementSystem: MeasurementSystem = measurementToggleSwitch.isOn ? .si : .imperial

        // Perform the appropriate BMI calculation based on the chosen measurement system
        let bmi: Double
        if measurementSystem == .si {
            // SI measurement system: weight in kilograms, height in centimeters
            bmi = weight / pow(height / 100, 2)
        } else {
            // Imperial measurement system: weight in pounds, height in inches
            bmi = (weight / pow(height, 2)) * 703
        }

        
        // Perform BMI calculation and update the labels
//        let bmi = weight / pow(height, 2)
        labelResult.text = String(format: "%.2f", bmi)

        
        
        // Update the BMI category label based on the calculated BMI value
        if bmi < 18.5 {
            lebelCategory.text = "Underweight"
        } else if bmi < 25 {
            lebelCategory.text = "Normal weight"
        } else if bmi < 30 {
            lebelCategory.text = "Overweight"
        } else {
            lebelCategory.text = "Obesity"
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
//        btnCalculate.layer.cornerRadius=15;
        labelResult.text = "-"
        lebelCategory.text = "-"
        labelError.text = ""
        
        inputHeight.keyboardType = .decimalPad
        inputWeight.keyboardType = .decimalPad
    }
 

}


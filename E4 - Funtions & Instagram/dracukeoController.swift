//
//  dracukeoController.swift
//  bernat.segura_oscar.julian
//
//  Created by Alumne on 26/10/2021.
//

import Foundation
import UIKit

class dracukeoController: UIViewController {
    
    @IBOutlet weak var lblCounter: UILabel!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var progressBar: UIProgressView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        enableProgress()
    }
    
    //Canvi de color
    @IBAction func segCtrlColor(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            lblCounter.textColor = UIColor.black
        } else if sender.selectedSegmentIndex == 1 {
            lblCounter.textColor = UIColor.red
        }
    }
    
    //Mida de text
    @IBAction func sliderSize(_ sender: UISlider) {
        let senderValue = CGFloat(sender.value)
        lblCounter.font = UIFont.systemFont(ofSize: senderValue)
    }
    
    //Progress on/off
    @IBAction func switchProgress(_ sender: UISwitch) {
        if sender.isOn {
            enableProgress()
        } else {
            disableProgress()
        }
    }
    
    //Incrementa o decrementa valor
    @IBAction func stepperCount(_ sender: UIStepper) {
        lblCounter.text = Int(sender.value).description
    }
    
    func enableProgress () {
        //Fem que el spinner comenci
        spinner.startAnimating()
        //Posem la barra de progres a tope
        progressBar.progress = 1
    }
    
    func disableProgress () {
        //Fem que el spinner comenci
        spinner.stopAnimating()
        //Posem la barra de progres a tope
        progressBar.progress = 0
    }
}

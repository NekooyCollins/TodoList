//
//  ViewController.swift
//  TodoList
//
//  Created by 陈子迪 on 2021/1/10.
//

import Foundation
import UIKit

class ViewController: UIViewController{
    @IBOutlet weak var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
////         Create a DatePicker
//        let datePicker: UIDatePicker = UIDatePicker()
        
        //  Will only execute if the system is having iOS 14 or greater
        if #available(iOS 14, *) {
            datePicker.preferredDatePickerStyle = .inline
        }
        
        datePicker.datePickerMode = UIDatePicker.Mode.countDownTimer
        datePicker.minuteInterval = 1
    }
}

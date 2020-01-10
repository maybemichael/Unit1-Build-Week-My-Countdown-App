//
//  UITextField+InputView.swift
//  CountdownApp
//
//  Created by Michael on 1/7/20.
//  Copyright © 2020 Michael. All rights reserved.
//

import Foundation
import UIKit


extension UITextField {
    
    func setInputViewDatePicker(target: Any, selector: Selector) {
        
        let dateFormatter = DateFormatter()
       // dateFormatter.timeZone = .autoupdatingCurrent
        let minimumDate = Date()
        print("This is the minimum date \(dateFormatter.string(from: minimumDate))")
        let screenWidth = UIScreen.main.bounds.width
        let datePicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 216))
        datePicker.datePickerMode = .date
        datePicker.minimumDate = minimumDate
        self.inputView = datePicker
        
        
        let toolBar = UIToolbar(frame: CGRect(x: 0.0, y: 0.0, width: screenWidth, height: 44.0))
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancel = UIBarButtonItem(title: "Cancel", style: .plain, target: nil, action: #selector(tapCancel))
        let barButton = UIBarButtonItem(title: "Done", style: .plain, target: target, action: selector)
        toolBar.setItems([cancel, flexible, barButton], animated: false)
        self.inputAccessoryView = toolBar
    }
    
    func setInputViewDatePicker2(target: Any, selector: Selector) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm a"
      //  dateFormatter.timeZone = .autoupdatingCurrent
        print(" Testing!!! \(dateFormatter.string(from: Date()))")
        let screenWidth = UIScreen.main.bounds.width
        let datePicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 216))
        datePicker.datePickerMode = .time
        datePicker.timeZone = .current
//        datePicker.minimumDate = Date()
//        if let date = dateFormatter.date(from: "12:00 AM") {
//            datePicker.setDate(date, animated: true)
//        }
        self.inputView = datePicker
    
        
        let toolBar = UIToolbar(frame: CGRect(x: 0.0, y: 0.0, width: screenWidth, height: 44.0))
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancel = UIBarButtonItem(title: "Cancel", style: .plain, target: nil, action: #selector(tapCancel))
        let barButton = UIBarButtonItem(title: "Done", style: .plain, target: target, action: selector)
        toolBar.setItems([cancel, flexible, barButton], animated: false)
        self.inputAccessoryView = toolBar
    }
    
    @objc func tapCancel() {
        self.resignFirstResponder()
    }
}

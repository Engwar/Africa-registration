//
//  RegistrationTableViewController.swift
//  Africa registration
//
//  Created by Igor Shelginskiy on 9/27/19.
//  Copyright © 2019 Igor Shelginskiy. All rights reserved.
//

import UIKit

class RegistrationTableViewController: UITableViewController {

    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var checkInDateLabel: UILabel!
    @IBOutlet weak var checkInDatePicker: UIDatePicker!
    @IBOutlet weak var checkOutDateLabel: UILabel!
    @IBOutlet weak var checkOutDatePicker: UIDatePicker!
    @IBOutlet weak var numberOfAdultLabel: UILabel!
    @IBOutlet weak var numberOfAdultStepper: UIStepper!
    @IBOutlet weak var numberOfChildrenLabel: UILabel!
    @IBOutlet weak var numberOfChildrenStepper: UIStepper!
    
    let checkInLabelIndexPath = IndexPath(row: 0, section: 1)
    let checkInPickerIndexPath = IndexPath(row: 1, section: 1)
    let checkOutLabelIndexPath = IndexPath(row: 2, section: 1)
    let checkOutPickerIndexPath = IndexPath(row: 3, section: 1)
    
    var isCheckInPickerShown = false {
        didSet {
            checkInDatePicker.isHidden = !isCheckInPickerShown
        }
    }
    
    var isCheckOutPickerShown = false {
        didSet {
            checkOutDatePicker.isHidden = !isCheckOutPickerShown
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let midnightToday = Calendar.current.startOfDay(for: Date()) // минимальная дата заезда не ниже сегодняшнего дня
        //checkInDatePicker.date = Date() - данная запись вернет время с текущими секундами и минутами а нам надо с нулевыми
        checkInDatePicker.date = midnightToday
        checkInDatePicker.minimumDate = midnightToday
        
        updateDateViews()
        updateNumberOfGuests()
    }
    
    func updateDateViews() {
        checkOutDatePicker.minimumDate = checkInDatePicker.date.addingTimeInterval(60*60*24) //дата выезда больше даты заезда минимум на сутки, выставляется в секундах
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        
        checkInDateLabel.text = dateFormatter.string(from: checkInDatePicker.date)
        checkOutDateLabel.text = dateFormatter.string(from: checkOutDatePicker.date)
    }
    
    func updateNumberOfGuests() {
        numberOfAdultLabel.text = "\(Int(numberOfAdultStepper.value))"
        numberOfChildrenLabel.text = "\(Int(numberOfChildrenStepper.value))"
    }
     
    @IBAction func doneBarButton(_ sender: UIBarButtonItem) {
        let firstName = firstNameTextField.text ?? ""
        let lastName = lastNameTextField.text ?? ""
        let emailAdress = emailTextField.text ?? ""
        let checkInDate = checkInDatePicker.date
        let checkOutDate = checkOutDatePicker.date
        let numberOfAdult = Int(numberOfAdultStepper.value)
        let numberOfChildren = Int(numberOfChildrenStepper.value)
        
        let registration = Registration(
            firstName: firstName,
            lastName: lastName,
            emailAdress: emailAdress,
            checkInDate: checkInDate,
            checkOutDate: checkOutDate,
            numberOfAdult: numberOfAdult,
            numberOfChildren: numberOfChildren)
        print(registration)
    }
    @IBAction func datePickerChanged(_ sender: UIDatePicker) { //оба пикера сюда подцепляем
        updateDateViews()
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        updateNumberOfGuests()
    }
}

extension RegistrationTableViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true) //убираем выделение серым ячейки
     
        switch indexPath {
        case checkInLabelIndexPath:
            isCheckInPickerShown.toggle()
            isCheckOutPickerShown = false //добавляем чтобы пикер был открыт только один
        case checkOutLabelIndexPath:
            isCheckOutPickerShown.toggle()
            isCheckInPickerShown = false //добавляем чтобы пикер был открыт только один
        default: return
        }
        //обновляем данные чтобы работало изменение
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    //скрываем пикеры и делаем их доступными при выборе
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath {
        case checkInPickerIndexPath:
            return isCheckInPickerShown ? 216 : 0
        case checkOutPickerIndexPath:
            return isCheckOutPickerShown ? 216 : 0
        default:
            return 44
        }
    }
}

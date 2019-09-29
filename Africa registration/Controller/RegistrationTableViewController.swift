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
    @IBOutlet weak var doneButton: UIBarButtonItem!
    @IBOutlet weak var wifiSwitch: UISwitch!
    @IBOutlet weak var roomTypeLabel: UILabel!
    
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
    
    // переменная для хранения данных выбранной комнаты( цена за комнату) и будем ее обновлять когда ей что то присваивается
    var roomType: RoomType? {
        didSet {
            roomTypeLabel.text = roomType?.name
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
        controlText()
    }
    //этот метод мы переопределяем чтобы сохранять выбранную комнату в румтейблвью (чекмарк)
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard roomType == roomType, segue.identifier == "RoomSelectionSegue" else {return}
        
        let controller = segue.destination as! RoomTableViewController
        controller.selectedRoomType = roomType
    }
    
    func updateDateViews() {
        //дата выезда больше даты заезда минимум на сутки, выставляется в секундах
        checkOutDatePicker.minimumDate = checkInDatePicker.date.addingTimeInterval(60*60*24)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        
        checkInDateLabel.text = dateFormatter.string(from: checkInDatePicker.date)
        checkOutDateLabel.text = dateFormatter.string(from: checkOutDatePicker.date)
    }
    
    func updateNumberOfGuests() {
        numberOfAdultLabel.text = "\(Int(numberOfAdultStepper.value))"
        numberOfChildrenLabel.text = "\(Int(numberOfChildrenStepper.value))"
    }
     
    @IBAction func textFieldAction(_ sender: UITextField) {
        controlText()
    }
    
    @IBAction func doneBarButton(_ sender: UIBarButtonItem) {
        let firstName = firstNameTextField.text ?? ""
        let lastName = lastNameTextField.text ?? ""
        let emailAdress = emailTextField.text ?? ""
        let checkInDate = checkInDatePicker.date
        let checkOutDate = checkOutDatePicker.date
        let numberOfAdult = Int(numberOfAdultStepper.value)
        let numberOfChildren = Int(numberOfChildrenStepper.value)
        let wifi = wifiSwitch.isOn
        guard let roomType = roomType else {return}
        
        let registration = Registration(
            firstName: firstName,
            lastName: lastName,
            emailAdress: emailAdress,
            checkInDate: checkInDate,
            checkOutDate: checkOutDate,
            numberOfAdult: numberOfAdult,
            numberOfChildren: numberOfChildren,
            wifi: wifi,
            roomType: roomType)
        print(registration)
    }
    @IBAction func datePickerChanged(_ sender: UIDatePicker) { //оба пикера сюда подцепляем
        updateDateViews()
        controlText()
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        updateNumberOfGuests()
        controlText()
    }
    //здесь мы передаем через анвайнд данные выбранной комнаты (идентификаторы сегвея создаются после перетаскивания с бар баттон айтемов к выходу из вью)
    @IBAction func unwind(unwindSegue: UIStoryboardSegue) {
        guard unwindSegue.identifier == "SaveRoomSegue" else {return}
        
        let controller = unwindSegue.source as! RoomTableViewController
        roomType = controller.selectedRoomType
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
        controlText()
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
    
    func controlText () {
        guard firstNameTextField.hasText && lastNameTextField.hasText && emailTextField.hasText else { return doneButton.isEnabled = false }
        doneButton.isEnabled = true
    }
}

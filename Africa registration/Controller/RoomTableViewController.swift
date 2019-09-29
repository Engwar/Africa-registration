//
//  RoomTableViewController.swift
//  Africa registration
//
//  Created by Igor Shelginskiy on 9/29/19.
//  Copyright © 2019 Igor Shelginskiy. All rights reserved.
//

import UIKit

class RoomTableViewController: UITableViewController {

    var selectedRoomType: RoomType?
    
    //количество ячеек равно количеству комнат
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return RoomType.room.count
    }
    
    //размещаем ячейки в таблице по идентификатору и равному количесту источника данных (RoomType)
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RoomTableCell")!
        let row = indexPath.row
        let roomType = RoomType.room[row]
        
        configure(cell: cell, with: roomType) // в этом методе пишем названия ячеек
        
        return cell
    }
    
    
    //выбираем ячейку
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let row = indexPath.row
        selectedRoomType = RoomType.room[row]
        tableView.reloadData() // делаем обязательно иначе не обновится таблица
    }
    
    func configure(cell: UITableViewCell, with roomType: RoomType){
        cell.textLabel?.text = roomType.name
        cell.detailTextLabel?.text = "$\(roomType.price)"
        
        guard let selectedRoomType = selectedRoomType else {return}
        
        cell.accessoryType = roomType == selectedRoomType ? .checkmark : .none
    }
}

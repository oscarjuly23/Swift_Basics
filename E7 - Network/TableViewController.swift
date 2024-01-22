//
//  TableViewController.swift
//  bernat.segura_oscar.julian
//
//

import Foundation
import UIKit

class CheckListItem {
    let title: String
    var isChecked: Bool
    
    init(title: String, isChecked: Bool) {
        self.title = title
        self.isChecked = isChecked
    }
}

class TableViewController: UITableViewController {

    var items: [CheckListItem] = [
        CheckListItem(title: "Preparar comida", isChecked: true),
        CheckListItem(title: "Ir a la uni", isChecked: true),
        CheckListItem(title: "Suspender movils", isChecked: false)

    ]
    
    let data = dataAPI.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "elements")
        self.data.getData(info: self) { jsonDictionary in
            for element in jsonDictionary {
                if let title = element["title"] as? String {
                    if let completed = element["completed"] as? Bool {
                        self.items.append(CheckListItem(title: title, isChecked: completed))
                    }
                }
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "To Do List"
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = self.tableView.dequeueReusableCell(withIdentifier: "elements") as? UITableViewCell
        
        if let cell = cell {
            cell.textLabel?.text = items[indexPath.row].title
            cell.accessoryType = items[indexPath.row].isChecked ? .checkmark : .none
            return cell
        }
        return UITableViewCell()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier! == "addTask" {
            let vc = segue.destination as! ViewController
            vc.newTaskCreated = { newTask in
                self.items.append(CheckListItem(title: newTask, isChecked: false))
                self.tableView.reloadData()
                //POST request
                self.data.uploadData(newTask)
            }
        }
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if items[indexPath.row].isChecked {
            var dialogMessage = UIAlertController(title: "¿Que quieres hacer con esta tarea?", message: "", preferredStyle: UIAlertController.Style.actionSheet)
            
            let delete = UIAlertAction(title: "Eliminar", style: .destructive, handler: { (action) -> Void in
                self.items.remove(at: indexPath.row)
                self.tableView.reloadData()
            })
            
            let cancel = UIAlertAction(title: "Cancelar", style: .cancel, handler: { (action) -> Void in
            })
            
            let unCheck = UIAlertAction(title: "Desmarcar", style: .default, handler: { (action) -> Void in
                self.items[indexPath.row].isChecked = false
                self.tableView.reloadData()
            })
            
            dialogMessage.addAction(unCheck)
            dialogMessage.addAction(cancel)
            dialogMessage.addAction(delete)

            self.present(dialogMessage, animated: true, completion: nil)
            
            
        } else {
            items[indexPath.row].isChecked = true
            self.tableView.reloadData()
        }

            
    }
    
}

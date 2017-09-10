//
//  chatsVC.swift
//  WeEat
//
//  Created by Qi Jin on 9/9/17.
//  Copyright © 2017 WeEat. All rights reserved.
//

import UIKit

var friends = [p1, p2, p3]



class chatsVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if friends.count < 30 {
            return friends.count
        }
        else {
            return 30
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "act")!
        
        cell.textLabel?.text = friends[indexPath.row].name
        return cell
    }
    
    func requestConfirmed() {
        print("yah")
    }
    
    
    
    @IBAction func refreshButton(_ sender: Any) {
        self.tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let messengerAction = UITableViewRowAction(style: .default, title: "Messenger") {(action, index) in
            print("saved")
        }
        
        messengerAction.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        
        
        let deleteAction = UITableViewRowAction(style: .default, title: "Delete") {(action, index) in
            friends.remove(at: indexPath.row)
            tableView.reloadData()
        }
        
        deleteAction.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        
        return [deleteAction, messengerAction]
    }

}

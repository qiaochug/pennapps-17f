//
//  discoverVC.swift
//  WeEat
//
//  Created by Qi Jin on 9/9/17.
//  Copyright © 2017 WeEat. All rights reserved.
//

import UIKit

struct person {
    var id: Int
    var name: String
    var loginTime: (Int, Int)
    var tags: [String]
    var isStudent: Bool
    var classYear: Int
    var isActive: Bool
}

var p1 = person(id: 1, name: "Nova", loginTime: (15, 36), tags: ["Code", "Sleep", "Eat"], isStudent: true, classYear: 2020, isActive: true)

var p2 = person(id: 2, name: "Kevin", loginTime: (15, 39), tags: ["Code", "Sleep", "Eat"], isStudent: true, classYear: 2020, isActive: true)

var p3 = person(id: 2, name: "Nicole", loginTime: (15, 39), tags: ["Code", "Sleep", "Eat"], isStudent: true, classYear: 2020, isActive: true)

var p4 = person(id: 2, name: "Michael", loginTime: (15, 39), tags: ["Code", "Sleep", "Eat"], isStudent: true, classYear: 2020, isActive: true)

var p5 = person(id: 2, name: "Linzhi", loginTime: (15, 39), tags: ["Code", "Sleep", "Eat"], isStudent: true, classYear: 2020, isActive: true)

var p6 = person(id: 2, name: "Zackery", loginTime: (15, 39), tags: ["Code", "Sleep", "Eat"], isStudent: true, classYear: 2020, isActive: true)

class discoverVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var people : [person] = [p1, p2, p3, p4, p5, p6]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if people.count < 5 {
            return people.count
        }
        else {
            return 5
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "act")!
        
        cell.textLabel?.text = people[indexPath.row].name
        return cell
    }
    
    func requestConfirmed() {
        print("yah")
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let sendRQAction = UITableViewRowAction(style: .default, title: "Send Request") {(action, index) in
            print("saved")
            let alertController = UIAlertController(title: "Request Confirmation", message:
                "Are you sure you want to send the request?", preferredStyle: UIAlertControllerStyle.alert)
            
            alertController.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.default,handler: {UIAlertAction in self.requestConfirmed()}))
            
            alertController.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.default,handler: nil))
            
            self.present(alertController, animated: true, completion: nil)
        }
        
        sendRQAction.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        
        return [sendRQAction]
    }


    

}

//
//  discoverVC.swift
//  WeEat
//
//  Created by Qi Jin on 9/9/17.
//  Copyright © 2017 WeEat. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

struct person {
    var id: Int
    var name: String
    var loginTime: String
    var tags: [String]
    var isStudent: String
    var classYear: String
    var isActive: Bool
    var major: String
    var sendFrom: [String]
}

var p1 = person(id: 1, name: "Nova", loginTime: "1536", tags: ["Code", "Sleep", "Eat"], isStudent: "Student", classYear: "2020", isActive: true, major: "CIS", sendFrom: ["2"])

var p2 = person(id: 2, name: "Kevin", loginTime: "1539", tags: ["Code", "Sleep", "Eat"], isStudent: "Student", classYear: "2020", isActive: true, major : "CIS", sendFrom: [])

var p3 = person(id: 3, name: "Kevin", loginTime: "1539", tags: ["Code", "Sleep", "Eat"], isStudent: "Student", classYear: "2020", isActive: true, major : "CIS", sendFrom: [])



class discoveryVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var people : [person] = [p1, p2]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
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
    
    @IBAction func refreshButton(_ sender: Any) {
        self.tableView.reloadData()
        refresh()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "act")!
        
        cell.textLabel?.text = people[indexPath.row].name
        return cell
    }
    
    func requestConfirmed(id: Int) {
        
        print(id)
        
        let par:[String: Any] = [
            "type": "select",
            "args": [
                "table":"user_db",
                "columns":[
                    "user_from_q"
                ],
                "where":["user_id": id]
            ]       ]
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer l7lx5235jebsvtm36nxxhtiiy6poupk1",
            "Content-Type": "application/json"
        ]
        
        
        Alamofire.request("https://data.breezily98.hasura-app.io/v1/query", method: .post, parameters: par, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            
            print(response.result.value)
            let result = response.result.value
            let JSON = result as! NSArray
            let v = JSON[0] as! NSDictionary
            var temp = v["user_from_q"] as! [String]
            
            temp.insert(self_id!, at: 0)
            
            let new_js: [String: Any] = [
                "type": "update",
                "args": [
                    "table": "user_db",
                    "$set": ["user_from_q": temp],
                    "where": ["user_id": id]
                    
                ]
            ]
            
            Alamofire.request("https://data.breezily98.hasura-app.io/v1/query", method: .post, parameters: new_js, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
                
                print(response.result.value)

                
            }

            
        }
        
        
        
        let s_send:[String: Any] = [
            "type": "select",
            "args": [
                "table":"user_db",
                "columns":
                    ["user_send_q"],
                "where":["user_id": self_id]
            ]       ]
        
        
        Alamofire.request("https://data.breezily98.hasura-app.io/v1/query", method: .post, parameters: s_send, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            
            print(response.result.value)
            let result = response.result.value
            let JSON = result as! NSArray
            let v = JSON[0] as! NSDictionary
            var temp = v["user_send_q"] as! [String]
            
            temp.insert(String(id), at: 0)
            
            let new_js: [String: Any] = [
                "type": "update",
                "args": [
                    "table": "user_db",
                    "$set": ["user_send_q": temp],
                    "where": ["user_id": self_id]
                    
                ]
            ]
            
            Alamofire.request("https://data.breezily98.hasura-app.io/v1/query", method: .post, parameters: new_js, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
                
                print(response.result.value)
                
                
            }
            
            
        }

    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let sendRQAction = UITableViewRowAction(style: .default, title: "Send Request") {(action, index) in
            print("saved")
            let alertController = UIAlertController(title: "Request Confirmation", message:
                "Are you sure you want to send the request?", preferredStyle: UIAlertControllerStyle.alert)
            
            alertController.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.default,handler: {UIAlertAction in self.requestConfirmed(id: 1)}))
            
            alertController.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.default,handler: nil))
            
            self.present(alertController, animated: true, completion: nil)
        }
        
        sendRQAction.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        
        return [sendRQAction]
    }
    
    func refresh(){
        let par:[String: Any] = [
            "type": "select",
            "args": [
                "table":"user_db",
                "columns":[
                    "user_from_q"
                ],
                "where":["user_id": self_id]
            ]       ]
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer l7lx5235jebsvtm36nxxhtiiy6poupk1",
            "Content-Type": "application/json"
        ]
        
        
        Alamofire.request("https://data.breezily98.hasura-app.io/v1/query", method: .post, parameters: par, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            
            print(response.result.value)
            let result = response.result.value
            let JSON = result as! NSArray
            let v = JSON[0] as! NSDictionary
            var temp = v["user_from_q"] as! [String]
            
            for index in 0..<temp.count {
                let id = temp[index]
                self.people = []
                let js:[String: Any] = [
                    "type": "select",
                    "args": [
                        "table":"user_db",
                        "columns":[
                            "user_fname", "user_tags", "user_major", "user_iden", "user_id", "user_time", "user_class", "user_from_q"
                        ],
                        "where":["user_id": id]
                    ]       ]
                
                let headers: HTTPHeaders = [
                    "Authorization": "Bearer l7lx5235jebsvtm36nxxhtiiy6poupk1",
                    "Content-Type": "application/json"
                ]
                
                
                Alamofire.request("https://data.breezily98.hasura-app.io/v1/query", method: .post, parameters: js, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
                    
                    print(response.result.value)
                    let result = response.result.value
                    let JSON = result as! NSArray
                    let v = JSON[0] as! NSDictionary
                    
                    var p1 = person(id: v["user_id"] as! Int, name: v["user_fname"] as! String, loginTime: v["user_time"] as! String, tags: v["user_tags"] as! [String], isStudent: v["user_iden"] as! String, classYear: v["user_class"] as! String, isActive: true, major: v["user_major"] as! String, sendFrom: v["user_from_q"] as! [String])
                    self.people.append(p1)
            }
            
            
        }
    }
    
    
    
}

}

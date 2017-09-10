//
//  ChoosingVC.swift
//  WeEat
//
//  Created by Qiaochu Guo on 9/10/17.
//  Copyright © 2017 WeEat. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ChoosingVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var cafes : [String] = ["1920 Commons", "1920 Starbucks", "McClelland Express", "Falk Kosher Dinning", "Hill House", "English House", "New College House", "Mark's Cafe", "Accenture Cafe"]
    
    @IBOutlet weak var tableView: UITableView!
    
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
        if cafes.count < 10 {
            return cafes.count
        }
        else {
            return 10
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "act")!
        
        cell.textLabel?.text = cafes[indexPath.row]
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let messengerAction = UITableViewRowAction(style: .default, title: "Select") {(action, index) in
            print("saved")
            let loc_id = indexPath.row + 1
            self.send_loc(id: loc_id)
            
            
            self.performSegue(withIdentifier: "theSegue", sender: self)
            
            
        }
        
        messengerAction.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        
        
        
        
        return [messengerAction]
    }
    
    func send_loc(id: Int){
        let par:[String: Any] = [
            "type": "update",
            "args": [
                "table":"user_db",
                "$set":[
                    "user_loc_id": id
                ],
                "where": ["user_id": self_id],
                "returning":["user_id"]
            ]
        ]
        let headers: HTTPHeaders = [
            "Authorization": "Bearer l7lx5235jebsvtm36nxxhtiiy6poupk1",
            "Content-Type": "application/json"
        ]
        
        
        Alamofire.request("https://data.breezily98.hasura-app.io/v1/query", method: .post, parameters: par, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            print(response.result.value)
            
        }
        

    }


}

//
//  requestsVC.swift
//  WeEat
//
//  Created by Qi Jin on 9/9/17.
//  Copyright © 2017 WeEat. All rights reserved.
//

import UIKit

struct friendRQ {
    let friend : person
    let isSender : Bool
}

let rq1 = friendRQ(friend: p1, isSender: true)
let rq2 = friendRQ(friend: p2, isSender: true)
let rq3 = friendRQ(friend: p3, isSender: true)
let rq4 = friendRQ(friend: p3, isSender: true)



class requestsVC: UIViewController, UITableViewDelegate, UITableViewDataSource  {

    @IBOutlet weak var tableView: UITableView!
    
    var requests = [rq1, rq2, rq3, rq4]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        // Do any additional setup after loading the view.
    }

    
    @IBAction func refreshButton(_ sender: Any) {
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if requests.count < 5 {
            return requests.count
        }
        else {
            return 5
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "act")!
        
        cell.textLabel?.text = requests[indexPath.row].friend.name
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let ignoreAction = UITableViewRowAction(style: .default, title: "ignore") {(action, index) in
            self.requests.remove(at: indexPath.row)
            tableView.reloadData()
        }
        
        ignoreAction.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        
        let acceptAction = UITableViewRowAction(style: .default, title: "Accept") {(action, index) in
            
            friends.append(self.requests[indexPath.row].friend)
            
            //self.requests.remove(at: indexPath.row)
        }
        
        acceptAction.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        
        return [ignoreAction, acceptAction]
    }
    
}

//
//  ViewController.swift
//  WeEat
//
//  Created by Qiaochu Guo on 9/9/17.
//  Copyright © 2017 WeEat. All rights reserved.
//

import UIKit
import FacebookLogin
import FBSDKLoginKit
import FacebookShare
import Alamofire
import SwiftyJSON

var self_id: String? = nil


class ViewController: UIViewController {
    
    var dict : [String : AnyObject]!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //creating button
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background.jpg")!)
        
        
        let loginButton = LoginButton(readPermissions: [ .publicProfile ])
        loginButton.center = view.center
        
        print("loaded")
        
        //adding it to view
        view.addSubview(loginButton)
        
        //if the user is already logged in
        if let accessToken = FBSDKAccessToken.current(){
            getFBUserData()
            
        }
        
    }
    
    //when login button clicked
    @objc func loginButtonClicked() {
        let loginManager = LoginManager()
        loginManager.logIn([ .publicProfile ], viewController: self) { loginResult in
            switch loginResult {
            case .failed(let error):
                print(error)
            case .cancelled:
                print("User cancelled login.")
            case .success(let grantedPermissions, let declinedPermissions, let accessToken):
                self.getFBUserData()
            }
        }
        loginManager.logOut()
       
    }
    
    //function is fetching the user data
    func getFBUserData(){
        if((FBSDKAccessToken.current()) != nil){
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name"]).start(completionHandler: { (connection, result, error) -> Void in
                if (error == nil){
                    self.dict = result as! [String : AnyObject]
                    print(result!)
                    print(self.dict)
                    let user_id = self.dict["id"]
                    self_id = self.dict["id"] as! String
                    print (user_id)
                    let user_fname = self.dict["first_name"]
                    print (user_fname)
                    let user_lname = self.dict["last_name"]
                    print (user_lname)
                    self.sendFB(user_id: user_id as! String, user_fname: user_fname as! String, user_lname: user_lname as! String)
                    
                    
                }
                else if (error != nil){
                    print("Error: \(error)")
                }
            })
        }
    }

    
    func requestConfirmed(){
        print("Hello");
    }
    @IBAction func reportButton(_ sender: Any) {
        let alert = UIAlertController(title: "Report", message: "Why do you want to report?", preferredStyle: UIAlertControllerStyle.alert)

        alert.addTextField { (textField) in
            textField.text = "Please enter here"
        }
        
        alert.addAction(UIAlertAction(title: "Submit", style: .default, handler: { [weak alert] (_) in
            let textField = alert!.textFields![0]
            print("Text field: \(textField.text)")
        }))
        
        alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler:nil))
        
        self.present(alert, animated: true, completion: nil)
    }

    @IBAction func requestButton(_ sender: Any) {
        let alertController = UIAlertController(title: "Request Confirmation", message:
            "Are you sure you want to send the request?", preferredStyle: UIAlertControllerStyle.alert)
        
        alertController.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.default,handler: {UIAlertAction in self.requestConfirmed()}))
        
        alertController.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.default,handler: nil))
    
        self.present(alertController, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    func request(){
//        func request(){
//            print(fname.text)
//            
//            let par:[String: Any] = [
//                "type": "select",
//                "args": [
//                    "table": "pennapps_db",
//                    "columns": ["user_loc"],
//                    "where": ["user_id": 0]
//                    
//                ]
//            ]
//            
//            let headers: HTTPHeaders = [
//                "Authorization": "Bearer 6787mt4j4cixzg2gegiiu18tjacxabdy",
//                "Content-Type": "application/json"
//            ]
//            
//            Alamofire.request("https://data.bursar75.hasura-app.io/v1/query", method: .post, parameters: par, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
//                print(response.result.value)
//                if let result = response.result.value {
//                    let JSON = result as! NSArray
//                    let v = JSON[0] as! NSDictionary
//                    print(v["user_loc"] as Any)
//                    let temp = v["user_loc"] as! Int
//                    let body:[String: Any] = [
//                        "type": "select",
//                        "args": [
//                            "table": "location_db",
//                            "columns": ["loc_name"],
//                            "where": ["loc_id": temp]
//                            
//                        ]
//                    ]
//                    
//                    Alamofire.request("https://data.bursar75.hasura-app.io/v1/query", method: .post, parameters: body, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
//                        print(response.result.value)
//                        if let result = response.result.value {
//                            let JSON = result as! NSArray
//                            let v = JSON[0] as! NSDictionary
//                            //        print(v["loc_name"] as Any)
//                        }
//                        
//                    }
//                    
//                }
//                
//                
//                
//            }
//            
//        }
    
//        func send(){
//            
//            
//            let par:[String: Any] = [
//                "type": "insert",
//                "args": [
//                    "table":"pennapps_db",
//                    "objects":[
//                        ["user_id": num, "user_fname": fname.text, "user_lname": lname.text, "user_tags": tags.text, "user_loc": loc.text, "user_sameday": 0, "user_time": time()]
//                    ],
//                    "returning":["user_id"]
//                ]       ]
//            
//            let headers: HTTPHeaders = [
//                "Authorization": "Bearer 6787mt4j4cixzg2gegiiu18tjacxabdy",
//                "Content-Type": "application/json"
//            ]
//            
//            
//            Alamofire.request("https://data.bursar75.hasura-app.io/v1/query", method: .post, parameters: par, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
//                print(response.result.value)
//                self.num += 1
//                
//            }
//            
//            
//            
//        }
//        
//            }
    
    func time() -> String{
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        var min = String(minutes)
        if min.characters.count == 1{
            min = "0" + min
        }
        return String(hour) + min
    }

    func sendFB(user_id: String, user_fname: String, user_lname: String){
        let par:[String: Any] = [
            "type": "insert",
            "args": [
                "table":"user_db",
                "objects":[
                    ["user_id": user_id, "user_fname": user_fname, "user_lname": user_lname, "user_loc_id": 0, "user_sameday": 1, "user_time": time()]
                ],
                "returning":["user_id"]
            ]       ]
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer l7lx5235jebsvtm36nxxhtiiy6poupk1",
            "Content-Type": "application/json"
        ]
        
        
        Alamofire.request("https://data.breezily98.hasura-app.io/v1/query", method: .post, parameters: par, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            print(response.result.value)

            
        }

    
    }


}


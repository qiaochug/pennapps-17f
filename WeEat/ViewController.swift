//
//  ViewController.swift
//  WeEat
//
//  Created by Qiaochu Guo on 9/9/17.
//  Copyright © 2017 WeEat. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
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


}


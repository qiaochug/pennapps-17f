//
//  setup.swift
//  WeEat
//
//  Created by Qiaochu Guo on 9/9/17.
//  Copyright © 2017 WeEat. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class setup: UIViewController, UIPickerViewDelegate,UITextFieldDelegate,UIPickerViewDataSource {
    
    @IBOutlet weak var schooldisplay: UITextField!
    @IBOutlet weak var classdisplay: UITextField!
    @IBOutlet weak var identdisplay: UITextField!
    @IBOutlet weak var major: UITextField!
    @IBOutlet weak var tag1: UITextField!
    @IBOutlet weak var tag2: UITextField!
    @IBOutlet weak var tag3: UITextField!
    @IBOutlet weak var tag4: UITextField!
    @IBOutlet weak var tag5: UITextField!
    @IBOutlet weak var tag6: UITextField!
    @IBOutlet weak var doneb: UIButton!
    
    @IBAction func donebutton(_ sender: Any) {
        send()
    }
    
    @IBOutlet weak var schoolpicker: UIPickerView!
    @IBOutlet weak var classidentpicker: UIPickerView!
    var schoolData: [String] = [String]()
    var classidentData: [[String]] = [[String]]()
    var limitLength = 15

    override func viewDidLoad() {
        super.viewDidLoad()
        schoolData = ["University of Pennsylvania", "Carnegie Mellon University", "Pennsylvania State University"]
        classidentData = [["Student","Faculty"],["2021","2020","2019","2018","2017","2016","2015"]]
        doneb.layer.cornerRadius = 5
        
        schoolpicker.delegate = self
        schoolpicker.dataSource = self
        schoolpicker.tag = 1
        schooldisplay.delegate = self
        schooldisplay.tag = 1
        schoolpicker.isHidden = true
        
        classidentpicker.delegate = self
        classidentpicker.dataSource = self
        classidentpicker.tag = 2
        classdisplay.delegate = self
        identdisplay.delegate = self
        classdisplay.tag = 2
        identdisplay.tag = 3
        classidentpicker.isHidden = true
        
        major.delegate = self
        major.tag = 4
        tag1.delegate = self
        tag2.delegate = self
        tag3.delegate = self
        tag4.delegate = self
        tag5.delegate = self
        tag6.delegate = self
        
        self.view.bringSubview(toFront: schoolpicker)
        self.view.bringSubview(toFront: classidentpicker)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return pickerView.tag
    }
    
    // The number of rows of data
    func pickerView(_ pickerView:UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch  pickerView.tag{
        case 1:
            return schoolData.count
        case 2:
            return classidentData[component].count
        default:
            return 0
        }
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch  pickerView.tag{
        case 1:
            return schoolData[row]
        case 2:
            return classidentData[component][row]
        default:
            return "error"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        switch pickerView.tag {
        case 1:
            schooldisplay.text = schoolData[row]
            schoolpicker.isHidden = true
        case 2:
            if component == 0{
            identdisplay.text = classidentData[component][row]
            }
            if component == 1{
            classdisplay.text = classidentData[component][row]
            classidentpicker.isHidden = true
            }
        default:
            return
        }
        return
        
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        switch textField.tag {
        case 1:
            schoolpicker.isHidden = false
        case 2:
            classidentpicker.isHidden = false
        case 3:
            classidentpicker.isHidden = false
        default:
            return true
        }
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        let newLength = text.characters.count + string.characters.count - range.length
        switch textField.tag {
        case 1:
            return true
        case 2:
            return true
        case 3:
            return true
        case 4:
            return newLength <= 30
        default:
            return newLength <= limitLength
        }
    }
    
    func send(){
        print (self_id)
        let par:[String: Any] = [
            "type": "update",
            "args": [
                "table":"user_db",
                "$set":
                    ["user_tags": [tag1.text, tag2.text, tag3.text, tag4.text, tag5.text, tag6.text], "user_school": schooldisplay.text, "user_class": classdisplay.text, "user_iden": identdisplay.text, "user_major": major.text]
                ,
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

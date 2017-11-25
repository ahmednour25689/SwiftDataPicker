//
//  ViewController.swift
//  DataPicer
//
//  Created by Ahmed on 11/25/17.
//  Copyright © 2017 AhmedNour. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    fileprivate var pickerData:[String] = []
    @IBOutlet weak var btnShowPicker : UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        pickerData.append(contentsOf: ["First Choice","Second Choice","Third Choice"])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func showPicker(_ sender : AnyObject){
        let viewToShow : SwiftDataPicker = SwiftDataPicker(viewController: self,data:pickerData)
        viewToShow.completionHandler = {
            result in
           //result is the selected index
            self.btnShowPicker.setTitle(self.pickerData[result], for: .normal)
            
        }
        viewToShow.doneBlock = {
            result in
            //action based on clicking done button
            
            
        }
  
    
    }

}


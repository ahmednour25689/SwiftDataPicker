//
//  SwiftDataPicker.swift
//
//  Created by Ahmed on 11/25/17.
//  Copyright © 2017 Ahmed. All rights reserved.
//



import UIKit

class SwiftDataPicker: UIPickerView,UIPickerViewDataSource,UIPickerViewDelegate {
    let doneButton = UIButton()
    let cancelButton = UIButton()
    let datePickerContainer = UIView()
    var containerView : UIViewController!
    var data:[String] = []
    var completionHandler : ((_ selectedRow:Int)->Void)?
    var doneBlock : (()->Void)?
    convenience  init(viewController : UIViewController,data : [String]) {
        self.init(frame: CGRect.zero)
        containerView = viewController
        self.data = data
        self.delegate = self
        self.dataSource = self
        setupPicker()
        
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupPicker(){
        let theHeight = containerView.view.frame.size.height
        
        datePickerContainer.frame = CGRect(x:0.0, y:theHeight - 250 ,width: UIScreen.main.bounds.width, height : 250.0)
        datePickerContainer.backgroundColor = UIColor.white
        
        //   let pickerSize : CGSize = datePicker.sizeThatFits(UIScreen.main.bounds.size)
        self.frame = CGRect(x:0.0, y:40, width:datePickerContainer.frame.size.width,height: 220)
        //  datePicker.maximumDate = Date()
        self.backgroundColor = hexStringToUIColor(hex: "#F3F3F5")
        self.tag = tag
        
        datePickerContainer.addSubview(self)
        
        
        doneButton.setTitle("Done", for: UIControlState.normal)
        doneButton.setTitleColor(hexStringToUIColor(hex: "#58595B"), for: UIControlState.normal)
        
        cancelButton.setTitle( "Cancel", for: UIControlState.normal)
        cancelButton.setTitleColor(hexStringToUIColor(hex: "#58595B"), for: UIControlState.normal)
        
        
        doneButton.addTarget(self, action: #selector(dismissPicker(_:)), for: UIControlEvents.touchUpInside)
        doneButton.frame    = CGRect(x:datePickerContainer.frame.size.width - 70,y: 0.0,width: 70.0, height:37.0)
        
        cancelButton.addTarget(self, action: #selector(cancelPicker(_:)), for: UIControlEvents.touchUpInside)
        cancelButton.frame    = CGRect(x:0,y: 0.0,width: 70.0, height:37.0)
        
        datePickerContainer.addSubview(doneButton)
        datePickerContainer.addSubview(cancelButton)
        containerView.view.addSubview(datePickerContainer)
        
        
    }
    @IBAction  func cancelPicker(_ sender: UIButton) {
        self.removeFromSuperview()
        datePickerContainer.removeFromSuperview()
        
    }
    @IBAction  func dismissPicker(_ sender: UIButton) {
        self.removeFromSuperview()
        datePickerContainer.removeFromSuperview()
        if data.count > 0 {
            let row = self.selectedRow(inComponent: 0);
            pickerView(self, didSelectRow: row, inComponent:0)
        }
        doneBlock?()
    }
    
}
extension SwiftDataPicker{
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        completionHandler!(row)
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return data[row]
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return data.count
    }
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 40
    }
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.characters.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}


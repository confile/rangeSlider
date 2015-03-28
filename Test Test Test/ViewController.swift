//
//  ViewController.swift
//  prototype
//
//  Created by Derick Hsieh on 2015-03-20.
//  Copyright (c) 2015 app. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
   
    @IBOutlet weak var lowerThumbValueLabel: UILabel!
    
    @IBOutlet weak var upperThumbValueLabel: UILabel!
    
    let rangeSlider = RangeSlider(frame: CGRectZero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(rangeSlider)
        
        rangeSlider.addTarget(self, action: "rangeSliderValueChanged:", forControlEvents: .ValueChanged)
        
        rangeSlider.setRangeSliderIncrementValue(14)
        
        rangeSlider.setRangeSliderValue(1200, maximumValue: 2400)
        
        rangeSlider.setRangeSliderStartValue(rangeSlider.minimumValue, upperValue: rangeSlider.maximumValue)
        
        let startLowerValue = rangeSlider.lowerValue
        
        let startUpperValue = rangeSlider.upperValue
        
        rangeSlider.setRangeSliderStartValue(rangeSlider.lowerValue, upperValue: rangeSlider.upperValue)
        
        lowerThumbValueLabel.text = "$" + NSString(format: "%.2f", startLowerValue)
        upperThumbValueLabel.text = "$" + NSString(format: "%.2f", startUpperValue)
        
        
        
    }
    
    override func viewDidLayoutSubviews() {
        let margin: CGFloat = 60.0
        let width = view.bounds.width - 2.0 * margin
        rangeSlider.frame = CGRect(x: margin, y: margin + topLayoutGuide.length,
            width: width, height: 31.0)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func rangeSliderValueChanged(rangeSlider: RangeSlider) {
        
        let z: Double = (Double(rangeSlider.upperValue + 2.5) / 5) * 5
        let x: Double = (Double(rangeSlider.lowerValue + 5))
        
        var intZ: Int = (Int(z)/rangeSlider.increment)*rangeSlider.increment + (1/2)
        var intX: Int = (Int(x)/rangeSlider.increment)*rangeSlider.increment + (1/2)
       
        lowerThumbValueLabel.text = "$" + "\(intX)" + ".00"
        upperThumbValueLabel.text = "$" + "\(intZ)" + ".00"
        
    }
    
}
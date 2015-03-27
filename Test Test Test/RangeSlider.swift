//
//  RangeSlider.swift
//  prototype
//
//  Created by Tyler Yan on 2015-03-23.
//  Copyright (c) 2015 app. All rights reserved.
//

import UIKit
import QuartzCore

class RangeSlider: UIControl {
    
    var previousLocation = CGPoint()
    
    var minimumValue: Double = 300 {
        didSet {
            updateLayerFrames()
        }
    }
    
    var maximumValue: Double = 1200.0 {
        didSet {
            updateLayerFrames()
        }
    }
    
    var lowerValue: Double = 500.0 {
        didSet {
            updateLayerFrames()
        }
      
    }
    
    var upperValue: Double = 1000.0 {
        didSet {
            updateLayerFrames()
        }
    }
    
    let trackLayer = RangeSliderTrackLayer()
    let lowerThumbLayer = RangeSliderThumbLayer()
    let upperThumbLayer = RangeSliderThumbLayer()
    
    var gapBetweenThumbs: Double {
        return Double(thumbWidth)*(maximumValue - minimumValue) / Double(bounds.width) - Double(thumbWidth)
    }
    
    var trackTintColor: UIColor = UIColor(white: 0.9, alpha: 1.0) {
        didSet {
            trackLayer.setNeedsDisplay()
        }
    }
    
    var trackHighlightTintColor: UIColor = UIColor(red: 0.0, green: 0.45, blue: 0.94, alpha: 1.0) {
        didSet {
            
            trackLayer.setNeedsDisplay()
            
        }
    }
    
    var thumbTintColor: UIColor = UIColor.whiteColor() {
        didSet {
            lowerThumbLayer.setNeedsDisplay()
            upperThumbLayer.setNeedsDisplay()
        }
    }
    
    var curvaceousness: CGFloat = 0.6 {
        didSet {
            trackLayer.setNeedsDisplay()
            lowerThumbLayer.setNeedsDisplay()
            upperThumbLayer.setNeedsDisplay()
        }
    }
    
    var thumbWidth: CGFloat {
        return CGFloat(bounds.height)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        trackLayer.rangeSlider = self
        trackLayer.contentsScale = UIScreen.mainScreen().scale
        layer.addSublayer(trackLayer)
        
        lowerThumbLayer.rangeSlider = self
        lowerThumbLayer.contentsScale = UIScreen.mainScreen().scale
        layer.addSublayer(lowerThumbLayer)
        
        upperThumbLayer.rangeSlider = self
        upperThumbLayer.contentsScale = UIScreen.mainScreen().scale
        layer.addSublayer(upperThumbLayer)
        
        }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        
    }
    
    func setRangeSliderValue(minimumValue: Double, maximumValue: Double) {
        
        self.maximumValue = maximumValue
        
        self.minimumValue = minimumValue
 
    }
    
    
    func setRangeSliderMaximumValue(maximumValue: Double) {
        
        self.maximumValue = maximumValue
    
    }
    
    func setRangeSliderMinimumValue(minimumValue: Double) {
        
        self.minimumValue = minimumValue
        
    }
        
    func setRangeSliderStartValue(lowerValue: Double, upperValue: Double) {
        
        self.lowerValue = lowerValue
        
        self.upperValue = upperValue
   
           }
        
    func setRangeSliderLowerValue(lowerValue: Double) {
        
        self.lowerValue = lowerValue
        
    }
    
    func setRangeSliderUpperValue(upperValue: Double) {
        
        self.upperValue = upperValue
        
          }
    
    func updateLayerFrames() {
        
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        
        trackLayer.frame = bounds.rectByInsetting(dx: 0.0, dy: bounds.height / 2.2)
        
        
        
        trackLayer.setNeedsDisplay()
        
        var lowerThumbCenter = CGFloat(positionForValue(lowerValue))
        
        lowerThumbLayer.frame = CGRect(x: lowerThumbCenter - thumbWidth / 2.0, y: 0.0,
            width: thumbWidth, height: thumbWidth)
        lowerThumbLayer.setNeedsDisplay()
        
        var upperThumbCenter = CGFloat(positionForValue(upperValue))
        upperThumbLayer.frame = CGRect(x: upperThumbCenter - thumbWidth / 2.0, y: 0.0,
            width: thumbWidth, height: thumbWidth)
        upperThumbLayer.setNeedsDisplay()
        
            CATransaction.commit()
        
    }
    
    func positionForValue(value: Double) -> Double {
        return Double(bounds.width - thumbWidth) * (value - minimumValue) /
            (maximumValue - minimumValue) + Double(thumbWidth / 2.0)
    }
    
    override var frame: CGRect {
        didSet {
            
                updateLayerFrames()
        }
    }
    
    override func beginTrackingWithTouch(touch: UITouch, withEvent event: UIEvent) -> Bool {
        previousLocation = touch.locationInView(self)
        
        // Hit test the thumb layers
        if lowerThumbLayer.frame.contains(previousLocation) {
            lowerThumbLayer.highlighted = true
        } else if upperThumbLayer.frame.contains(previousLocation) {
            upperThumbLayer.highlighted = true
        }
        
        return lowerThumbLayer.highlighted || upperThumbLayer.highlighted
    }
    
    
    func boundValue(value: Double, toLowerValue lowerValue: Double, upperValue: Double) -> Double {
        return min(max(value, lowerValue), upperValue)
    }
    
    override func continueTrackingWithTouch(touch: UITouch, withEvent event: UIEvent) -> Bool {
        let location = touch.locationInView(self)
        
        // 1. Determine by how much the user has dragged
        let deltaLocation = Double(location.x - previousLocation.x)
        let deltaValue = (maximumValue - minimumValue) * deltaLocation / Double(bounds.width - thumbWidth)
        
        previousLocation = location
        
        // 2. Update the values
        if lowerThumbLayer.highlighted {
            lowerValue += deltaValue
            lowerValue = boundValue(lowerValue, toLowerValue: minimumValue, upperValue: upperValue - gapBetweenThumbs)
        } else if upperThumbLayer.highlighted {
            upperValue += deltaValue
            upperValue = boundValue(upperValue, toLowerValue: lowerValue + gapBetweenThumbs, upperValue: maximumValue)
        }
        
        // 3. Update the UI
                                              // Delete everytime if upper and lower values change
                               // Delete everytime if upper and lower values change

        
                                                 // Delete everytime if upper and lower values change
        
                                             // Delete everytime if upper and lower values change

        sendActionsForControlEvents(.ValueChanged)
        
        return true
    }

    override func endTrackingWithTouch(touch: UITouch, withEvent event: UIEvent) {
        lowerThumbLayer.highlighted = false
        upperThumbLayer.highlighted = false
    }
    
}

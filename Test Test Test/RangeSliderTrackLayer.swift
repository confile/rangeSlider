//
//  RangeSliderTrackLayer.swift
//  prototype
//
//  Created by Tyler Yan on 2015-03-23.
//  Copyright (c) 2015 app. All rights reserved.
//

import UIKit
import QuartzCore

class RangeSliderTrackLayer: CALayer {
    weak var rangeSlider: RangeSlider?
    
    override func drawInContext(ctx: CGContext!) {
        if let slider = rangeSlider {
            // Clip
            let cornerRadius = bounds.height * slider.curvaceousness / 2.0
            let path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
            CGContextAddPath(ctx, path.CGPath)
            
            // Fill the track
            CGContextSetFillColorWithColor(ctx, slider.trackTintColor.CGColor)
            CGContextAddPath(ctx, path.CGPath)
            CGContextFillPath(ctx)
            
            // Fill the highlighted range
            CGContextSetFillColorWithColor(ctx, slider.trackHighlightTintColor.CGColor)
            var lowerValuePosition = CGFloat(slider.positionForValue(slider.lowerValue)) - slider.thumbWidth / 2.0

            var upperValuePosition = CGFloat(slider.positionForValue(slider.upperValue)) + slider.thumbWidth / 2.0

            let rect = CGRect(x: lowerValuePosition, y: 0.0, width: upperValuePosition - lowerValuePosition, height: bounds.height)
            CGContextFillRect(ctx, rect)
            
          
        
        }
    
    }

}
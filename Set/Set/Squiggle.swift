//
//  Squiggle.swift
//  Set
//
//  Created by Artyom Danilov on 15.04.2023.
//

import SwiftUI

struct Squiggle:  {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let x: CGFloat = rect.midX
        let y: CGFloat = rect.midY
        let w: CGFloat = rect.width
        let h: CGFloat = rect.height
        
        let controlOffset: CGFloat = w * 0.25
        
        let startPoint = CGPoint(x: x - w * 0.4, y: y + h * 0.3)
        path.move(to: startPoint)
        
        path.addCurve(to: CGPoint(x: x - w * 0.1, y: y - h * 0.1),
                      control1: CGPoint(x: startPoint.x + controlOffset, y: startPoint.y - controlOffset),
                      control2: CGPoint(x: x - w * 0.1, y: y - h * 0.3))
        
        path.addCurve(to: CGPoint(x: x + w * 0.4, y: y + h * 0.1),
                      control1: CGPoint(x: x + w * 0.25, y: y + h * 0.1),
                      control2: CGPoint(x: x + w * 0.25, y: y - h * 0.1))
        
        path.addCurve(to: CGPoint(x: x + w * 0.1, y: y + h * 0.5),
                      control1: CGPoint(x: x + w * 0.5, y: y + h * 0.3),
                      control2: CGPoint(x: x + w * 0.1, y: y + h * 0.3))
        
        path.addCurve(to: CGPoint(x: x - w * 0.4, y: y - h * 0.1),
                      control1: CGPoint(x: x - w * 0.25, y: y + h * 0.1),
                      control2: CGPoint(x: x - w * 0.25, y: y + h * 0.3))
        
        path.addCurve(to: startPoint,
                      control1: CGPoint(x: startPoint.x - controlOffset, y: startPoint.y + controlOffset),
                      control2: CGPoint(x: x - w * 0.1, y: y + h * 0.1))
        
        return path
    }
}

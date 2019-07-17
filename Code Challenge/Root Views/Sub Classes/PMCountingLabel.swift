//
//  PMCountingLabel.swift
//  Code Challenge
//
//  Created by Phil Martin on 10/06/2019.
//  Copyright © 2019 Philip Martin. All rights reserved.
//

import UIKit

class PMCountingLabel: UILabel {
    
    //MARK:- Enums
    //MARK: Animation Type
    enum PMCounterAnimationType {
        // add the ability to change our animation
        case Linear
        case EaseIn
        case EaseOut
    }
    
    //MARK: Counter Type
    enum PMCounterType{
        case Int
        case Float
    }

    //MARK:- Constant
    let counterVelocity: Float = 3.0

    //MARK:- Properties
    var startNumber: Float = 0.0
    var endNumber: Float =  0.0
    var progress: TimeInterval!
    var duration: TimeInterval!
    var lastUpdate: TimeInterval!
    var timer: Timer?
    var counterType: PMCounterType!
    var animationType: PMCounterAnimationType!
    
    //MARK:- Computed Property
    var currentCounterValue: Float{
        if progress >= duration{
            return endNumber
        }
        let percentage = Float(progress / duration)
        let update = updateCounter(counterValue: percentage)
        return startNumber + (update * (endNumber - startNumber))
    }
    
    //MARK:- Helpers
    func count(fromValue: Float, to toValue: Float, withDuration duration: TimeInterval, withAnimationType animationType: PMCounterAnimationType, withCounterType counterType: PMCounterType){
        self.startNumber = fromValue
        self.endNumber = toValue
        self.duration = duration
        self.counterType = counterType
        self.animationType = animationType
        self.progress = 0
        self.lastUpdate = Date.timeIntervalSinceReferenceDate
        
        // invaldate time before starting
        invalidateTimer()
        
        if duration == 0{
            updateText(value: toValue)
            return
        }
        
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(PMCountingLabel.updateValue), userInfo: nil, repeats: true)
    }
    
    @objc func updateValue(){
        // here we are going to update all the timing values, this will allow the label to increment nicely.
        let now = Date.timeIntervalSinceReferenceDate
        progress = progress + (now - lastUpdate)
        lastUpdate = now
        if progress >= duration{
            invalidateTimer()
            progress = duration
        }
        
        // update test in the label
        updateText(value: currentCounterValue)
    }
    
    func updateText(value: Float){
        // you may want to adjust the counter be float of int, just adjust the decimal point to suite your needs in using a float
       
        switch counterType! {
            case .Int:
                self.text = "\(Int(value))"
            case .Float:
                self.text =  String(format: ".2f", value)
        }
    }
    
    fileprivate func updateCounter(counterValue: Float) -> Float{
        
        // set out animation types, play around with what suites your needs
        switch animationType! {
            case .Linear:
                return counterValue
            case .EaseIn:
                return powf(counterValue, counterVelocity)
            case .EaseOut:
                return 1.0 - powf(1.0 - counterValue, counterVelocity)
        }
    }
    fileprivate func invalidateTimer(){
        timer?.invalidate()
        timer = nil
    }

}

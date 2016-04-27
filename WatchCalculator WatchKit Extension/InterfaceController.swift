//
//  InterfaceController.swift
//  WatchCalculator WatchKit Extension
//
//  Created by 史凯迪 on 16/4/26.
//  Copyright © 2016年 caydyn. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {

    @IBOutlet var Resault: WKInterfaceLabel!
    var ResaultString: String = "0";
    var Type:CalcType = CalcType.Nil;
    var LeftValue: Double?
    var RightValue: Double?
    var isCalc:Bool = false;
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    
    @IBAction func Btn_AC_Tap() {
        ResaultString = "0";
        Type = CalcType.Nil;
        LeftValue = nil;
        RightValue = nil;
        
        Resault.setText(ResaultString);
    }
    
    @IBAction func Btn_Sign_Tap() {
        let num = (ResaultString as NSString).doubleValue;
        ResaultString = "\(num * -1)"
        
        Resault.setText(ResaultString);
    }

    @IBAction func Btn_Remainder_Tap() {
        Type = CalcType.Remainder;
        TurnToRightValue();
    }
    
    @IBAction func Btn_Division_Tap() {
        Type = CalcType.Divide;
        TurnToRightValue();
    }
    
    @IBAction func Btn_7_Tap() {
        OnNumTap(7);
    }
    
    @IBAction func Btn_8_Tap() {
        OnNumTap(8);
    }
    
    @IBAction func Btn_9_Tap() {
        OnNumTap(9);
    }
    
    @IBAction func Btn_Mulip_Tap() {
        Type = CalcType.Mulipy;
        TurnToRightValue();
    }
    
    @IBAction func Btn_4_Tap() {
        OnNumTap(4);
    }
    
    @IBAction func Btn_5_Tap() {
        OnNumTap(5);
    }
    
    @IBAction func Btn_6_Tap() {
        OnNumTap(6);
    }
    
    @IBAction func Btn_Subtr_Tap() {
        Type = CalcType.Subtract;
        TurnToRightValue();
    }
    
    @IBAction func Btn_1_Tap() {
        OnNumTap(1);
    }
    
    @IBAction func Btn_2_Tap() {
        OnNumTap(2);
    }
    
    @IBAction func Btn_3_Tap() {
        OnNumTap(3);
    }
    
    @IBAction func Btn_Add_Tap() {
        Type = CalcType.Add;
        TurnToRightValue();
    }
    
    @IBAction func Btn_0_Tap() {
        OnNumTap(0);
    }
    
    @IBAction func Btn_Dot_Tap() {
        if ResaultString.componentsSeparatedByString(".").count < 2 {
            ResaultString += ".";
            Resault.setText(ResaultString);
        }
    }
    
    func onExecue(newValue:Double) {
        switch Type
        {
        case .Add:
            LeftValue! += newValue;
            break
        case .Divide:
            LeftValue! /= newValue;
            break
        case .Mulipy:
            LeftValue! *= newValue;
            break
        case .Subtract:
            LeftValue! -= newValue;
            break
        case .Remainder:
            if newValue != 0 {
                LeftValue! %= newValue;
            } else {
                LeftValue! = 0;
            }
        default:
            return;
        }
        
        ResaultString = "\(LeftValue!)"
        Resault.setText(ResaultString);
        LeftValue = nil;
    }
    
    @IBAction func Btn_Equal_Tap() {
        if isCalc {
            onExecue(RightValue!);
            isCalc = false;
        }
    }
    
    func UpdateResaultString(num:Int) {
        if ResaultString == "0" {
            ResaultString = "\(num)"
        } else {
            if (ResaultString as NSString).length < 8 {
                ResaultString += "\(num)"
            }
        }
    }
    
    func OnNumTap(num:Int) {
        if !isCalc {
            if LeftValue == nil {
                ResaultString = "0";
            }
            UpdateResaultString(num);
            LeftValue = (ResaultString as NSString).doubleValue
        } else {
            if RightValue == nil {
                ResaultString = "0";
            }
            UpdateResaultString(num);
            RightValue = (ResaultString as NSString).doubleValue
        }
        Resault.setText(ResaultString);
    }
    
    func TurnToRightValue() {
        if !isCalc {
            LeftValue = (ResaultString as NSString).doubleValue
            isCalc = true;
            RightValue = nil;
        }
    }

}


enum CalcType {
    case Divide
    case Mulipy
    case Subtract
    case Add
    case Remainder
    case Nil
}

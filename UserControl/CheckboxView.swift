//
//  CheckboxView.swift
//  landi-app
//
//  Created by Andy Chen on 6/23/15.
//  Copyright (c) 2015 edonesoft. All rights reserved.
//

import UIKit


protocol CheckboxViewDelete {

    func checkboxValueChanged(sender:AnyObject)();
}


class CheckboxView: UIView {

    var mydelegate: CheckboxViewDelete!
    var optionText:String = "";
    var btnCheck:UIButton;
    var lblTitle:UILabel;
    var isInit:Bool = false
    

    func setTitle(text:String)
    {
        self.optionText = text;
        self.lblTitle.text = text;

    }
    func setChecked(check:Bool)
    {
        self.btnCheck.selected = check;
    }
    func isChecked() ->Bool
    {
        return self.btnCheck.selected;
    }
    


    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    

    
    func buttonCheckTouched(sender:AnyObject)()
    {
        self.btnCheck.selected = !self.btnCheck.selected;
//        if (self.mydelegate != nil) {
//            self.mydelegate.checkboxValueChanged(self)
//        }

    }


    

    
   override func  drawRect(rect: CGRect) {
    
        if(isInit)
        {
            isInit = true;
            //if(self.btnCheck == nil){
                self.btnCheck = UIButton(frame: CGRectMake(0, 0, 24, 24));
                self.btnCheck.setImage(UIImage(named: "cb_unchecked.png"), forState: UIControlState.Normal)
                self.btnCheck.setImage(UIImage(named: "cb_checked.png"), forState: UIControlState.Selected)
                self.addSubview(self.btnCheck);
                self.btnCheck.addTarget(self, action: Selector("buttonCheckTouched:"), forControlEvents: UIControlEvents.TouchUpInside)
            
          // }
        

        //if (self.lblTitle == nil) {
        
            self.lblTitle = UILabel(frame: CGRectMake(24, 0, self.frame.size.width-24, 24));
            self.lblTitle.backgroundColor = UIColor.clearColor();
            self.lblTitle.font = UIFont.systemFontOfSize(13.0)
       //    }
        }
    }
    

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}

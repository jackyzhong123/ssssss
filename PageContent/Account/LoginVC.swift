//
//  LoginVC.swift
//  HuoDongOrganizer
//
//  Created by Sky on 15/8/23.
//  Copyright (c) 2015年 HuoDongOrganizer. All rights reserved.
//

import UIKit


class LoginVC: RootVC {
 
    @IBOutlet weak var txtPWD: UITextField!
    @IBOutlet weak var txtUID: UITextField!
    
    var isBackToHome:Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
  
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
    @IBAction func btnLoginTapped(sender: AnyObject) {
        
        var tag = (sender as! UIButton).tag
        if(tag == 10)
        {
        if(self.txtUID.text.length <= 11 &&   DataAccessHelper.stringIsNullOrEmpty(self.txtPWD.text))
           {
               return;
            }
            self.view.endEditing(true);
            
            SVProgressHUD.showWithStatusWithBlack("请稍候...");
            let parameters = [
                "NickName": self.txtUID.text,
                "Password":self.txtPWD.text
            ]
            request(.POST, AppConfig.ServerUrl+"api/Login/OrgLogin" , parameters: parameters)
                .responseJSON() {
                   (_, _, data, error) in
                    SVProgressHUD.dismiss()
                    if(error == nil)
                    {
                        
                        var jsonData = JSON(data!);
                        if(jsonData["Code"]==10000)
                        {
                             var strMessage = jsonData["Detail"]["token"]
                    
                            
                            AppConfig.sharedAppConfig.AccessToken = strMessage.string
                            AppConfig.sharedAppConfig.CurrentLoginName =  "ddd"
                            AppConfig.sharedAppConfig.CurrentUID =  1
                            AppConfig.sharedAppConfig.save()
                            
                            self.view.window?.rootViewController=self.storyBoard.instantiateInitialViewController() as? UIViewController
                        
                        }
                        
                }
            }
            
                
            
            
            
        }
        else if(tag == 11)
        {
            
        }
        else if(tag == 12)
        {
            
        }
        else if(tag == 13)//密码找回
        {
        
            
        }
        
    }
    
   

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

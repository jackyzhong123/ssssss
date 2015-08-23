//
//  RegisterStep3VC.swift
//  landi-app
//
//  Created by Andy Chen on 7/7/15.
//  Copyright (c) 2015 edonesoft. All rights reserved.
//

import UIKit

class RegisterStep3VC: RootVC {
    
    @IBOutlet weak var btnDone: UIButton!
    @IBOutlet weak var txtConfrimPwd: UITextField!
    @IBOutlet weak var txtPwd: UITextField!
    @IBOutlet weak var lbMsg: UILabel!
    var strPhone:String!;
    var countryID:Int!;
    var strVcode:String!;
    var isFromFindPwd = false
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "注册";
        
        btnDone.layer.cornerRadius = 8;
        btnDone.layer.masksToBounds=true
        btnDone.layer.borderWidth = 1;
        btnDone.layer.borderColor = UIHelper.mainColor.CGColor;
                 // Do any additional setup after loading the view.
    }
    override func viewWillAppear(animated: Bool) {
        
        if(isFromFindPwd)
        {
            self.title = "忘记密码";
        }
        else
        {
            self.title = "注册";
        }
        
        
        lbMsg.text = "";
    }
    
    
    
    @IBAction func btnActionTapped(sender: AnyObject) {
        
        lbMsg.text = "";
        if(txtPwd.text.trim().length>=6 && txtPwd.text ==  txtConfrimPwd.text.trim())
        {
            
            
            SVProgressHUD.showWithStatusWithBlack("请稍后...");
            
            if(!isFromFindPwd)
            {
               // var postBody:String = String(format: "{\"Birthday\":0,\"ClientName\":\"iPhone\",\"Gender\":0,\"MobilePhone\":\"%@\",\"Name\":\"%@\",\"Password\":\"%@\",\"Vcode\":\"%@\"}", strPhone,strPhone,txtPwd.text,strVcode)
                
               // self.httpObj.httpPostApi("SSO/register", body: postBody, tag: 10);
                
                let parameters = [
                    "Mobile": strPhone,
                    "Password": txtPwd.text,
                    "Code":strVcode
                ]
                request(.POST, AppConfig.ServerUrl+"api/Login/NewOrgRegister" , parameters: parameters)
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
                                
                            }else if(jsonData["Code"]==10001)
                            {
                                //
                                SVProgressHUD.showErrorWithStatusWithBlack("该手机已注册");
                            }else if(jsonData["Code"]==10002)
                            {
                                
                            }
                            
                        }
                }
                
                
                
            }
            else
            {
                //var postBody:String = String(format: "{\"MobilePhone\":\"%@\",\"Password\":\"%@\",\"Vcode\":\"%@\"}", strPhone,txtPwd.text,strVcode)
                
              //  self.httpObj.httpPostApi("SSO/password/reset", body: postBody, tag: 21);
            }
            
        }
        else
        {
            if(txtPwd.text.trim().length<6)
            {
                lbMsg.text = "密码长度不得少于6位"
            }
            if(txtPwd.text.trim() != txtConfrimPwd.text.trim())
            {
                lbMsg.text = "两次输入的密码不一致，请检查"
            }
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //MARK WebRequestDelegate
    func requestDataComplete(response:AnyObject,tag:Int)
    {
        // SVProgressHUD.showSuccessWithStatusWithBlack("");
        if (tag == 10) {
            SVProgressHUD.showWithStatusWithBlack("注册成功，开始自动登录");
            var postBody = String(format: "{\"ClientName\":\"iPhone\",\"MobilePhone\":\"%@\",\"DeviceRegID\":\"\",\"Password\":\"%@\"}", strPhone,self.txtPwd.text)
           // httpObj.httpPostApi("SSO/login", body: postBody, tag: 11)
            
            
            
        }
        else if(tag == 11)
        {
            
            if (response is NSDictionary)
            {
                SVProgressHUD.showSuccessWithStatusWithBlack("登录成功");
                var uid:String = response.objectForKey("Token") as! String;
                AppConfig.sharedAppConfig.AccessToken = response.objectForKey("Token") as! String;
                AppConfig.sharedAppConfig.CurrentLoginName =  response.objectForKey("LoginName") as! String;
                AppConfig.sharedAppConfig.CurrentUID =  response.objectForKey("UserID") as! Int;
                AppConfig.sharedAppConfig.save()
                
                NSNotificationCenter.defaultCenter().postNotificationName("login-status-changed", object: nil, userInfo: nil)
                self.navigationController?.popToRootViewControllerAnimated(true);
                
            }
            else
            {
                SVProgressHUD.showErrorWithStatusWithBlack("注册成功，请自己手动登录");
                //                self.navigationController?.popViewControllerAnimated(true);
                
                self.navigationController?.popToRootViewControllerAnimated(true);
            }
        }
        else if(tag == 21)//重设密码
        {
            var result = response as! Bool
            if(result)
            {
                SVProgressHUD.showSuccessWithStatusWithBlack("设置成功");
            }
            else
            {
                SVProgressHUD.showSuccessWithStatusWithBlack("设置失败，请联系客服");
            }
            
                     
            var vc:LoginVC = self.loginstoryBoard.instantiateViewControllerWithIdentifier("LoginVC") as! LoginVC
            
            
            
            vc.isBackToHome = true;
            self.navigationController?.pushViewController(vc, animated: true)
            
            
        }
    }
    
    func requestDataFailed(error:String)
    {
        SVProgressHUD.showErrorWithStatusWithBlack(error);
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

//
//  RegisterStep2VC.swift
//  HuoDongOrganizer
//
//  Created by Sky on 15/8/23.
//  Copyright (c) 2015年 HuoDongOrganizer. All rights reserved.
//



//
//  RegisterStep2VC.swift
//  landi-app
//
//  Created by Andy Chen on 7/7/15.
//  Copyright (c) 2015 edonesoft. All rights reserved.
//

import UIKit

class RegisterStep2VC: RootVC,UIAlertViewDelegate {
    
    @IBOutlet weak var txtPhone: UITextField!
    @IBOutlet weak var txtVerifyCode: UITextField!
    
    @IBOutlet weak var btnResend: UIButton!
    @IBOutlet weak var btnNext: UIButton!
    
    var secondRemainResend = 1*60;
    var timer:NSTimer!
    var isFromFindPwd = false
    var strPhone:String!;
    var countryID:Int!;
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        btnResend.layer.cornerRadius = 6;
        btnResend.layer.masksToBounds=true
        btnResend.layer.borderWidth = 1;
        btnResend.layer.borderColor = UIHelper.mainColor.CGColor;
        btnNext.layer.cornerRadius = 6;
        btnNext.layer.masksToBounds=true
        btnNext.layer.borderWidth = 1;
        btnNext.layer.borderColor = UIHelper.mainColor.CGColor;
        
        
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(animated: Bool) {
        
        txtPhone.text = strPhone;
        txtPhone.enabled = false;
        
        
        self.startTimer()
        
        
    }
    func startTimer()
    {
        secondRemainResend=60//1分钟内禁止重新发送
        btnResend.enabled = false;
        timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target:self, selector:Selector("changeResendTime"), userInfo: nil, repeats: true)
        timer.fire()
    }
    
    func removeTimer()
    {
        btnResend.enabled = true
        timer.invalidate();
        timer = nil;
        btnResend.setTitle("重新获取验证码", forState: UIControlState.Normal)
    }
    
    func changeResendTime()
    {
        if(secondRemainResend <= 0 )
        {
            if(!btnResend.enabled)
            {
                self.removeTimer()
            }
        }
        else
        {
            secondRemainResend--;
            var msg = String(secondRemainResend) + "秒后重新获取"
            btnResend.setTitle(msg, forState: UIControlState.Normal)
        }
        
    }
    
    
    
    @IBAction func btnTapped(sender: AnyObject) {
        var tag = (sender as! UIButton).tag
        if(tag == 10)//重新发送验证码
        {
            
            if (self.txtPhone.text.length != 11) {
                return;
            }
            
            
            self.view.endEditing(true)
            var alert = UIAlertView()
            alert.title = "确认手机号码"
            alert.message = "我们将发送验证码短信到这个号码:\r\n" + self.txtPhone.text
            alert.addButtonWithTitle("取消")
            alert.addButtonWithTitle("确定")
            alert.delegate = self;
            alert.show()
            
            
        }
        else if(tag == 11)//提交验证码
        {
            if(txtVerifyCode.text.trim().length>0)
            {
                SVProgressHUD.showWithStatusWithBlack("请稍等...")
                
                
                let parameters = [
                    "mp": self.txtPhone.text,
                    "vcode":self.txtVerifyCode.text.trim()
                ]
                request(.GET, AppConfig.ServerUrl+"api/Login/SMSVerify" , parameters: parameters)
                    .responseJSON() {
                        (_, _, data, error) in
                        SVProgressHUD.dismiss()
                        if(error == nil)
                        {
                            var jsonData = JSON(data!);
                            if(jsonData["Code"]==10000)
                            {
                                
                                SVProgressHUD.showSuccessWithStatusWithBlack("验证成功");
                                var vc:RegisterStep3VC = self.loginstoryBoard.instantiateViewControllerWithIdentifier( "RegisterStep3VC") as! RegisterStep3VC
                                vc.strPhone = self.txtPhone.text.trim();
                                vc.countryID = 0;
                                vc.strVcode = self.txtVerifyCode.text
                                vc.isFromFindPwd = self.isFromFindPwd
                                self.navigationController?.pushViewController(vc, animated: true)
  
                                
                                
                                
                                
                            }
                            
                            
                        }
                }
                
                
                
            }
            
        }
    }
    //MARK WebRequestDelegate
    func requestDataComplete(response:AnyObject,tag:Int)
    {
        
        // SVProgressHUD.showSuccessWithStatusWithBlack("");
        if (tag == 10) {
            if (response is NSDictionary)
            {
                var uid:String = response.objectForKey("Token") as! String;
                AppConfig.sharedAppConfig.AccessToken = response.objectForKey("Token") as! String;
                AppConfig.sharedAppConfig.CurrentLoginName =  response.objectForKey("LoginName") as! String;
                AppConfig.sharedAppConfig.CurrentUID =  response.objectForKey("UserID") as! Int;
                AppConfig.sharedAppConfig.save()
                //登录后立马获取用户信息
               ///======= httpObj.httpGetApi("profile/detail", tag: 11)
            }
        }
        else if(tag == 11)
        {
            SVProgressHUD.showSuccessWithStatusWithBlack("验证成功");
           
            
            var vc:RegisterStep3VC = self.loginstoryBoard.instantiateViewControllerWithIdentifier("RegisterStep3VC") as! RegisterStep3VC
            
            vc.strPhone = txtPhone.text.trim();
            vc.countryID = 0;
            vc.strVcode = txtVerifyCode.text
            vc.isFromFindPwd = self.isFromFindPwd
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
        else if(tag == 99)
        {
            SVProgressHUD.showSuccessWithStatusWithBlack("验证码已发送成功");
            self.startTimer();
        }
        
    }
    func requestDataFailed(error:String)
    {
        SVProgressHUD.showErrorWithStatusWithBlack(error);
    }
    
    //MARK alertView Delegate
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        if(buttonIndex == 0)//cancel
        {
            
            
            
            
        }
        else
        {
            self.startTimer()
            SVProgressHUD.showWithStatusWithBlack("验证码短信发送中...")
           // var strapiName = "system/vcode/send/sms?mp="+self.txtPhone.text
        //======    httpObj.httpGetApi(strapiName, tag: 99)
            
            let parameters = [
                "mobile": self.txtPhone.text
            ]
            request(.GET, AppConfig.ServerUrl+"api/Login/sendSMS" , parameters: parameters)
                .responseJSON() {
                    (_, _, data, error) in
                    SVProgressHUD.dismiss()
                    if(error == nil)
                    {
                        var jsonData = JSON(data!);
                        if(jsonData["Code"]==10000)
                        {
                            SVProgressHUD.showSuccessWithStatusWithBlack("验证码已发送成功");
                            self.startTimer();
                            
                        }
                        
                        
                    }
            }
            
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


//
//  RegisterVC.swift
//  HuoDongOrganizer
//
//  Created by Sky on 15/8/23.
//  Copyright (c) 2015年 HuoDongOrganizer. All rights reserved.
//




import UIKit

class RegisterVC: RootVC,UIAlertViewDelegate,WebRequestDelegate {
    
    @IBOutlet weak var txtPhone: TextBoxView!
    @IBOutlet weak var txtControyID: TextBoxView!
    @IBOutlet weak var btnSelectCID: UIButton!
    var strKeyNote = "CountryCode"
    
    var strControyInfo = "+86中国";
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "注册";
       // NSNotificationCenter.defaultCenter().addObserver(self, selector:"changeCountry:" , name: strKeyNote, object: nil)
        
           txtControyID.enabled = false;
        // Do any additional setup after loading the view.
    }
    
    
    
    func changeCountry(notification:NSNotification) {
        
        self.strControyInfo = notification.object as! String;
        
        //         btnSelectCID.titleLabel?.text = self.strControyInfo;
        btnSelectCID.setTitle(self.strControyInfo, forState: UIControlState.Normal)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func btnActionTapped(sender: AnyObject) {
        
        var tag = (sender as! UIButton).tag
        if(tag == 10)
        {//选择国家
           // var vc = UIHelper.GetVCWithIDFromStoryBoard(.Account, viewControllerIdentity: "CountrySelectVC")
           // self.navigationController?.pushViewController(vc, animated: true);
        }
        else if(tag == 11)
        {//确定提交
            
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
        
    }
    
    
//    func toggleRightMenu(sender: AnyObject)
//    {
//        var vc :LoginVC = UIHelper.GetVCWithIDFromStoryBoard(.Account, viewControllerIdentity: "LoginVC") as! LoginVC
//        vc.isBackToHome = false;
//        self.navigationController?.pushViewController(vc, animated: true)
//    }
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
    //MARK WebRequestDelegate
    func requestDataComplete(response:AnyObject,tag:Int)
    {
        if(tag == 11)
        {
            SVProgressHUD.showSuccessWithStatusWithBlack("验证码已发送成功");
           
            
            var vc:RegisterStep2VC = self.loginstoryBoard.instantiateViewControllerWithIdentifier("RegisterStep2VC") as! RegisterStep2VC

            vc.strPhone = txtPhone.text.trim();
            vc.countryID = 0;
            self.navigationController?.pushViewController(vc, animated: true)
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
            SVProgressHUD.showWithStatusWithBlack("验证码短信发送中...")
           // var strapiName = "system/vcode/send/sms?mp="+self.txtPhone.text
            
            
            
            //SVProgressHUD.showWithStatusWithBlack("请稍候...");
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
                            var vc:RegisterStep2VC =   self.loginstoryBoard.instantiateViewControllerWithIdentifier("RegisterStep2VC") as! RegisterStep2VC
                            vc.strPhone = self.txtPhone.text.trim();
                            vc.countryID = 0;
                            self.navigationController?.pushViewController(vc, animated: true)
                            
                        }
                        
                     
                        
                        
                    }
            }
            
            
        }
    }
    
    
    
}



//
//  WelcomeVC.swift
//  HuoDongOrganizer
//
//  Created by Sky on 15/8/23.
//  Copyright (c) 2015年 HuoDongOrganizer. All rights reserved.
//

import UIKit

class WelcomeVC: UIViewController {

    @IBAction func btnRegister(sender: AnyObject) {
        
       //  [self performSegueWithIdentifier:cell.XibName sender:self];
        
        self.performSegueWithIdentifier("segRegister", sender: self)
    }
    
    
    @IBAction func btnLogin(sender: AnyObject) {
        self.performSegueWithIdentifier("segLogin", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

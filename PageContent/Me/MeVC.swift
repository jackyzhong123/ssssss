//
//  MeVC.swift
//  HuoDongOrganizer
//
//  Created by Sky on 15/8/24.
//  Copyright (c) 2015年 HuoDongOrganizer. All rights reserved.
//

import UIKit

class MeVC:RootTableVC {

    
    var cellIdentity = "cellCommon"
    
    var cellFirstIdentity = "cellheader"
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return 7
    }
    
    
   override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        if indexPath.row==0{
            return 120.0
        }
        else{
            return 62.0
        }
    }
    
    var iconArr = ["setting_myCardList","setting_myOrder","setting_placeSearch","setting_freeback","setting_helpCenter","setting_aboutUS"]
    var titleArr = ["我的证照","我的事务","网点查询"/*,"办证知识"*/,"意见反馈","帮助中心"/*,"检测更新"*/,"关于我们"]
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        if indexPath.row==0 {
            
           // var mycell1 = self.tableView!.dequeueReusableCellWithIdentifier(cellFirstIdentity, forIndexPath: indexPath) as! SettingHeadCell
            
            
            var mycell=self.tableView.dequeueReusableCellWithIdentifier(cellFirstIdentity) as! SettingHeadCell
            mycell.selectionStyle = UITableViewCellSelectionStyle.None
            let url:NSURL!=NSURL(string: "http://tse1.mm.bing.net/th?id=OIP.M051601cdf2f31e17aa82cb78418fdbdeH0&pid=15.1")
            
            var nsd=NSData(contentsOfURL: url)
            mycell.imgHeader.image=UIImage(data: nsd!)
            mycell.lbUName.text="ggg"
            mycell.awakeFromNib();
            return mycell;
        }
        else{
            var mycell : UITableViewCell = self.tableView!.dequeueReusableCellWithIdentifier(self.cellIdentity, forIndexPath: indexPath) as! UITableViewCell
            
            mycell.selectionStyle = UITableViewCellSelectionStyle.None;
            mycell.textLabel?.text = titleArr[indexPath.row-1]
            mycell.textLabel?.font = UIHelper.mainFont;
            
            mycell.imageView?.image=UIImage(named: iconArr[indexPath.row-1])
            
            
            return mycell
        }
    }


    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as! UITableViewCell

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}

//
//  MyCountryViewController.swift
//  My Canada
//
//  Created by Lexicon on 11/02/18.
//  Copyright © 2018 Lexicon. All rights reserved.
//

import Foundation
import UIKit

var tblList:UITableView!
var arrList = [Any]()
var rectScreenSize:CGRect!
var refreshControl: UIRefreshControl!
var activityIndicator:UIActivityIndicatorView!

class MyCountryViewController : UIViewController, UITableViewDataSource, UITableViewDelegate, ServerAPIDelegate
{
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        rectScreenSize = UIScreen.main.bounds
        self.view.backgroundColor = UIColor.white
        
        createControls()
        callWebService()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
    }
    
    func callWebService()
    {
        activityIndicator.startAnimating()
        ServerAPI().callCountryList(delegateAPI:self)
    }
    
    func createControls()
    {

        let YPos:CGFloat = (self.navigationController?.navigationBar.frame.size.height)!
        
        tblList = UITableView()
        tblList.dataSource = self
        tblList.delegate = self
        tblList.separatorStyle = .none
        tblList.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(tblList)
        
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(refresh), for: UIControlEvents.valueChanged)
        tblList.addSubview(refreshControl)
        
        let trailing = NSLayoutConstraint(item:tblList, attribute: NSLayoutAttribute.trailing, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.trailing, multiplier: 1.0, constant: 0.0)
        
        let leading = NSLayoutConstraint(item: tblList, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.leading, multiplier: 1.0, constant: 0.0)
        
        let top = NSLayoutConstraint(item: tblList, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.top, multiplier: 1.0, constant: YPos)
        
        let bottom = NSLayoutConstraint(item: tblList, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.bottom, multiplier: 1.0, constant: 0.0)
        
        self.view.addConstraints([top,bottom, trailing,leading ])
        
        
        activityIndicator =  UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
        activityIndicator.center = view.center
        self.view.addSubview(activityIndicator)
        
        self.view.bringSubview(toFront:activityIndicator)
        
        activityIndicator.addConstraint(NSLayoutConstraint(item: activityIndicator, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 50))
        activityIndicator.addConstraint(NSLayoutConstraint(item: activityIndicator, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 50))
    }
    
    //MARK:tableview delegate methods
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        var dicResult = arrList[indexPath.row] as! Dictionary<String, Any>
        
        if let strDescription = dicResult["description"] as? String
        {
            let height = rectForText(text:strDescription, font:UIFont.systemFont(ofSize: 12), maxSize: CGSize(width:rectScreenSize.size.width, height:999))
            
            if(height < 10)
            {
                 return 150
            }
            else
            {
                 return 150 + height
            }
        }
        else
        {
             return 150
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
       return arrList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "cell"
        
        var cell = tableView.dequeueReusableCell(withIdentifier:cellIdentifier) as! MyCountryListCustomCell!
        
        if cell == nil
        {
            cell = MyCountryListCustomCell(style:.default, reuseIdentifier:cellIdentifier)
        }
        
        cell?.selectionStyle = .none
        var dicResponse = arrList[indexPath.row] as! Dictionary<String, Any>
        
        if let strTitle = dicResponse["title"] as? String
        {
            cell?.lblTitle.text = strTitle
        }
        else
        {
            cell?.lblTitle.text = "No Title"
        }
        
        if let strDescription = dicResponse["description"] as? String
        {
            cell?.lblDescription.text = strDescription
        }
        else
        {
            cell?.lblDescription.text = "No Description"
        }
        
        if let strDescription = dicResponse["description"] as? String
        {
            let height = rectForText(text:strDescription, font:UIFont.systemFont(ofSize: 16), maxSize: CGSize(width:rectScreenSize.size.width, height:999))
            
            if(height < 10)
            {
                cell?.setConstraints(lblHeight:50)
            }
            else
            {
                cell?.setConstraints(lblHeight:height + 80)
            }
        }
        else
        {
            cell?.setConstraints(lblHeight:50)
        }
        
       if let imgURL =  dicResponse["imageHref"] as? String
       {
         cell?.imgImage.downloadImageFrom(link: imgURL, contentMode: UIViewContentMode.scaleAspectFit)
       }
       
       
        return cell!
            
        }
    
    //MARK:local methods
    
    func rectForText(text: String, font: UIFont, maxSize: CGSize) -> CGFloat {
        
        let attrString = NSAttributedString.init(string: text, attributes: [NSAttributedStringKey.font:font])
        let rect = attrString.boundingRect(with: maxSize, options: NSStringDrawingOptions.usesLineFragmentOrigin, context: nil)
        
        return rect.size.height
    }

    @objc func refresh(sender:AnyObject)
    {
        // Updating data here...
        
        tblList.reloadData()
        refreshControl?.endRefreshing()
    }
    //MARK:Server delegate methods
    func CALLBACK_WebService(dicResult: Dictionary<String, Any>) {
        
        activityIndicator.stopAnimating()
        self.title = dicResult["title"] as? String
        arrList = dicResult["rows"] as! Array
        tblList.reloadData()
    }
    
    func API_CALLBACK_ERROR(errorNumber: Int, errorMessage: String) {
        
         activityIndicator.stopAnimating()
    }
}


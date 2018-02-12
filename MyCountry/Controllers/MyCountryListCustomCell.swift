//
//  MyCountryListCustomCell.swift
//  My Canada
//
//  Created by Lexicon on 11/02/18.
//  Copyright © 2018 Lexicon. All rights reserved.
//

import UIKit

class MyCountryListCustomCell: UITableViewCell {
    
    var lblTitle : UILabel!
    var imgImage: UIImageView!
    var lblDescription:UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?)
    {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        createControlsForMyCountryList()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createControlsForMyCountryList()
    {
       
        
        lblTitle = UILabel()
        lblTitle.backgroundColor = UIColor.lightGray
        lblTitle.textAlignment = .center
        lblTitle.font = UIFont.systemFont(ofSize: 16)
        lblTitle.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(lblTitle)
        
        lblDescription = UILabel()
        lblDescription.numberOfLines = 0
        lblDescription.font = UIFont.systemFont(ofSize: 12)
        lblDescription.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(lblDescription)
        
        imgImage = UIImageView()
        imgImage.backgroundColor = UIColor.orange
        imgImage.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(imgImage)
        
    }
    
    func setConstraints(lblHeight:CGFloat)
    {
        let trailing = NSLayoutConstraint(item:lblTitle, attribute: NSLayoutAttribute.trailing, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.trailing, multiplier: 1.0, constant: 0.0)
        
        let leading = NSLayoutConstraint(item:lblTitle, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.leading, multiplier: 1.0, constant: 0.0)
        
        let top = NSLayoutConstraint(item: lblTitle, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.top, multiplier: 1.0, constant: 0.0)
        
        lblTitle.addConstraint(NSLayoutConstraint(item: lblTitle, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 20))
        
        self.addConstraints([trailing, leading, top])
        
        let leadingImage = NSLayoutConstraint(item:imgImage, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.leading, multiplier: 1.0, constant: 5.0)
        let topImage = NSLayoutConstraint(item: imgImage, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: lblTitle, attribute: NSLayoutAttribute.top, multiplier: 1.0, constant: 25.0)
        self.addConstraints([leadingImage,topImage])
        
        imgImage.addConstraint(NSLayoutConstraint(item: imgImage, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 50))
        imgImage.addConstraint(NSLayoutConstraint(item: imgImage, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 50))
        
        
        let trailingDescripion = NSLayoutConstraint(item:lblDescription, attribute: NSLayoutAttribute.trailing, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.trailing, multiplier: 1.0, constant: 0.0)
        
        let leadingdescription = NSLayoutConstraint(item:lblDescription, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.leading, multiplier: 1.0, constant: 5.0)
        
        let topDescription = NSLayoutConstraint(item: lblDescription, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: imgImage, attribute: NSLayoutAttribute.top, multiplier: 1.0, constant: 55.0)
        
        lblDescription.addConstraint(NSLayoutConstraint(item: lblDescription, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: lblHeight))
        
        self.addConstraints([trailingDescripion, leadingdescription, topDescription])
    }
    
    
}

extension UIImageView {
    func downloadImageFrom(link:String, contentMode: UIViewContentMode) {
        URLSession.shared.dataTask( with: NSURL(string:link)! as URL, completionHandler: {
            (data, response, error) -> Void in
            DispatchQueue.main.async {
                self.contentMode =  contentMode
                if let data = data { self.image = UIImage(data: data) }
            }
        }).resume()
    }
}


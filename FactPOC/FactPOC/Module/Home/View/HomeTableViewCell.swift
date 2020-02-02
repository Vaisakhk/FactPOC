//
//  HomeTableViewCell.swift
//  FactPOC
//
//  Created by User on 2/2/20.
//  Copyright © 2020 VK. All rights reserved.
//

import UIKit
import SDWebImage
class HomeTableViewCell: UITableViewCell {
    private var homeImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        return imageView
    }()
    private let homeTitleLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false // enable auto-layout
        label.textColor = UIColor.black
        label.textAlignment = .center // text alignment in center
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.numberOfLines = 0
        return label
    }()
    
    private let homeDetailLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false // enable auto-layout
        label.textAlignment = .center // text alignment in center
        label.font = UIFont.systemFont(ofSize: 14, weight: .light)
        label.numberOfLines = 0
        return label
    }()
    
    //MARK:- UIView Life Cycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        clipsToBounds = true
        addSubview(homeTitleLabel)
        addSubview(homeImageView)
        addSubview(homeDetailLabel)
        self.selectionStyle = .none
        addImageViewConstraint()
        addTitleLabelConstraint()
        addDetailLabelConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:- UIView Constraints
    func addTitleLabelConstraint () {
        let leadingConstraint = NSLayoutConstraint(item: homeTitleLabel, attribute: .leading, relatedBy: .equal, toItem: homeImageView, attribute: .trailing, multiplier: 1, constant: 10)
         let trailingConstraint = NSLayoutConstraint(item: homeTitleLabel, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1, constant: 10)
        let topConstraint = NSLayoutConstraint(item: homeTitleLabel, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 5)
        let heightConstraint = NSLayoutConstraint(item: homeTitleLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 40)
        NSLayoutConstraint.activate([leadingConstraint, trailingConstraint,topConstraint,heightConstraint])
    }
    
    func addImageViewConstraint () {
        let leadingConstraint = NSLayoutConstraint(item: homeImageView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 10)
        let topConstraint = NSLayoutConstraint(item: homeImageView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 5)
        let widthConstraint = NSLayoutConstraint(item: homeImageView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 60)
        let heightConstraint = NSLayoutConstraint(item: homeImageView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 60)
        NSLayoutConstraint.activate([leadingConstraint, heightConstraint,topConstraint,widthConstraint])
        homeImageView.layer.cornerRadius = 30
    }
    
    func addDetailLabelConstraint () {
        let leadingConstraint = NSLayoutConstraint(item: homeDetailLabel, attribute: .leading, relatedBy: .equal, toItem: homeImageView, attribute: .trailing, multiplier: 1, constant: 10)
         let trailingConstraint = NSLayoutConstraint(item: homeDetailLabel, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1, constant: -10)
        let topConstraint = NSLayoutConstraint(item: homeDetailLabel, attribute: .top, relatedBy: .equal, toItem: homeTitleLabel, attribute: .bottom, multiplier: 1, constant: 5)
       let bottomConstraint = NSLayoutConstraint(item: homeDetailLabel, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: -20)
        NSLayoutConstraint.activate([leadingConstraint, trailingConstraint,topConstraint,bottomConstraint])
    }
    
    //MARK:- UIView populate data
    func populateData(searchData:Fact) {
        homeImageView.image = UIImage(named: "placeHolder")
        let imageString:String = searchData.imageHref ?? ""
        homeImageView.sd_setImage(with: URL(string: imageString), placeholderImage: UIImage(named: "placeHolder"), options: SDWebImageOptions.refreshCached, completed: { (image, error, cache, url) in
           
        })
        homeTitleLabel.text = searchData.title
        homeDetailLabel.text = searchData.description
    }
}

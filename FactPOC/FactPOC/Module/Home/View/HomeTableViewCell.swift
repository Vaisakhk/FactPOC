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

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK:- UIView populate data
    func populateData(searchData:Fact) {
        imageView?.image = UIImage(named: "placeHolder")
        let imageString:String = searchData.imageHref ?? ""
        print("VK",searchData.description)
        imageView?.sd_setImage(with: URL(string: imageString), placeholderImage: UIImage(named: "placeHolder"), options: SDWebImageOptions.refreshCached, completed: { (image, error, cache, url) in
            
        })
        textLabel?.text = searchData.title
        detailTextLabel?.text = searchData.description
    }

}

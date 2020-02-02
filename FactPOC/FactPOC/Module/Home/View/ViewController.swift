//
//  ViewController.swift
//  FactPOC
//
//  Created by User on 2/1/20.
//  Copyright © 2020 VK. All rights reserved.
//

import UIKit
import PKHUD

class ViewController: UIViewController {
    var presenter:HomeViewToPresenterProtocol?
    var tableView:UITableView?
    var dataArray:[Fact] = []
    
    private var refreshControl:UIRefreshControl = {
          let refresh = UIRefreshControl()
          refresh.attributedTitle = NSAttributedString(string: "Pull to refresh")
         return refresh
     }()
    
    //MARK:- UIView Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        showSpinner()
        presenter?.startDownloadHomeDetails()
        self.view.backgroundColor = UIColor.white
        customizeTableView()
        addTableViewConstraints()
    }
    
    func customizeTableView() {
        tableView = UITableView()
        tableView?.isHidden = true
        tableView?.estimatedRowHeight = 200//UITableView.automaticDimension
        tableView?.contentInset = UIEdgeInsets(top: 5, left: 0, bottom: 64, right: 0)
        tableView?.register(HomeTableViewCell.self, forCellReuseIdentifier: "homecell")
        refreshControl.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
        tableView?.addSubview(refreshControl) // not required when using UITableViewController
        tableView?.delegate = self
        tableView?.dataSource = self
        view.addSubview(tableView!)
    }
    
    func addTableViewConstraints() {
        tableView?.translatesAutoresizingMaskIntoConstraints = false
        let horizontalConstraint = NSLayoutConstraint(item: tableView!, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0)
        let verticalConstraint = NSLayoutConstraint(item: tableView!, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: 0)
        let leadingConstraint = NSLayoutConstraint(item: tableView!, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.leading, multiplier: 1, constant: 0)
        let trailingConstraint = NSLayoutConstraint(item: tableView!, attribute: NSLayoutConstraint.Attribute.trailing, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1, constant: 0)
        
        let topConstraint = NSLayoutConstraint(item: tableView!, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1, constant: 0)
        
        let bottomConstraint = NSLayoutConstraint(item: tableView!, attribute: NSLayoutConstraint.Attribute.bottom, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1, constant: 0)
        view.addConstraints([horizontalConstraint, verticalConstraint, leadingConstraint, trailingConstraint,topConstraint,bottomConstraint])
    }
    
    //MARK:- UIView Action
    @objc func refresh() {
        presenter?.startDownloadHomeDetails()
    }
    
    //MARK:- Show Spinner
    @objc func showSpinner() {
            PKHUD.sharedHUD.contentView = PKHUDProgressView()
            PKHUD.sharedHUD.show()
    }
    //MARK:- Show Spinner in View with title
    @objc func showSpinner(view:UIView,with titleString:String) {
            PKHUD.sharedHUD.contentView = PKHUDProgressView(title: titleString, subtitle: "")
            PKHUD.sharedHUD.show()
    }
    
    //MARK:- Hide Spinner
    @objc func hideSpinner() {
            PKHUD.sharedHUD.hide()
    }
    
    @objc public func showAlert(alertMessage:String,title:String,successBlock: @escaping (_ isSuccess:Bool) -> Void) {
        let alert = UIAlertController(title: title , message: alertMessage , preferredStyle: .alert)
        let ok  = UIAlertAction(title: "OK", style: .default) { (UIAlertAction) in
            successBlock(true)
        }
        alert.addAction(ok)
        present(alert, animated: true, completion: nil);
    }
}

    //MARK:- Home Presenter To View Protocol
extension ViewController:HomePresenterToViewProtocol {
    func HomeFetchSuccess(result: [Fact], factTitle: String) {
        hideSpinner()
        self.title = factTitle
        dataArray = result
        tableView?.reloadData()
        tableView?.isHidden = false
        if(refreshControl.isRefreshing) {
            refreshControl.endRefreshing()
        }
    }
    
    func HomeFetchFailed(message: String) {
        hideSpinner()
        showAlert(alertMessage: message, title: "FactPoc") { (isSuccess) in
            
        }
    }
}

    //MARK:- UITable view delegate and datasource
extension ViewController :UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let homeCell = tableView.dequeueReusableCell(withIdentifier: "homecell", for: indexPath as IndexPath) as! HomeTableViewCell
        homeCell.populateData(searchData: self.dataArray[indexPath.row] )
        return homeCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

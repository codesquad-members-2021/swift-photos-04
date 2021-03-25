//
//  SecondViewController.swift
//  PhotoApp
//
//  Created by 조중윤 on 2021/03/24.
//

import UIKit

class DoodleViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Close", image: nil, primaryAction: UIAction.init(handler: { (action) in
            self.navigationController?.popViewController(animated: true)
        }), menu: nil)
    }
}

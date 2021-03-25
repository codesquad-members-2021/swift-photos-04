//
//  ViewController.swift
//  PhotoApp
//
//  Created by 조중윤 on 2021/03/22.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func plusButtonPressed(_ sender: UIBarButtonItem) {
        let destinationVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DoodleViewController") as! DoodleViewController
        self.present(destinationVC, animated: true, completion: nil)
    }
}


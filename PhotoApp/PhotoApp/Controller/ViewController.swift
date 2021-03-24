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
        
        parseDoodle()
    }
    
    func parseDoodle() {
        guard let urlPath = Bundle.main.url(forResource: "doodle", withExtension: "json") else { return }
        do{
            let data = try Data(contentsOf: urlPath)
            let decodedData = try JSONDecoder().decode([Doodle].self, from: data)
            print(decodedData)
        } catch {
            print(error.localizedDescription)
        }
    }
}


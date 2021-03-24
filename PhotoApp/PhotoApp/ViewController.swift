//
//  ViewController.swift
//  PhotoApp
//
//  Created by 조중윤 on 2021/03/22.
//

import UIKit
struct Doodle: Codable {
    var title: String
    var image: String
    var date: String
    
}
class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let urlPath = Bundle.main.url(forResource: "doodle", withExtension: "json")
        print(urlPath!)
        let data = try! Data(contentsOf: urlPath!)
        let arr = try! JSONDecoder().decode([Doodle].self, from: data)
        print(arr)
    }
}

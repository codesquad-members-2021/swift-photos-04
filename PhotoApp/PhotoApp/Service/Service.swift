//
//  Service.swift
//  PhotoApp
//
//  Created by kiyoungj on 2021/03/24.
//

import UIKit

class Service {
    static let shared = Service() // singleton
    func fetchDataFromParseJSON() -> [DoodleModel] {
        guard let urlPath = Bundle.main.url(forResource: "doodle", withExtension: "json") else { return []  }
        do {
            var result = [DoodleModel]()
            let jsonData = try Data(contentsOf: urlPath)
            let data = try JSONDecoder().decode([DoodleModel].self, from: jsonData)
            result = data
            return result
        }
        catch {
            print("Data Load Failed")
        }
        return []
    }
}

extension UIImageView {
    func load(urlString: String){
        guard let url = URL(string: urlString) else { return }
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url){
                if let image = UIImage(data: data){
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}

//        DispatchQueue.global().async {
//            let item = self.result[indexPath.item]
//            let imageURL = item.image
//            guard let url = URL(string: imageURL) else { return }
//            var data = Data()
//            do {
//                data = try Data(contentsOf: url)
//            } catch {
//                return
//            }
//            DispatchQueue.main.async {
//                cell.urlImageView.image = UIImage(data: data)
//            }
//        }

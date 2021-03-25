//
//  DoodleManager.swift
//  PhotoApp
//
//  Created by 조중윤 on 2021/03/25.
//

import Foundation

class DoodleManager {
    var doodle: [Doodle]!
    
    init() {
        self.doodle = parseDoodle()
    }
    
    func parseDoodle() -> [Doodle] {
        guard let urlPath = Bundle.main.url(forResource: "doodle", withExtension: "json") else { return []}
        do{
            let data = try Data(contentsOf: urlPath)
            let decodedData = try JSONDecoder().decode([Doodle].self, from: data)
            return decodedData
        } catch {
            print(error.localizedDescription)
        }
        return []
    }
}

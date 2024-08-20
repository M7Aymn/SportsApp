//
//  Sport.swift
//  SportsApp
//
//  Created by Mohamed Ayman on 20/08/2024.
//

import Foundation

enum Sport: String {
    case football = "Football"
    case basketball = "Basketball"
    case cricket = "Cricket"
    case tennis = "Tennis"
    
    var endpoint: String {
        return "/" + self.rawValue.lowercased()
    }
    
    var title: String {
        return self.rawValue
    }
    
    var imageName: String {
        return self.rawValue.lowercased()
    }
}

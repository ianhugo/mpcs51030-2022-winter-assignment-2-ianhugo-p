//
//  Animal.swift
//  Module2
//
//  Created by Ian Yuen on 25/01/2022.
//

import Foundation
import UIKit

class Animal: CustomStringConvertible {
    let name: String
    let species: String
    let age: Int
    let image: UIImage
    let soundPath: String
    
    var description: String {
        return "Animal: name = \(name), species = \(species), age = \(age)"
    }
    
    init(_ name: String, _ species: String, _ age: Int,  _ image: UIImage, _ soundPath: String) {
        self.name = name
        self.species = species
        self.age = age
        self.image = image
        self.soundPath = soundPath
    }
}

//
//  ProductCategory.swift
//  MAC
//
//  Created by Daisoreanu, Laurentiu on 19.03.2023.
//

import Foundation

enum ProductCategory: Codable {
    case lips(subcategory: LipsCategory)
    case face(subcategory: FaceCategory)
    case eyes(subcategory: EyesCategory)
    case brushes(subcategory: BrushesCategory)
    case skin(subcategiry: SkinCategory)

    var name: String {
        switch self {
        case .lips(_):
            return "Lips"
        case .face:
            return "Face"
        case .eyes:
            return "Eyes"
        case .brushes:
            return "Brushes"
        case .skin:
            return "Skin"
        }
    }

    var subName: String {
        switch self {
        case .lips(subcategory: let subcategory):
            return subcategory.name
        case .face(subcategory: let subcategory):
            return subcategory.name
        case .eyes(subcategory: let subcategory):
            return subcategory.name
        case .brushes(subcategory: let subcategory):
            return subcategory.name
        case .skin(subcategiry: let subcategory):
            return subcategory.name
        }
    }
}


enum FaceCategory: String, Codable {
    case foundation = "Foundation"
    case powders = "Powders"
    case blushesAndBronzers = "Blushes + Bronzers"
    case concealers = "Concealers"
    case highlighters = "Highlighters"
    case facePalettesAndKits = "Face palettes + Kits"
    case glittersAndPigments = "Glitters + Pigments"

    var name: String {
        return self.rawValue
    }
}

enum LipsCategory: String, Codable {
    case lipsticks = "Lipsticks"
    case lipGlosses = "Lip Glosses"
    case liquidLipColours = "Liquid Lip Colours"
    case lipLiners = "Lip Liners"
    case lipPrimers = "Lip Primers"

    var name: String {
        return self.rawValue
    }
}

enum EyesCategory: String, Codable {
    case eyeShadows = "Eye Shadows"
    case eyeLiners = "Eye Liners"
    case mascaras = "Mascaras"
    case brows = "Brows"
    case lashes = "Lashes"

    var name: String {
        return self.rawValue
    }
}


enum BrushesCategory: String, Codable {
    case eyeShadows = "Eye Brushes"
    case eyeLiners = "Lip Brushes"
    case mascaras = "Face Brushes"

    var name: String {
        return self.rawValue
    }
}

enum SkinCategory: String, Codable {
    case facePrimers = "Face Primers"
    case eyePrimers = "Eye Primers"
    case lipPrimers = "Lip Primers"
    case settingSprays = "Setting Sprays"

    var name: String {
        return self.rawValue
    }
}

//
//  DefaultAction.swift
//  MAC
//
//  Created by Daisoreanu, Laurentiu on 20.03.2023.
//

import Foundation

enum DefaultCommand {
    
    case confirm
    case showComments
    case stopScrolling
    case applyFilters
    case goBack
    case addComment
    case openProfile
    case readDescription
    case showCart
    case addToFavourites
    case scrollUp
    case addToCart
    case goHome
    case save
    case startScrolling
    case removeFromFavourites
    case deleteComment
    case showMore
    case openFilters
    case emptyCart
    case openSettings
    case resetFFilters
    case showColorPicker
    case placeOrder
    case showIngredients
    case showLess
    
    var id: String {
        switch self {            
        case .confirm:
            return "0NNmuAnRKjD6yyR0H6Kj"
        case .showComments:
            return "C6gNaAywDPUYGMLp4H4b"
        case .stopScrolling:
            return "GIJcZGvjQYtmrLtqWaEd"
        case .applyFilters:
            return "IBpTXYWG7AeEAoRYd5ZO"
        case .goBack:
            return "JXSPXJShWX9ttYQmLc1k"
        case .addComment:
            return "L7eebya6Mv6sSPrK4gYt"
        case .openProfile:
            return "MmFj9UpPofRDmL1R9hCh"
        case .readDescription:
            return "MvwHPDIHRAnJsAHSCy4S"
        case .showCart:
            return "PAzUNSrxJ6UhDXS7hkWk"
        case .addToFavourites:
            return "Q0ZtIvB5hW8Ks1JE5QPv"
        case .scrollUp:
            return "Qv86zkALjvvraiGirDYc"
        case .addToCart:
            return "RNIdfddv7dCOKpNm0Vfz"
        case .goHome:
            return "Remd7ABd6WdX8qE56NTB"
        case .save:
            return "SZcYmOyzGVKDmxlVPufC"
        case .startScrolling:
            return "UbhPEfuxO6nX2jrAiP4J"
        case .removeFromFavourites:
            return "VElcvllwYnsgWap2HSE4"
        case .deleteComment:
            return "aFJKHtMWnpq98QfkvfGA"
        case .showMore:
            return "ag2HQIhTk8ah9xmfzuki"
        case .openFilters:
            return "bK9NZtyTo7VSMgdVgs59"
        case .emptyCart:
            return "hJVod0A84vk8sunGFFz2"
        case .openSettings:
            return "hgd3bvkUeExH5yjtcwVX"
        case .resetFFilters:
            return "kboliQUmDMv1Leq2mht0"
        case .showColorPicker:
            return "pMXNkZGnjVIZmt92MB3l"
        case .placeOrder:
            return "qTUor2iKkaRwe3AE5O3i"
        case .showIngredients:
            return "tIpbkpNdjbP4m7jUDlzZ"
        case .showLess:
            return "yWnewg2FbOR84xdbw6CR"
        }
    }
    
    var plainText: String {
        switch self {
        case .confirm:
            return "confirm"
        case .showComments:
            return "show comments"
        case .stopScrolling:
            return "stop scrolling"
        case .applyFilters:
            return "apply filters"
        case .goBack:
            return "go back"
        case .addComment:
            return "add comment"
        case .openProfile:
            return "open profile"
        case .readDescription:
            return "read description"
        case .showCart:
            return "show cart"
        case .addToFavourites:
            return "add to favourites"
        case .scrollUp:
            return "scroll up"
        case .addToCart:
            return "add to cart"
        case .goHome:
            return "go home"
        case .save:
            return "save"
        case .startScrolling:
            return "start scrolling"
        case .removeFromFavourites:
            return "remove from favourites"
        case .deleteComment:
            return "delete comment"
        case .showMore:
            return "show more"
        case .openFilters:
            return "open filters"
        case .emptyCart:
            return "empty cart"
        case .openSettings:
            return "open settings"
        case .resetFFilters:
            return "reset filters"
        case .showColorPicker:
            return "show color picker"
        case .placeOrder:
            return "place order"
        case .showIngredients:
            return "show ingredients"
        case .showLess:
            return "show less"
        }
    }
    
}

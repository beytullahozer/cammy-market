//
//  RequestType.swift
//  Market
//
//  Created by Beytullah Özer on 24.12.2021.
//

import Foundation

enum RequestType {
    
    case products
    case productDetails(id: Int)
    case addToCart(productId: Int)
    case cart
    case removeCart(id: Int)
    case clearCart
    
    var endPoint: String {
        
        switch self {
            
        case .products:
            return "products"
            
        case .productDetails(id: let id):
            return "products/" + id.toString
            
        case .addToCart(productId: let productId):
            return "addtocart/" + Network.cartId.toString + "/" + productId.toString
            
        case .cart:
            return "cart/" + Network.cartId.toString
            
        case .removeCart(id: let id):
            return "removeproduct/" + Network.cartId.toString + "/" + id.toString
            
        case .clearCart:
            return "clearcart/" + Network.cartId.toString
        }
    }
    
    var httpMethod: HttpMethod {
        
        switch self {
            
        case .addToCart:
            return .POST
        default:
            return .GET
        }
    }
}


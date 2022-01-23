//
//  CartViewModel.swift
//  Market
//
//  Created by Beytullah Özer on 24.12.2021.
//

import Foundation
import UIKit

protocol CartViewModelDelegate: AnyObject {
    
    func didFinishCartOperation()
    
    func didRemoveProduct()
    
    func didSuccessBuy()
}

class CartViewModel {
    
    private let network = Network()
    var products: [Product] = []
    var delegate: CartViewModelDelegate?
    
    func fetchProducts() {
        
        network.request(type: .cart) { (result: Result<BaseResponse<CartResponse>, CustomError>) in
            self.finishCartOperations(result: result)
        }
    }
    
    func removeProduct(with id: Int) {
        
        network.request(type: .removeCart(id: id)) { (result: Result<BaseResponse<CartResponse>, CustomError>) in
            self.finishCartOperations(result: result)
            self.delegate?.didRemoveProduct()
        }
    }
    
    func buyCart() {
        
        network.request(type: .clearCart) { (result: Result<BaseResponse<CartResponse>, CustomError>) in
            self.finishCartOperations(result: result)
            self.delegate?.didSuccessBuy()
        }
    }
    
    private func finishCartOperations(result: Result<BaseResponse<CartResponse>, CustomError>) {
        
        switch result {
        case .success(let response):
            self.products = response.result?.products ?? []
            self.delegate?.didFinishCartOperation()
        case .failure(let customError):
            Logger.log(text: customError.message)
        }
    }
}

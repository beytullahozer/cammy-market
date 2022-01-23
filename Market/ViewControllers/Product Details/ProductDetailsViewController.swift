//
//  ProductDetailsViewController.swift
//  Market
//
//  Created by Beytullah Özer on 24.12.2021.
//

import UIKit

class ProductsDetailsViewController: BaseViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    private let productId: Int
    
    private let network = Network()
    
    init(productId: Int) {
        self.productId = productId
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchProductDetail(with: productId)
    }
    
    func fetchProductDetail(with id: Int) {
        
        network.request(type: .productDetails(id: id)) { (result: Result<BaseResponse<Product>, CustomError>) in
            
            switch result {
            case .success(let response):
                
                DispatchQueue.main.async {
                    
                    self.imageView.setImage(urlString: response.result?.productImage)
                    self.nameLabel.text = response.result?.productName
                    self.priceLabel.text = response.result?.newPrice?.toStringWithCurrency
                }
                
            case .failure(let customError):
                Logger.log(text: customError.message)
            }
        }
    }

    @IBAction func actionAddToCart(_ sender: Any) {
        
        network.request(type: .addToCart(productId: productId)) { (result: Result<BaseResponse<CartResponse>, CustomError>) in
            
            switch result {
            case .success(let success):
                
                DispatchQueue.main.async {
                    
                    let popup = PopupViewController(text: "Ürün sepete başarılı bir şekilde eklendi.", buttonTitle: "Anasayfaya Git", buttonAction: self.buttonAction)
                    popup.modalPresentationStyle = .overCurrentContext
                    popup.modalTransitionStyle = .crossDissolve
                    self.present(popup, animated: true, completion: nil)
                }
                
                Logger.log(text: "Sepete eklendi.")
            case .failure(let customError):
                Logger.log(text: customError.message)
            }
        }
    }
    
    func buttonAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func actionStores(_ sender: Any) {
        let map = MapViewController()
        self.navigationController?.pushViewController(map, animated: true)
    }
}

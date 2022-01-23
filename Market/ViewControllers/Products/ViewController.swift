//
//  ViewController.swift
//  Market
//
//  Created by Beytullah Özer on 24.12.2021.
//

import UIKit

class ViewController: BaseViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    private var products: [Product] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        collectionView.dataSource = self
        collectionView.delegate = self
        
        let nib = UINib(nibName: "ProductCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "ProductCollectionViewCell")
        
        fetchProducts()
    }

    func fetchProducts() {
        
        let network = Network()
        
        network.request(type: .products) { (result: Result<BaseResponse<[Product]>, CustomError>) in
            
            switch result {
            case .failure(let customError):
                Logger.log(text: customError.message)
            case .success(let response):
                Logger.log(type: .warning, text: response.result?.count.toString ?? "")
                self.products = response.result ?? []
                print(response)
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        }
    }
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCollectionViewCell", for: indexPath) as? ProductCollectionViewCell else {
            fatalError("ProductCollectionViewCell oluştulamadı")
        }
        cell.configure(with: products[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = (collectionView.frame.width - 30) / 2
        let height: CGFloat = width * 2
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let productId = products[indexPath.row].id else {
            return
        }
        
        let productDetails = ProductsDetailsViewController(productId: productId)
        self.navigationController?.pushViewController(productDetails, animated: true)
    }
}





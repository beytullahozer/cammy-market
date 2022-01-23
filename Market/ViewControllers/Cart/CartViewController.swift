//
//  CartViewController.swift
//  Market
//
//  Created by Beytullah Özer on 24.12.2021.
//

import UIKit

class CartViewController: BaseViewController {

    private let viewModel = CartViewModel()
    
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.delegate = self
        viewModel.fetchProducts()
        
        navigationItem.rightBarButtonItem = nil
        
        let nib = UINib(nibName: "CartCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "CartCollectionViewCell")
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    @IBAction func actionBuy(_ sender: Any) {
        viewModel.buyCart()
    }
    
}

extension CartViewController: CartViewModelDelegate {
    
    func didRemoveProduct() {
        
        DispatchQueue.main.async {
            let popup = PopupViewController(text: "Ürün sepetten çıkarıldı.", buttonTitle: "Tamam", buttonAction: { })
            popup.modalTransitionStyle = .crossDissolve
            popup.modalPresentationStyle = .overCurrentContext
            self.present(popup, animated: true, completion: nil)
        }
    }
    
    func didSuccessBuy() {
        
        DispatchQueue.main.async {
            let popup = PopupViewController(text: "Satın alma başarılı", buttonTitle: "Anasayfaya Dön", buttonAction: {
                self.navigationController?.popToRootViewController(animated: true)
            })
            popup.modalTransitionStyle = .crossDissolve
            popup.modalPresentationStyle = .overCurrentContext
            self.present(popup, animated: true, completion: nil)
        }
    }
    
    func didFinishCartOperation() {
        DispatchQueue.main.async {
            Logger.log(text: self.viewModel.products.count.toString)
            self.collectionView.reloadData()
        }
    }
}

extension CartViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CartCollectionViewCell", for: indexPath) as? CartCollectionViewCell else {
            fatalError("CartCollectionViewCell oluşturulamadı.")
        }
        cell.delegate = self
        cell.configure(with: viewModel.products[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 60, height: 141)
    }
}

extension CartViewController: CartCollectionViewCellDelegate {
    
    func didTapRemoveButton(with product: Product) {
        
        guard let id = product.id else {
            return
        }
        
        viewModel.removeProduct(with: id)
    }
}

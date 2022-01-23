//
//  CartCollectionViewController.swift
//  Market
//
//  Created by Beytullah Özer on 24.12.2021.
//

import UIKit

protocol CartCollectionViewCellDelegate: AnyObject {
    
    func didTapRemoveButton(with product: Product)
}

class CartCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    var delegate: CartCollectionViewCellDelegate?
    
    private var product: Product?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        nameLabel.text = nil
        priceLabel.text = nil
        imageView.setImage(urlString: nil)
    }

    func configure(with product: Product) {
        self.product = product
        
        imageView.setImage(urlString: product.productImage)
        nameLabel.text = product.productName
        priceLabel.text = product.newPrice?.toStringWithCurrency
    }
    
    @IBAction func actionRemoveButton(_ sender: Any) {
        guard let product = product else {
            Logger.log(text: "product yok")
            return
        }
        delegate?.didTapRemoveButton(with: product)
    }
}

//
//  DulceriaCollectionViewCell.swift
//  retoCP
//
//  Created by Alexander Ynoñan H. on 18/07/21.
//

import UIKit

class DulceriaCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak private var activityImage : UIActivityIndicatorView!
    @IBOutlet weak private var imgCartelera : UIImageView!
    @IBOutlet weak private var lblDescripcion : UILabel!
    @IBOutlet weak private var lblPrecio : UILabel!
    @IBOutlet weak private var lblProduct : UILabel!
    
    var objBE : CandyStoreBE!{
        didSet{
            self.activityImage.startAnimating()
            self.imgCartelera.downloadImagenInUrl(self.objBE.name ?? "", withPlaceHolderImage: nil) { urlImage, image in
                self.activityImage.stopAnimating()
                self.imgCartelera.image = self.objBE.name == urlImage ? image : nil
            }
            self.lblDescripcion.text = self.objBE.descripcion
            self.lblPrecio.text = "S/\(self.objBE.price ?? "")"
            self.lblProduct.alpha = self.objBE.sum_produc > 0 ? 1 : 0
            self.lblProduct.text = "\(self.objBE.sum_produc)"
        }
    }
    
    private func validateSumProduct(){
        
    }
    
}

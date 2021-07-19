//
//  PremieresCollectionViewCell.swift
//  retoCP
//
//  Created by Alexander Ynoñan H. on 18/07/21.
//

import UIKit

class PremieresCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak private var activityImage : UIActivityIndicatorView!
    @IBOutlet weak private var imgCartelera : UIImageView!
    @IBOutlet weak private var lblCartelera : UILabel!
    
    var objBE : PremiereBE!{
        didSet{
            self.activityImage.startAnimating()
            self.imgCartelera.downloadImagenInUrl(self.objBE.image ?? "", withPlaceHolderImage: nil) { urlImage, image in
                self.activityImage.stopAnimating()
                self.imgCartelera.image = self.objBE.image == urlImage ? image : nil
            }
            self.lblCartelera.text = self.objBE.descripcion
        }
    }
    
}

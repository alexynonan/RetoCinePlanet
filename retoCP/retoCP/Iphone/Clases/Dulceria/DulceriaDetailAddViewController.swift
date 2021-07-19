//
//  DulceriaDetailAddViewController.swift
//  retoCP
//
//  Created by Alexander Ynoñan H. on 19/07/21.
//

import UIKit

protocol DulceriaDetailAddViewControllerDelegate {
    func getUpdateDulceria(controller : DulceriaDetailAddViewController, show : Bool)
}

class DulceriaDetailAddViewController: UIViewController {

    @IBOutlet weak private var imgDulceria : UIImageView!
    @IBOutlet weak private var activityImage : UIActivityIndicatorView!
    @IBOutlet weak private var lblDescripcion : UILabel!
    @IBOutlet weak private var lblPrecio : UILabel!
    @IBOutlet weak private var lblProduct : UILabel!
    @IBOutlet weak private var btnStyleAdd : UIButton!
    
    var objBE = CandyStoreBE()
    private var validateConteo = 0
    var delegate : DulceriaDetailAddViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.showDetailCandy()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(withDuration: 0.3) {
            self.view.backgroundColor = UIColor.colorFromHexString("000000", withAlpha: 0.3)
            self.view.layoutIfNeeded()
        }
    }
    
    @IBAction private func btnCancelar(_ sender : UIButton){
        self.dismiss(animated: true) {
            self.objBE.sum_produc = self.validateConteo
            self.delegate?.getUpdateDulceria(controller: self, show: false)
        }
    }
    
    @IBAction private func btnAddProduct(_ sender : UIButton){
        self.dismiss(animated: true) {
            self.delegate?.getUpdateDulceria(controller: self, show: true)
        }
    }
    
    @IBAction private func btnAddOrSubstract(_ sender : UIButton){
        if sender.tag == 1{
            self.objBE.sum_produc += 1
            self.lblProduct.text = "\(self.objBE.sum_produc)"
        }else{
            self.objBE.sum_produc == 0 ? (self.objBE.sum_produc = 0) : (self.objBE.sum_produc -= 1)
            self.lblProduct.text = "\(self.objBE.sum_produc)"
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension DulceriaDetailAddViewController {
    
    private func showDetailCandy(){
        
        self.view.backgroundColor = .clear
        self.activityImage.startAnimating()
        self.imgDulceria.downloadImagenInUrl(self.objBE.name ?? "", withPlaceHolderImage: nil) { urlImage, image in
            self.activityImage.stopAnimating()
            self.imgDulceria.image = self.objBE.name == urlImage ? image : nil
        }
        self.lblDescripcion.text = self.objBE.descripcion
        self.lblPrecio.text = "S/\(self.objBE.price ?? "")"
        self.lblProduct.text = "\(self.objBE.sum_produc)"
        self.validateConteo = self.objBE.sum_produc
        
    }
    
    private func animateAdd(show : Bool){
        self.btnStyleAdd.alpha = show ? 0.5 : 1
        self.btnStyleAdd.isUserInteractionEnabled = !show
    }
}

//
//  PayViewController.swift
//  retoCP
//
//  Created by Alexander Ynoñan H. on 19/07/21.
//

import UIKit

class PayViewController: UIViewController {

    @IBOutlet weak private var txtNroTarjeta  : UITextField!
    @IBOutlet weak private var txtFechaExpira : UITextField!
    @IBOutlet weak private var txtCVV         : UITextField!
    @IBOutlet weak private var txtCorreo      : UITextField!
    @IBOutlet weak private var txtName        : UITextField!
    @IBOutlet weak private var txtTipoDocument : UITextField!
    @IBOutlet weak private var txtNroDocument : UITextField!
    @IBOutlet weak private var activityImage : UIActivityIndicatorView!
    
    var total = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadDatos()
        // Do any additional setup after loading the view.
    }
    
    private func loadDatos(){
        
        if let data = UserSessionBL.getSession(){
            self.txtCorreo.text = data.email
            self.txtName.text = data.name
        }
    }
    //4907840000000005
    
    @IBAction private func senPago(_ sender : UIButton){
        
//        TARJETA : 4907840000000005
//        CVV : 777
//        FECHA : 2024/08
        
        let obj = CompleteBE()
        
        obj.numeroTarjeta = self.txtNroTarjeta.text
        obj.fechaExpiracion = self.txtFechaExpira.text
        obj.cvv = self.txtCVV.text
        obj.mail = self.txtCorreo.text
        obj.name = self.txtName.text
        obj.dni = self.txtNroDocument.text
        obj.monto = Double(self.total)
        self.animeLoad(show: true)
        PayBL.sendPayment(obj: obj) { message in
            self.animeLoad(show: false)
            self.showAlert(withTitle: Alert.titleError, withMessage: message, withAcceptButton: Alert.agreedButton) {
                for item in self.navigationController?.viewControllers ?? []{
                    if item.classNameAsString() == "UITabBarController"{
                        self.navigationController?.popToViewController(item, animated: true)
                    }
                }
            }
            
        } errorServices: { errror in
            self.animeLoad(show: false)
            self.showAlert(withTitle: Alert.titleError, withMessage: errror, withAcceptButton: Alert.agreedButton) {
                
            }
        }

    }

    private func animeLoad(show : Bool){
        show ? self.activityImage.startAnimating() : self.activityImage.stopAnimating()
        self.view.isUserInteractionEnabled = !show
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

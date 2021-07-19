//
//  LoginPopViewController.swift
//  retoCP
//
//  Created by Alexander Ynoñan H. on 18/07/21.
//

import UIKit

class LoginPopViewController: UIViewController {

    @IBOutlet weak private var lblName : UILabel!
    
    var viewControllerLogin : UIViewController?
    var objUser = UserBE()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .clear
        self.lblName.text = "Bienvenido, \(self.objUser.name ?? "")"
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 0.3) {
            self.view.backgroundColor = UIColor.colorFromHexString("000000", withAlpha: 0.3)
            self.view.layoutIfNeeded()
        }        
    }

    @IBAction private func btnExitDismiss(_ sender : UIButton){
        self.dismiss(animated: true) {
            self.viewControllerLogin?.performSegue(withIdentifier: Segue.DulceriaViewController, sender: self.objUser)
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

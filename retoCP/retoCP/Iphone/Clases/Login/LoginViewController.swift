//
//  LoginViewController.swift
//  retoCP
//
//  Created by Alexander Ynoñan H. on 18/07/21.
//

import UIKit
import GoogleSignIn
import Firebase

class LoginViewController: UIViewController {
    
    @IBOutlet private var arrayConstraintButton : [NSLayoutConstraint]!
    @IBOutlet private var arrayButton           : [UIButton]!
    @IBOutlet weak private var lblName          : UILabel!
    @IBOutlet weak private var imgUser          : UIImageView!
    @IBOutlet weak private var activityUSer     : UIActivityIndicatorView!
    @IBOutlet weak private var btnStyleExit     : UIButton!
    
    var statePremire = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance().presentingViewController = self
        GIDSignIn.sharedInstance().delegate = self
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.btnStyleExit.alpha = self.statePremire ? 1 : 0
        self.sessionLoad()
    }
    
    @IBAction private func btnInvitado(_ sender : UIButton){
        
        let obj = UserBE()
        
        obj.name = "Invitado"
        obj.email = "a"
        obj.photo = "a"
        obj.id = "0"
        
        if UserSessionBL.saveSession(objUser: obj){
            self.updateLogin(obj: obj)
            self.validatePremire(obj: obj)
        }
    }
    
    @IBAction private func btnGoogle(_ sender : UIButton){
        GIDSignIn.sharedInstance().signOut()
        GIDSignIn.sharedInstance().signIn()
    }
    
    @IBAction private func btnExitSession(_ sender : UIButton){
        if UserSessionBL.deleteSession() {
            self.navigationController?.popToRootViewController(animated: true)
        }else{
            self.showAlert(withTitle: Alert.titleUpsError, withMessage: Alert.Services.messageSession, withAcceptButton: Alert.agreedButton, withCompletion: nil)
        }
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if let controller = segue.destination as? DulceriaViewController{
            controller.statePremiers = self.statePremire
        }else if let controller = segue.destination as? LoginPopViewController {
            controller.viewControllerLogin = self
            controller.objUser = sender as! UserBE
        }
    }

}

//MARK: -Methods

extension LoginViewController {
    
    private func sessionLoad(){
        
        if let user = UserSessionBL.getSession(){
            
            self.hideLogin(state: true)
            self.lblName.text = "Hola, \(user.name ?? "")"
            self.activityUSer.startAnimating()
            self.imgUser.downloadImagenInUrl(user.photo ?? "", withPlaceHolderImage: nil) { urlImage, image in
                self.activityUSer.stopAnimating()
                self.imgUser.image = urlImage == user.photo ? image : nil
            }
        }else{
            self.hideLogin(state: false)
        }
    }
    
    private func hideLogin(state : Bool){
        self.arrayConstraintButton[0].constant = state ? 0 : 50
        self.arrayConstraintButton[1].constant = state ? 0 : 50
        self.arrayConstraintButton[2].constant = state ? 0 : 50
        self.arrayButton[0].alpha = state ? 0 : 1
        self.arrayButton[1].alpha = state ? 0 : 1
        
        self.arrayButton[2].alpha = state ? 1 : 0
        self.lblName.alpha = state ? 1 : 0
        self.imgUser.alpha = state ? 1 : 0
    }
    
}

//MARK: -DelegateGoogle

extension LoginViewController : GIDSignInDelegate {
    
    func sign(_ signIn: GIDSignIn, didSignInFor user: GIDGoogleUser, withError error: Error!) {
        
        guard let userData = user.authentication else { return }
                    
        let credencial = GoogleAuthProvider.credential(withIDToken: userData.idToken, accessToken: user.authentication.accessToken)
        
        self.loadAlertService(message: "Espere porfavor ...", style: .alert) {
        
            Auth.auth().signIn(with: credencial) { result, error in
            
                guard let _ = result else { return }
                
                let objUser = UserBE()
                
                objUser.name = result?.user.displayName
                objUser.email = result?.user.email
                objUser.id = result?.user.uid
                objUser.photo = result?.user.photoURL?.absoluteString
                
                if UserSessionBL.saveSession(objUser: objUser){
                    self.dismiss(animated: true, completion: nil)
                    self.updateLogin(obj: objUser)
                    self.validatePremire(obj: objUser)
                    
                }else{
                    self.dismiss(animated: true, completion: nil)
                    GIDSignIn.sharedInstance().signOut()
                    self.navigationController?.popToRootViewController(animated: true)
                }
            }
        }
    }
    
    
    private func updateLogin(obj : UserBE){
        
        self.hideLogin(state: true)
        self.lblName.text = "Hola, \(obj.name ?? "")"
        self.activityUSer.startAnimating()
        self.imgUser.downloadImagenInUrl(obj.photo ?? "", withPlaceHolderImage: nil) { urlImage, image in
            self.activityUSer.stopAnimating()
            self.imgUser.image = urlImage == urlImage ? image : nil
        }
    }
    
    private func validatePremire(obj : UserBE){
        if self.statePremire == true{
            self.performSegue(withIdentifier: Segue.LoginPopViewController, sender: obj)
        }else{
            
        }
    }
    
}

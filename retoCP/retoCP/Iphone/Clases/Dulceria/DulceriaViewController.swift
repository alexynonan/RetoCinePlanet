//
//  DulceriaViewController.swift
//  retoCP
//
//  Created by Alexander Ynoñan H. on 18/07/21.
//

import UIKit

class DulceriaViewController: UIViewController {

    @IBOutlet weak private var clvDulceria : UICollectionView!
    @IBOutlet weak private var btnStyleExit : UIButton!
    @IBOutlet weak private var lblPrice : UILabel!
    @IBOutlet weak private var btnStylePagar : UIButton!
    @IBOutlet weak private var constraintCollection : NSLayoutConstraint!
    
    var statePremiers = false
    
    private var calcularSuma = 0.00
    
    private var arrayDulceria = [CandyStoreBE](){
        didSet{
            self.clvDulceria.reloadSections(IndexSet(arrayLiteral: 0))
        }
    }
    
    lazy private var refreshControll : UIRefreshControl! = {
       
        var objRefreshControl = UIRefreshControl()
        objRefreshControl.tintColor = .white        
        objRefreshControl.addTarget(self, action: #selector(self.getDulceria), for: .valueChanged)
        return objRefreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.clvDulceria.backgroundView = self.refreshControll        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.btnStyleExit.alpha = self.statePremiers ? 1 : 0
        self.getDulceria()
    }
    
    @IBAction private func btnPagar(_ sender : UIButton){

        self.showAlert(withTitle: Alert.titleError, withMessage: Alert.Pay.messagePay, withButtons: [Alert.acceptButton], withCancelButton: Alert.cancelButton) { index in
            
            self.performSegue(withIdentifier: Segue.PayViewController, sender: nil)
            
        } withActionCancel: {
            
        }

    }
    
    @IBAction private func btnExitController(_ sender: UIButton){
        for item in self.navigationController?.viewControllers ?? []{
            if item.classNameAsString() == "UITabBarController"{
                self.navigationController?.popToViewController(item, animated: true)
            }
        }
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if let controller = segue.destination as? DulceriaDetailAddViewController{
            controller.objBE = sender as! CandyStoreBE
            controller.delegate = self
        }else if let controller = segue.destination as? PayViewController{
            controller.total = String(format: "%.2f", self.calcularSuma)
        }
    }

}

//MARK: -Methods
extension DulceriaViewController{

    @objc private func getDulceria(){
        self.refreshControll.beginRefreshing()
        self.animatePay(show: true)
        self.lblPrice.text = "S/0.00"
        CandyStoreBL.getCandy{ array in
            self.refreshControll.endRefreshing()
            self.arrayDulceria = array
        } errorServices: { error in
            self.refreshControll.endRefreshing()
            self.showAlert(withTitle: Alert.titleUpsError, withMessage: error, withAcceptButton: Alert.agreedButton) {
                self.btnExit(nil)
            }
        }
    }
    
    private func animatePay(show : Bool){
        self.constraintCollection.constant = show ? 0 : 80
        self.btnStylePagar.alpha = show ? 0 : 1
    }
}

//MARK: -DulceriaDelegate
extension DulceriaViewController : DulceriaDetailAddViewControllerDelegate {
    
    func getUpdateDulceria(controller: DulceriaDetailAddViewController, show: Bool) {
        
        self.calcularSuma = 0.00
        
        for item in self.arrayDulceria{
            if item.sum_produc > 0{
                for _ in 1...item.sum_produc{
                    self.calcularSuma += Double(item.price ?? "") ?? 0.00 * Double(item.sum_produc)
                }
            }
        }
        
        self.animatePay(show: self.calcularSuma == 0 ? true : false)
        
        let convert = String(format: "%.2f", self.calcularSuma)
        
        self.lblPrice.text = "S/\(convert)"
                
        self.clvDulceria.reloadSections(IndexSet(arrayLiteral: 0))
    }
    
}

extension DulceriaViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.arrayDulceria.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let identifier = CellIdentifier.DulceriaCollectionViewCell
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! DulceriaCollectionViewCell
        
        cell.objBE = self.arrayDulceria[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
        let obj = self.arrayDulceria[indexPath.row]
                
        if let _ = UserSessionBL.getSession(){
            self.performSegue(withIdentifier: Segue.DulceriaDetailAddViewController, sender: obj)            
        }else{
            self.tabBarController?.selectedIndex = 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let numberOfElements : CGFloat = 2
        let widthCell  = (UIScreen.main.bounds.width - (numberOfElements + 1) * 11) / numberOfElements
        let heightCell : CGFloat = 250
        
        return CGSize(width: widthCell, height: heightCell)
    }
}

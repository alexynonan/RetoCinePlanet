//
//  PremieresViewController.swift
//  retoCP
//
//  Created by Alexander Ynoñan H. on 18/07/21.
//

import UIKit

class PremieresViewController: UIViewController {

    @IBOutlet weak private var clvPremieres : UICollectionView!
    
    private var arrayPremieres = [PremiereBE](){
        didSet{
            self.clvPremieres.reloadSections(IndexSet(arrayLiteral: 0))
        }
    }
    
    var statePremire = false
    
    lazy private var refreshControll : UIRefreshControl! = {
       
        var objRefreshControl = UIRefreshControl()
        objRefreshControl.tintColor = .white        
        objRefreshControl.addTarget(self, action: #selector(self.getPremieres), for: .valueChanged)
        return objRefreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.timerScroll()
        self.clvPremieres.backgroundView = self.refreshControll
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.getPremieres()
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if let controller = segue.destination as? LoginViewController{
            controller.statePremire = self.statePremire
        }
    }
    

}

//MARK: -Methods
extension PremieresViewController{
    
    @objc private func getPremieres(){
        self.refreshControll.beginRefreshing()
        PremireBL.getPremieres { array in
            self.refreshControll.endRefreshing()
            self.arrayPremieres = array
        } errorServices: { error in
            self.refreshControll.endRefreshing()
            self.showAlert(withTitle: Alert.titleUpsError, withMessage: error, withAcceptButton: Alert.agreedButton) {
                self.btnExit(nil)
            }
        }

    }
    
    private func timerScroll(){
        Timer.scheduledTimer(timeInterval: 4.0, target: self, selector: #selector(self.scrollAutomatically), userInfo: nil, repeats: true)
    }
    
    @objc func scrollAutomatically(_ timer1: Timer){
        
        if let coll  = self.clvPremieres {
            
            for cell in coll.visibleCells {
                
                guard let indexPath = coll.indexPath(for: cell) else { return }
                
                if indexPath.row  < self.arrayPremieres.count - 1{

                    let index = IndexPath(row: indexPath.row + 1, section: indexPath.section)
                    coll.scrollToItem(at: index, at: .right, animated: true)
                }else{
                    let indexPath1 = IndexPath(item: 0, section: 0)
                    coll.scrollToItem(at: indexPath1, at: .left, animated: false)
                }
            }
        }
    }
}

extension PremieresViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.arrayPremieres.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let identifier = CellIdentifier.PremieresCollectionViewCell
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! PremieresCollectionViewCell
        
        cell.objBE = self.arrayPremieres[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let obj = self.arrayPremieres[indexPath.row]
        
        if let _ = UserSessionBL.getSession(){
            self.tabBarController?.selectedIndex = 1
        }else{
            self.statePremire = true
            self.performSegue(withIdentifier: Segue.LoginViewController, sender: obj)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let widthCell  = collectionView.layer.bounds.size.width
        let heightCell = collectionView.layer.bounds.size.height
        
        return CGSize(width: widthCell, height: heightCell)
    }
}

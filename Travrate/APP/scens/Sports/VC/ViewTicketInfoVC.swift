//
//  ViewTicketInfoVC.swift
//  Travgate
//
//  Created by FCI on 10/05/24.
//

import UIKit

class ViewTicketInfoVC: BaseTableVC {
    
    static var newInstance: ViewTicketInfoVC? {
        let storyboard = UIStoryboard(name: Storyboard.Sports.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? ViewTicketInfoVC
        return vc
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        if callapibool == true {
            
            MySingleton.shared.loderString = "fdetails"
            MySingleton.shared.afterResultsBool = true
            loderBool = true
            showLoadera()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) { [unowned self] in
                loderBool = false
                hideLoadera()
            }
            
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
    }
    
    
   
    
    @IBAction func didTapOnBackBtnAction(_ sender: Any) {
        callapibool = false
        dismiss(animated: true)
    }
    
    //MARK: - ViewStadiumBtnsTVCell Delegate Methods
    override func didTapOnViewStadiumBtnAction(cell: ViewStadiumBtnsTVCell) {
        gotoViewStadiumVC(keystr: "stadium")
    }
    
    override func didTapOnSeatingArrangementsBtnAction(cell: ViewStadiumBtnsTVCell) {
        gotoViewStadiumVC(keystr: "seat")
    }
    
    override func didTapOnBookNowBtnAction(cell: SportsBookNowTVCell) {
      
    }
    
    func gotoViewStadiumVC(keystr:String) {
        guard let vc = ViewStadiumVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        vc.keystr = keystr
        self.present(vc, animated: false)
    }
    
    override func didTapOnConfBtnAction(cell: SportsBookNowTVCell) {
        print("didTapOnConfBtnAction")
    }
    
    
    
    
}



extension ViewTicketInfoVC {
    
    
    func setupUI(){
        
        commonTableView.registerTVCells(["SelectedSportInfoTVCell",
                                         "SportsStadiumTVCell",
                                         "ViewStadiumBtnsTVCell",
                                         "SportsBookNowTVCell",
                                         "EmptyTVCell"])
        setupVisaTVCells()
        
    }
    
    
    func setupVisaTVCells() {
        
        MySingleton.shared.tablerow.removeAll()
        
        MySingleton.shared.tablerow.append(TableRow(cellType:.SelectedSportInfoTVCell))
        MySingleton.shared.tablerow.append(TableRow(cellType:.SportsStadiumTVCell))
        MySingleton.shared.tablerow.append(TableRow(cellType:.ViewStadiumBtnsTVCell))
        
        
        for _ in 0...10 {
            MySingleton.shared.tablerow.append(TableRow(cellType:.SportsBookNowTVCell))
        }

        MySingleton.shared.tablerow.append(TableRow(height:50,cellType:.EmptyTVCell))
        
        commonTVData = MySingleton.shared.tablerow
        commonTableView.reloadData()
    }
    
    
   
}

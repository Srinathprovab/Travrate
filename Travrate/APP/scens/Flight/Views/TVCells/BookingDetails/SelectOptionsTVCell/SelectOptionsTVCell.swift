//
//  SelectOptionsTVCell.swift
//  Travrate
//
//  Created by Admin on 02/07/24.
//

import UIKit

protocol SelectOptionsTVCellDeegate: AnyObject {
    func didTapOnOptionsButtonAction(cell:SelectOptionsTVCell)
}

class SelectOptionsTVCell: TableViewCell {
    
    @IBOutlet weak var infoCV: UICollectionView!

    var infoArrayCountBool = Bool()
    var infoArray = ["Add Baggage","Meal","Add Insurance","Add Special assistance"]
    var infoimgArray = ["in1","in2","in3","in4"]
    weak var delegate:SelectOptionsTVCellDeegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func setupUI() {
        setupinfoCV()
    }
    
}



extension SelectOptionsTVCell:UICollectionViewDelegate,UICollectionViewDataSource {
    
    
    func setupinfoCV() {
        
        let nib = UINib(nibName: "InfoCVCell", bundle: nil)
        infoCV.register(nib, forCellWithReuseIdentifier: "cell1")
        infoCV.delegate = self
        infoCV.dataSource = self
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 150, height: 50)
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 5
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        infoCV.collectionViewLayout = layout
        infoCV.isScrollEnabled = false
        infoCV.allowsMultipleSelection = true
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return infoArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var commonCell = UICollectionViewCell()
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell1", for: indexPath) as? InfoCVCell {
            
            cell.titlelbl.text = infoArray[indexPath.row]
            cell.img.image = UIImage(named: infoimgArray[indexPath.row])
            
            
            // Check if the item is selected and update the checkbox accordingly
            if MySingleton.shared.infoArray.contains(cell.titlelbl.text ?? "") {
                cell.checkimg.image = UIImage(named: "check")
                infoCV.selectItem(at: indexPath, animated: false, scrollPosition: .left)
            } else {
                cell.checkimg.image = UIImage(named: "uncheck")?.withRenderingMode(.alwaysOriginal).withTintColor(.Buttoncolor)
            }
            
            
            
            
            commonCell = cell
        }
        return commonCell
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let cell = collectionView.cellForItem(at: indexPath) as? InfoCVCell {
            cell.checkimg.image = UIImage(named: "check")
            MySingleton.shared.infoArray.append(cell.titlelbl.text ?? "")
            
            
            // Update the boolean value based on the selected item
            updateBoolValue(for: cell.titlelbl.text, isSelected: true)
            
            if MySingleton.shared.infoArray.count <= 0 {
                infoArrayCountBool = false
            }else {
                infoArrayCountBool = true
            }
            
            delegate?.didTapOnOptionsButtonAction(cell: self)
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? InfoCVCell {
            cell.checkimg.image = UIImage(named: "uncheck")?.withRenderingMode(.alwaysOriginal).withTintColor(.Buttoncolor)
            
            if let index =  MySingleton.shared.infoArray.firstIndex(of: cell.titlelbl.text ?? "") {
                MySingleton.shared.infoArray.remove(at: index)
            }
            
            // Update the boolean value based on the deselected item
            updateBoolValue(for: cell.titlelbl.text, isSelected: false)
            
            if MySingleton.shared.infoArray.count <= 0 {
                infoArrayCountBool = false
            }else {
                infoArrayCountBool = true
            }
            
            delegate?.didTapOnOptionsButtonAction(cell: self)
        }
    }
    
    
    func updateBoolValue(for title: String?, isSelected: Bool) {
        guard let title = title else { return }
        
        switch title {
        case "Add Baggage":
            MySingleton.shared.addBaggageBool = isSelected
        case "Meal":
            MySingleton.shared.addMealBool = isSelected
        case "Add Insurance":
            MySingleton.shared.addInsuranceBool = isSelected
        case "Add Special assistance":
            MySingleton.shared.addSpecialAssistanceBool = isSelected
        case "Add Seat":
            MySingleton.shared.addSeatBool = isSelected
        case "Add airport Transfers":
            MySingleton.shared.addAirportTransfersBool = isSelected
        default:
            break
        }
    }
    
}

//
//  ChooseAdditionalOptionsTVCell.swift
//  Travrate
//
//  Created by FCI on 14/06/24.
//

import UIKit

struct AdditionalOption {
    var title: String?
    var price: String?
    var currency:String?
}


protocol ChooseAdditionalOptionsTVCellDelegate {
    func didTapOnAdditionalOptionasBtnAction(cell:ChooseAdditionalOptionsTVCell)
}


class ChooseAdditionalOptionsTVCell: TableViewCell {
    
    
    @IBOutlet weak var optionscv: UICollectionView!
    
    
    
    
    var delegate:ChooseAdditionalOptionsTVCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupCV()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override func updateUI() {
        
        optionscv.reloadData()
    }
    
}



extension ChooseAdditionalOptionsTVCell:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func setupCV() {
        
        let nib = UINib(nibName: "AdditionalOptionsCVCell", bundle: nil)
        optionscv.register(nib, forCellWithReuseIdentifier: "cell")
        optionscv.delegate = self
        optionscv.dataSource = self
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 178, height: 70)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        optionscv.collectionViewLayout = layout
        optionscv.bounces = false
        optionscv.allowsMultipleSelection = true
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  MySingleton.shared.extraOption.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var commonCell = UICollectionViewCell()
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? AdditionalOptionsCVCell {
            
            cell.namelbl.text =  MySingleton.shared.extraOption[indexPath.row].option_name
            
            MySingleton.shared.setAttributedTextnew(str1:  MySingleton.shared.extraOption[indexPath.row].option_currency ?? "",
                                                    str2:  MySingleton.shared.extraOption[indexPath.row].option_price ?? "",
                                                    lbl: cell.pricelbl,
                                                    str1font: .InterMedium(size: 14),
                                                    str2font: .InterMedium(size: 14),
                                                    str1Color: .TitleColor,
                                                    str2Color: .TitleColor)
            
            
            
            
            if optionsIndexpathArray.contains(indexPath) {
                collectionView.selectItem(at: indexPath, animated: false, scrollPosition: .top)
                cell.checkimg.image = UIImage(named: "newcheck")
            }else {
                collectionView.deselectItem(at: indexPath, animated: false)
                cell.checkimg.image = UIImage(named: "newuncheck")
            }
            
            commonCell = cell
        }
        return commonCell
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? AdditionalOptionsCVCell {
            cell.checkimg.image = UIImage(named: "newcheck")
            
            optionsIndexpathArray.append(indexPath)
            
            let option = MySingleton.shared.extraOption[indexPath.row]
            let selectedOption = AdditionalOption(title: option.option_name,price: option.option_price,currency: option.option_currency)
            selectedOptions.append(selectedOption)
            
            totlConvertedGrand += (Double(selectedOption.price ?? "") ?? 0.0)
            
            
            delegate?.didTapOnAdditionalOptionasBtnAction(cell: self)
        }
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? AdditionalOptionsCVCell {
            cell.checkimg.image = UIImage(named: "newuncheck")
            
            if let index = optionsIndexpathArray.firstIndex(of: indexPath) {
                optionsIndexpathArray.remove(at: index)
            }
            
            
            let option = MySingleton.shared.extraOption[indexPath.row]
            let deselectedOption = AdditionalOption(title: option.option_name, price: option.option_price,currency: option.option_currency)
            if let index = selectedOptions.firstIndex(where: { $0.title == deselectedOption.title && $0.price == deselectedOption.price && $0.currency == deselectedOption.currency }) {
                selectedOptions.remove(at: index)
            }
            
            totlConvertedGrand -= (Double(deselectedOption.price ?? "") ?? 0.0)
          
            delegate?.didTapOnAdditionalOptionasBtnAction(cell: self)
        }
    }
    
    
    
}


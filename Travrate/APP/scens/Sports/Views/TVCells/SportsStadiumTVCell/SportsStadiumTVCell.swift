//
//  SportsStadiumTVCell.swift
//  Travgate
//
//  Created by FCI on 10/05/24.
//

import UIKit

protocol SportsStadiumTVCellDelegate {
    func didTapOnTicketsBtnAction(cell:SportsStadiumTVCell)
}

class SportsStadiumTVCell: TableViewCell {
    
    @IBOutlet weak var ticketsCV: UICollectionView!
    
    var ticketsArray = ["All","1 Ticket","2 Ticket","3 Ticket","4 Ticket","5 Ticket","5+ Ticket"]
    var delegate:SportsStadiumTVCellDelegate?
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
        setupCV()
    }
    
}



//extension SportsStadiumTVCell:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
//    
//    func setupCV() {
//        
//        let nib = UINib(nibName: "TicketCVCell", bundle: nil)
//        ticketsCV.register(nib, forCellWithReuseIdentifier: "cell")
//        ticketsCV.delegate = self
//        ticketsCV.dataSource = self
//        let layout = UICollectionViewFlowLayout()
//       // layout.itemSize = CGSize(width: 90, height: 30)
//        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
//        layout.scrollDirection = .vertical
//        layout.minimumInteritemSpacing = 5
//        layout.minimumLineSpacing = 5
//        ticketsCV.collectionViewLayout = layout
//        ticketsCV.bounces = false
//        
//    }
//    
//    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return ticketsASrray.count
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        var commonCell = UICollectionViewCell()
//        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? TicketCVCell {
//            
//            cell.titlelbl.text = ticketsASrray[indexPath.row]
//            
//            if indexPath.row == 0 {
//                cell.holderView.backgroundColor = .Buttoncolor
//                cell.titlelbl.textColor = .WhiteColor
//                collectionView.selectItem(at: indexPath, animated: false, scrollPosition: .top)
//            }
//            
//            commonCell = cell
//        }
//        return commonCell
//    }
//    
//    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        if let cell = collectionView.cellForItem(at: indexPath) as? TicketCVCell {
//            cell.holderView.backgroundColor = .Buttoncolor
//            cell.titlelbl.textColor = .WhiteColor
//        }
//    }
//    
//    
//    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
//        if let cell = collectionView.cellForItem(at: indexPath) as? TicketCVCell {
//            cell.holderView.backgroundColor = HexColor("#DFDFDF")
//            cell.titlelbl.textColor = .TitleColor
//        }
//    }
//    
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//            let label = UILabel(frame: CGRect.zero)
//            label.text = ticketsASrray[indexPath.item]
//            label.sizeToFit()
//            return CGSize(width: label.frame.width + 10, height: 30)
//        }
//
//    
//}



extension SportsStadiumTVCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func setupCV() {
        let nib = UINib(nibName: "TicketCVCell", bundle: nil)
        ticketsCV.register(nib, forCellWithReuseIdentifier: "cell")
        ticketsCV.delegate = self
        ticketsCV.dataSource = self
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 5
        ticketsCV.collectionViewLayout = layout
        ticketsCV.bounces = false
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ticketsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var commonCell = UICollectionViewCell()
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? TicketCVCell {
            cell.titlelbl.text = ticketsArray[indexPath.row]
            
            if indexPath.row == 0 {
                cell.holderView.backgroundColor = .Buttoncolor
                cell.titlelbl.textColor = .WhiteColor
                collectionView.selectItem(at: indexPath, animated: false, scrollPosition: .top)
                
                let selectedTicketType = ticketsArray[indexPath.row]
                filterAndAppendData(for: selectedTicketType)
            }
            
            commonCell = cell
        }
        
        return commonCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? TicketCVCell else {
            return
        }
        
        cell.holderView.backgroundColor = .Buttoncolor
        cell.titlelbl.textColor = .WhiteColor
        
        // Get the selected ticket type
        let selectedTicketType = ticketsArray[indexPath.row]
        
        // Filter and append the data
        filterAndAppendData(for: selectedTicketType)
        delegate?.didTapOnTicketsBtnAction(cell: self)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? TicketCVCell else {
            return
        }
        
        cell.holderView.backgroundColor = HexColor("#DFDFDF")
        cell.titlelbl.textColor = .TitleColor
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let label = UILabel(frame: CGRect.zero)
        label.text = ticketsArray[indexPath.item]
        label.sizeToFit()
        return CGSize(width: label.frame.width + 10, height: 30)
    }
    
    
    
    
     func filterAndAppendData(for ticketType: String) {
        
         filteredSportsTickekData.removeAll()

        // Filter the sports details based on the selected ticket type
        let filteredData = MySingleton.shared.sportsDetailsData?.filter { data in
            let ticketValue = "\(data.availableSellingQuantities?.count ?? 0)"
            
            // Implement filtering logic
            if ticketType == "All" {
                return true // Show all items if "All" is selected
            }
            
            if ticketType == "5+ Ticket" {
                return data.availableSellingQuantities?.count ?? 0 >= 5 // Check if available quantities are 5 or more
            }
            
            // Compare the ticket value with the selected ticket type
            return ticketValue == ticketType.prefix(1)
        } ?? []

         filteredSportsTickekData = filteredData
       
    }
    
    
    

}

//
//  BDCancellationStringTVCell.swift
//  Travrate
//
//  Created by Admin on 20/08/24.
//

import UIKit

class BDCancellationStringTVCell: UITableViewCell {
    
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var cancellationStringTV: UITableView!
    @IBOutlet weak var tvheight: NSLayoutConstraint!
    
    
    var cancellation_string = [Cancellation_string]()
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
        setuplabels(lbl: titlelbl, text: "", textcolor: .BooknowBtnColor, font:.OpenSansBold(size: 16), align: .left)
        setupTV()
       
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.layoutIfNeeded()
        let contentHeight = contentView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
        self.frame.size.height = contentHeight
    }
    
    
}


extension BDCancellationStringTVCell :UITableViewDataSource, UITableViewDelegate {
    
    
    func updateHeight() {
        tvheight.constant = CGFloat((cancellation_string.count) * 45)
        cancellationStringTV.reloadData()
    }
    
    
    func setupTV() {
        cancellationStringTV.register(UINib(nibName: "CancellationInfoTVCell", bundle: nil), forCellReuseIdentifier: "cell")
        cancellationStringTV.delegate = self
        cancellationStringTV.dataSource = self
        cancellationStringTV.tableFooterView = UIView()
        cancellationStringTV.showsHorizontalScrollIndicator = false
        cancellationStringTV.separatorStyle = .singleLine
        cancellationStringTV.isScrollEnabled = false
        cancellationStringTV.separatorStyle = .none
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cancellation_string.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var c = UITableViewCell()
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? CancellationInfoTVCell {
            
            cell.selectionStyle = .none
            let data = cancellation_string[indexPath.row]
            cell.titlelbl.text = data.policy
            
            c = cell
            
        }
        return c
    }
    
    
}

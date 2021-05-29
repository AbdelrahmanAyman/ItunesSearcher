//
//  SearchCell.swift
//  ItunesSearcher
//
//  Created by AH MARWAN  on 29/05/21.
//

import UIKit
import SDWebImage

class SearchCell: UITableViewCell {

    // MARK:- Outlets
    // Offer View
    @IBOutlet weak var thumbnailImg: UIImageView!
    @IBOutlet weak var trackName: UILabel!
    @IBOutlet weak var artistName: UILabel!
    
    func setUpCell(result: Result){
        
        // Set backgroundColor
        contentView.backgroundColor = .clear
        
        // Set thumbnail
        thumbnailImg.contentMode = .scaleAspectFill
        if let url = URL(string: result.artworkUrl100 ?? "" ){
            thumbnailImg.sd_setImage(with: url, placeholderImage: UIImage(named: "place-holder"))
        }
        
        // Check to hidden trackName when arrived empty
        if result.trackName?.isEmpty == true {
            trackName.isHidden = true
        }else{
            trackName.isHidden = false
        }
        
        // Set trackName
        trackName.text = result.trackName
        trackName.textColor = Config.white
        trackName.font = medium(Config.title)
        trackName.numberOfLines = 1
        
        // Set artistName
        artistName.text = result.artistName
        artistName.textColor = Config.gray
        artistName.font = regular(Config.headline)
        artistName.numberOfLines = 1
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}

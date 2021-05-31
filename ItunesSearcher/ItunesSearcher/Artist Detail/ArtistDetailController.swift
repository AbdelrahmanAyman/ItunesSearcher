//
//  ArtistDetailController.swift
//  ItunesSearcher
//
//  Created by AH MARWAN  on 30/05/21.
//

import UIKit

class ArtistDetailController: UIViewController {
        
    // MARK:- Outlets
    @IBOutlet weak var popViewBackground: UIView!
    @IBOutlet weak var artworkImg: UIImageView!
    @IBOutlet weak var artistName: UILabel!
    @IBOutlet weak var trackName: UILabel!
    @IBOutlet weak var albumName: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var price: UILabel!
    
    // MARK: - Properties
    var entity: Result!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showAnimate()
        setUpView()
        addGesture()
    }
    

}


// MARK: - Func Helper
extension ArtistDetailController {
    
    func addGesture(){
        self.view.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismiss))
        self.view.addGestureRecognizer(tap)
    }
    
    @objc func dismiss(_ sender: UITapGestureRecognizer){
        removeAnimate()
    }
    
    func showAnimate(){
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0;
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        });
    }
    
    func removeAnimate(){
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.view.alpha = 0.0;
        }, completion:{(finished : Bool)  in
            if (finished){
                self.view.removeFromSuperview()
                self.dismiss(animated: true, completion: nil)
            }
        });
    }
    
}


// MARK:- Func SetUpView
extension ArtistDetailController {
    
    func setUpView(){
        
        // Set backgroundColor View
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        
        // Set popViewBackground View
        popViewBackground.backgroundColor = Config.darkBlue
        popViewBackground.layer.cornerRadius = Config.cornerRadius
        
        // Set artworkImg
        // set the artwork in a circular picture
        artworkImg.contentMode = .scaleAspectFill
        artworkImg.layer.cornerRadius = artworkImg.frame.height / 2
        artworkImg.layer.masksToBounds = false
        artworkImg.clipsToBounds = true
        artworkImg.layer.borderWidth = 1.0
        artworkImg.layer.borderColor = #colorLiteral(red: 1, green: 0.5844732523, blue: 0, alpha: 1)
        if let url = URL(string: entity.artworkUrl100 ?? "" ){
            artworkImg.sd_setImage(with: url, placeholderImage: UIImage(named: "place-holder"))
        }
        
        // Set trackName
        trackName.text = entity.trackName
        trackName.textColor = Config.white
        trackName.font = medium(Config.title)
        trackName.numberOfLines = 0
        
        // Set artistName
        artistName.text = entity.artistName
        artistName.textColor = Config.orange
        artistName.font = regular(Config.body)
        artistName.numberOfLines = 0
        
        // Set albumName
        albumName.text = entity.collectionName
        albumName.textColor = Config.gray
        albumName.font = regular(Config.body)
        albumName.numberOfLines = 0
        
        // Set releaseDate
        releaseDate.text = "\(entity.releaseDate!.prefix(10))"
        releaseDate.textColor = Config.gray
        releaseDate.font = regular(Config.body)
        releaseDate.numberOfLines = 0
        
        // Set track price
        price.text = "\(entity.trackPrice ?? 0.0) \(entity.currency ?? "")"
     
    }
}

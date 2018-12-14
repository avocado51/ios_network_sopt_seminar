//
//  WriteVC.swift
//  iOS-NetworkSeminar
//
//  Created by shineeseo on 2018. 12. 3..
//  Copyright © 2018년 sopt. All rights reserved.
//

import UIKit

class WriteVC: UIViewController {
    
    var boardId: Int?
    var board : Board?
    
    var boardTitle : String?
    var userId : Int?
    var boardContents : String?
    var boardDate : Date?
    var boardLike : Int = 0
    var boardPhoto : String?
    var like : Bool?
    var auth : Bool?
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailImg: UIImageView!
    @IBOutlet weak var contentLabel: UITextView!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var likeImg: UIImageView!
    @IBOutlet weak var likeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setup()
    }
    
    func setup() {
        self.nameLabel.text = String(gino(userId))
        self.titleLabel.text = boardTitle
        
        if let date = boardDate {
            let formatter = DateFormatter()
            formatter.dateFormat = "MM/dd HH:mm"
            let dateString = formatter.string(from: date)
            
            self.dateLabel.text = dateString
        }
        self.detailImg.imageFromUrl(gsno(boardPhoto), defaultImgPath: "")
        self.contentLabel.text = boardContents
        
        self.likeLabel.text="좋아요 " + "\(gino(boardLike))" + "개"
        
        
        if (gino(boardLike) > 0) {
            self.likeImg.image = UIImage(named: "like_full")
        }
        else {
            self.likeImg.image = UIImage(named : "like_empty")
        }
        
        let tapGesture = UITapGestureRecognizer(target: self,  action:#selector(imageTapped))
        
        self.likeImg.addGestureRecognizer(tapGesture)
    }
    @objc func imageTapped(_ sender: UIGestureRecognizer) {
        BoardService.shared.like(id: gino(boardId)){[weak self] (data) in guard let `self` = self else {return}
            
            if (self.gbno(data.auth) && self.gino(data.boardLike) > 0) {
                self.likeImg.image = UIImage(named: "like_full")
            }
            else {
                self.likeImg.image = UIImage(named : "like_empty")
            }
            self.likeLabel.text="좋아요 " + "\(self.gino(data.boardLike))" + "개"
            
        }
    }
 

}

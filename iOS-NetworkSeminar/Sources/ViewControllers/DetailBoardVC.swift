//
//  DetailBoardVC.swift
//  iOS-NetworkSeminar
//
//  Created by Leeseungsoo on 2018. 11. 20..
//  Copyright © 2018년 sopt. All rights reserved.
//

import UIKit

class DetailBoardVC: UIViewController {

    var boardId: Int?
    var board : Board?
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var detailPhoto: UIImageView!

    @IBOutlet weak var boardTxtLabel: UILabel!
    
    @IBOutlet weak var likeImg: UIImageView!
    @IBOutlet weak var likeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    
        BoardService.shared.getBoardDetail(id: gino(boardId)){[weak self] (data) in guard let `self` = self else {return}
            
            self.board = data
            self.setup()
        }
    }
    func setup() {
        self.nameLabel.text = String(gino(board!.userId))
        self.titleLabel.text = board!.boardTitle
        
        if let date = board!.boardDate {
            let formatter = DateFormatter()
            formatter.dateFormat = "MM/dd HH:mm"
            let dateString = formatter.string(from: date)
            
            self.dateLabel.text = dateString
        }
        self.detailPhoto.imageFromUrl(gsno(board!.boardPhoto), defaultImgPath: "")
        self.boardTxtLabel.text = board!.boardContents
        
        self.likeLabel.text="좋아요 " + "\(gino(board!.boardLike))" + "개"
        
    }
   

}

//
//  BoardVC.swift
//  iOS-NetworkSeminar
//
//  Created by Leeseungsoo on 2018. 11. 20..
//  Copyright © 2018년 sopt. All rights reserved.
//

import UIKit

class BoardVC: UIViewController {

    @IBOutlet weak var boardTableView: UITableView!
    
    var boardList = [Board]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        boardTableView.dataSource = self
        boardTableView.delegate = self
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        BoardService.shared.getBoardList(offset: nil, limit: 20) {[weak self] (data) in guard let `self` = self else {return}
            
            self.boardList = data
            print(data.count)
            self.boardTableView.reloadData()
        }
    }
    

}
extension BoardVC : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return boardList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BoardCell", for: indexPath) as! BoardCell
        let board = boardList[indexPath.row]
        
        cell.titleLabel.text = board.boardTitle
        cell.contentLabel.text = board.boardContents
        
        if let date = board.boardDate {
            let formatter = DateFormatter()
            formatter.dateFormat = "MM/dd HH:mm"
            let dateString = formatter.string(from: date)
        
            cell.dateLabel.text = "\(dateString)"
        }
        cell.likeLabel.text = "좋아요 " + "\(gino(board.boardLike))" + "개"
        cell.nameLabel.text = "\(gino(board.userId))"
        cell.imgView.imageFromUrl(gsno(board.boardPhoto), defaultImgPath: "")
        return cell
    }
    
    
}
extension BoardVC : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nextVC = storyboard?.instantiateViewController(withIdentifier: "writeVC") as! WriteVC
        
        let board = boardList[indexPath.row]
    
        nextVC.boardTitle = gsno(board.boardTitle)
        nextVC.userId = gino(board.userId)
        nextVC.boardContents = gsno(board.boardContents)
        
        if let date = board.boardDate {
            let formatter = DateFormatter()
            formatter.dateFormat = "MM/dd HH:mm"
            let dateString = formatter.string(from: date)
        
            nextVC.boardDate = board.boardDate
        }
        nextVC.boardLike = gino(board.boardLike)
        nextVC.boardPhoto = gsno(board.boardPhoto)
        nextVC.like = gbno(board.like)
        nextVC.boardId = gino(board.boardId)
        nextVC.auth = gbno(board.auth)
        
        navigationController?.pushViewController(nextVC, animated: true)
    }
}

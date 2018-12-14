//
//  BoardCollectionVC.swift
//  iOS-NetworkSeminar
//
//  Created by shineeseo on 2018. 12. 3..
//  Copyright © 2018년 sopt. All rights reserved.
//

import UIKit

class BoardCollectionVC: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var boardList = [Board]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        BoardService.shared.getBoardList(offset: nil, limit: 20) {[weak self] (data) in guard let `self` = self else {return}
            
            self.boardList = data
            print(data.count)
            self.collectionView.reloadData()
        }
    }
}

extension BoardCollectionVC : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //data의 갯수
        return boardList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //cell의 재사용 (reuseable cell) as cell class casting
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath) as! BoardCollectionCell
        let board = boardList[indexPath.item]
        //tableview는 indexpath.row
        //서버는 이미지를 따로 s3에 저장되어있음 multipart로 가져와야한다. (glide? 비슷?) -> url string만 가져옴.-> kingfisher 라이브러리를 사용한다.
        //boardphoto를 optional임. 그것을 해제하는 extenstion 함수 선언 -> UIViewController+extensions (gsno)
        cell.imgView.imageFromUrl(gsno(board.boardPhoto), defaultImgPath: "")
        cell.titleLabel.text = board.boardTitle
        cell.contentLabel.text = board.boardContents
        if let date = board.boardDate {
            let formatter = DateFormatter()
            formatter.dateFormat = "MM/dd HH:mm"
            let dateString = formatter.string(from: date)
            
            cell.dateLabel.text = "\(dateString)"
        }
        
        return cell
    }
    
    
}
//collectionview 크기 동적 할당
extension BoardCollectionVC : UICollectionViewDelegateFlowLayout {
    //셀의 크기, 셀 사이 간격, 전체 섹션 안에 있는 여백
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //전체 뷰 크기 - 30 ( 왼쪽 가운데 오른쪽) /2
        let width: CGFloat = (view.frame.width - 30 )/2
        let height :CGFloat = (view.frame.width - 30)/2 + 58
        
        return CGSize(width: width, height: height)
    }
    
    //padding (셀 사이의 간격 -가로/ 세로)
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        //정수 값이 아니라 CGFLOAT값
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let nextVC = storyboard?.instantiateViewController(withIdentifier: "writeVC") as! WriteVC
        
        let board = boardList[indexPath.item]
        
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




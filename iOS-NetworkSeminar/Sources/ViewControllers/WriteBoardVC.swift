//
//  WriteBoardVC.swift
//  iOS-NetworkSeminar
//
//  Created by Leeseungsoo on 2018. 11. 20..
//  Copyright © 2018년 sopt. All rights reserved.
//

import UIKit

class WriteBoardVC: UIViewController {
    
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var titleTxtField: UITextField!
    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var writeNavigationItem: UINavigationItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupTap()
        setupNavigationBar()
        
        
    }
    func setupNavigationBar() {
        self.writeNavigationItem.rightBarButtonItem = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(completeTapped))
        self.writeNavigationItem.leftBarButtonItem = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(cancelTapped))
    }
    
    @objc func cancelTapped(sender : UIBarButtonItem) {
        self.navigationController?.popViewController(animated : true)
    }
    
    @objc func completeTapped(sender: UIBarButtonItem) {
        // 아래의 guard 문법은 guard 의 조건이 참 이라면 조건을 통과하고 그렇지 않다면 else로 넘어가 예외처리를 하게되는 문법입니다.
        // 여기서는 제목과 내용의 text가 존재하지 않으면 통과하지 못하는 방식으로 사용되었습니다.
        // guard let 구문을 항상 써왔으니 금방 이해하실겁니다!
        guard titleTxtField.text?.isEmpty != true else {return}
        guard contentTextView.text?.isEmpty != true else {return}
        
        BoardService.shared.uploadBoard(title: titleTxtField.text!, contents: contentTextView.text!, image: imgView.image!) {
            self.simpleAlert("글 작성", "게시글이 작성되었습니다.", completion: { (action) in
                self.navigationController?.popViewController(animated: true)
            })
            
        }
    }
    
    // 텍스트필드나 텍스트 뷰의 edit 모드를 해제하기 위한, 즉, 키보드를 내리기 위한 탭 제스처와
    // 이미지 뷰를 탭하면 이미지를 추가할 수 있는 탭 제스처 설정
    func setupTap() {
        let viewTap = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        let imageTap = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        self.view.addGestureRecognizer(viewTap)
        self.imgView.addGestureRecognizer(imageTap)
    }
    
    //뷰를 탭하면 edit 상태를 끝낸다
    @objc func viewTapped() {
        self.view.endEditing(true)
    }
    
    //이미지를 탭하면 이미지피커를 띄우는 메소드
    //코드를 천천히 읽어보시고 한번 이해해보세요!
    //영어 단어 뜻대로 의미를 담고 있으니 어렵지않게 이해하실겁니다.
    @objc func imageTapped() {
        let picker = UIImagePickerController()
        picker.delegate = self
        let actionSheet = UIAlertController(title: "Photo source", message: "Choose a source", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action) in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                picker.sourceType = .camera
                picker.allowsEditing = true
                picker.showsCameraControls = true
                self.present(picker, animated: true)
            } else {
                print("not available")
            }
        }))
        actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (action) in
            picker.sourceType = .photoLibrary
            picker.allowsEditing = true
            self.present(picker, animated: true)
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        self.present(actionSheet, animated: true)
    }
    
    
}

//이미지 피커에 대한 여러 동작을 처리하는 delegate
extension WriteBoardVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //이미지를 선택하지 않고 피커 종료시에 실행되는 delegate 메소드
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    //이미지 피커에서 이미지를 선택하였을 때 일어나는 이벤트를 작성하는 메소드
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        var newImg = UIImage()
        
        if let possibleImg = info[.editedImage] as? UIImage {
            newImg = possibleImg
        }
        else if let possibleImg = info[.originalImage] as? UIImage {
            newImg = possibleImg
        }
        else {
            return
        }
        imgView.image = newImg
        dismiss(animated: true, completion: nil)
    }
}


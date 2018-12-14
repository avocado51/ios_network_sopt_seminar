//
//  UserService.swift
//  iOS-NetworkSeminar
//
//  Created by Leeseungsoo on 2018. 11. 20..
//  Copyright © 2018년 sopt. All rights reserved.
//

import Alamofire

struct UserService: APIManager, Requestable {
    
    typealias NetworkData = ResponseObject<User>
    typealias NetworkDataObj = ResponseObject<Board>
    static let shared = UserService()
    let userURL = url("/users")
    let userDefaults = UserDefaults.standard
    let headers: HTTPHeaders = [
        "Content-Type" : "application/json"
    ]
    
    //회원 가입 api
    func signUp(name: String, email: String, password: String, part: String, completion: @escaping () -> Void) {
        //코드작성
        let body = [
            "name" : name,
            "email" : email,
            "password" : password,
            "part" : part,
        ]
        
        postable(userURL, body: body, header: headers) { res in
            switch res {
            case .success(let value) :
                completion()
            case .error(let error):
                print(error)
        
            }
            
        }
    }
    
}

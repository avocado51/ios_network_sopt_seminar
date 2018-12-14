//
//  LoginService.swift
//  iOS-NetworkSeminar
//
//  Created by Leeseungsoo on 2018. 11. 20..
//  Copyright © 2018년 sopt. All rights reserved.
//

import Alamofire

struct LoginService: APIManager, Requestable {
    
    typealias NetworkData = ResponseObject<Token>
    typealias NetworkDataObj = ResponseObject<Board>
    static let shared = LoginService()
    let loginURL = url("/login")
    let headers: HTTPHeaders = [
        "Content-Type" : "application/json"
    ]
    
    //로그인 api
    func login(email: String, password: String, completion: @escaping (Token) -> Void) {
        let body = [
            "email" : email,
            "password" : password,
        ]
        postable(loginURL, body: body, header: headers) { res in
            switch res {
            case .success(let value):
                print(value)
            
                guard let token = value.data else {return}
                completion(token)
            case .error(let error):
                print(error)
            }
        }
        
    }
    
}

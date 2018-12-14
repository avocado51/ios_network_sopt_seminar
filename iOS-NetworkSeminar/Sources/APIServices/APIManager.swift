//
//  APIManager.swift
//  iOS-NetworkSeminar
//
//  Created by Leeseungsoo on 2018. 11. 20..
//  Copyright © 2018년 sopt. All rights reserved.
//

protocol APIManager {}

extension APIManager {
    static func url(_ path: String) -> String {
        return "http://bghgu.tk:8080" + path
    }
}

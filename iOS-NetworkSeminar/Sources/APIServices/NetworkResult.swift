//
//  NetworkResult.swift
//  iOS-NetworkSeminar
//
//  Created by Leeseungsoo on 2018. 11. 20..
//  Copyright © 2018년 sopt. All rights reserved.
//

enum NetworkResult<T> {
    case success(T)
    case error(Error)
}

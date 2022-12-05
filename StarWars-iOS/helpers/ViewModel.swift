//
//  ViewModel.swift
//  StarWars-iOS
//
//  Created by Yawar Valeriano on 25/11/22.
//

import Foundation

protocol ViewModelProtocol {
    var onFinish: (() -> Void)? { get set }
    var onError: ((_ error: Error) -> Void)? { get set }
    var reloadData: (() -> Void)? { get set }
}

class ViewModel: ViewModelProtocol {
    var onFinish: (() -> Void)?
    var onError: ((Error) -> Void)?
    var reloadData: (() -> Void)?
}

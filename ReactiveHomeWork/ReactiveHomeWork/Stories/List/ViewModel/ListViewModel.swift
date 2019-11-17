//
//  ListViewModel.swift
//  ReactiveHomeWork
//
//  Created by Александр Арсенюк on 12.11.2019.
//  Copyright © 2019 Александр Арсенюк. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

enum DataFetchingStates {
    
    case startLoading
    case finishLoading
}

class ListViewModel: ListViewModelDelegate {
    
    private let disposeBag = DisposeBag()
    private let networkManager: NetworkManagerProtocol = NetworkManager()
    
    var user = AuthotizationManager.shared.getUserInfo().value
    var fetchedArray: BehaviorRelay<[CellViewModel]> = BehaviorRelay(value: [])
    var errorString = BehaviorRelay(value: "")
    var searchBarText = BehaviorRelay(value: "")
    var immutableArray: BehaviorRelay<[CellViewModel]> = BehaviorRelay(value: [])
    var fetchState = BehaviorRelay<DataFetchingStates>(value: .finishLoading)
    
    func fetchModel() {
        
        AuthotizationManager.shared.getUserInfo().asObservable().bind { [unowned self] (userModel) in
            self.user = userModel
        }.disposed(by: disposeBag)
        
        fetchState.accept(.startLoading)
        networkManager.makeRequest(contentType: user.contentType) { [unowned self] (model, error) -> (Void) in
            self.fetchState.accept(.finishLoading)
            if let error = error {
                self.errorString.accept(error)
            } else {
                self.fetchedArray.accept(model!)
                self.immutableArray.accept(model!)
            }
        }
    }
}

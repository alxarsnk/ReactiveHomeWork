//
//  ListViewModelDelegate.swift
//  ReactiveHomeWork
//
//  Created by Александр Арсенюк on 13.11.2019.
//  Copyright © 2019 Александр Арсенюк. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol ListViewModelDelegate {
    
    var fetchedArray: BehaviorRelay<[CellViewModel]> { get set }
    var errorString: BehaviorRelay<String> { get set }
    var searchBarText: BehaviorRelay<String> { get set }
    var immutableArray: BehaviorRelay<[CellViewModel]> { get set }
    var fetchState: BehaviorRelay<DataFetchingStates> { get set }
    
    func fetchModel()
}

//
//  ListViewController.swift
//  ReactiveHomeWork
//
//  Created by Александр Арсенюк on 09.11.2019.
//  Copyright © 2019 Александр Арсенюк. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class ListViewController: UIViewController {
    
    //MARK: - Variables
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var blankView: UIView!
    
    //MARK: - Constants
    let disposeBag = DisposeBag()
    let searchController = UISearchController(searchResultsController: nil)
    let activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    let showSettingsBarButton: UIBarButtonItem = UIBarButtonItem()
    let viewModel = ListViewModel()
    
    //MARK: - Lificycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        configureBinding()
        configureNavBar()
        configureActivityIndicatorView()
        configureBlankView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        makeRequest()
    }
    
    //MARK: - Congigure UI
    private func configureBlankView() {
        
        blankView.backgroundColor = .black
        blankView.alpha = 0.3
        blankView.isHidden = false
    }
    
    private func configureActivityIndicatorView() {
        
        activityIndicator.frame = CGRect(x: 0 , y: 0, width: 40, height: 40)
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .large
        view.addSubview(activityIndicator)
    }
    
    private func configureNavBar() {
        
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
        navigationItem.rightBarButtonItem = showSettingsBarButton
        showSettingsBarButton.title = "Settings"
    }
    
    private func makeRequest() {
        viewModel.fetchModel()
    }
    
    //MARK: - Binding
    private func configureBinding() {
        
        viewModel.fetchState.asObservable().bind { [unowned self] fetchingState in
            DispatchQueue.main.async {
                switch fetchingState {
                case .startLoading:
                    self.activityIndicator.startAnimating()
                    self.blankView.isHidden = false
                case .finishLoading:
                    self.activityIndicator.stopAnimating()
                    self.blankView.isHidden = true
                }
            }
        }.disposed(by: disposeBag)
        
        viewModel.fetchedArray
            .bind(to: tableView.rx.items(cellIdentifier: "cell")) { row, model, cell in
                guard let customCell = cell as? ListTableViewCell else { return }
                customCell.configureCell(with: model)
        }.disposed(by: disposeBag)
        
        viewModel.errorString
            .bind(onNext: { [unowned self] errorText  in
            guard errorText != "" else { return }
                DispatchQueue.main.async {
                    self.presentErrorAlert(with: errorText)
                }
        }).disposed(by: disposeBag)
        
        tableView.rx.itemSelected
            .subscribe(onNext: { [unowned self] indexPath in
            self.tableView.deselectRow(at: indexPath, animated: true)
        }).disposed(by: disposeBag)
        
        searchController.searchBar.rx.text
            .orEmpty
            .subscribe(onNext: { [unowned self] searchText in
                  guard searchText != "" else {
                    return self.viewModel.fetchedArray.accept(self.viewModel.immutableArray.value) }
                  self.viewModel.fetchedArray.accept(self.viewModel.immutableArray.value.filter({ model -> Bool in
                      return model.firstProperty.hasPrefix(searchText)
                  }))
        }).disposed(by: disposeBag)
        
        showSettingsBarButton.rx.tap.bind {
            self.presentSettingsScreen()
        }.disposed(by: disposeBag)
    }
    
    //MARK: - Helpers
    private func presentErrorAlert(with errorText: String) {
        
        let alert = UIAlertController(title: "Error", message: errorText, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        self.present(alert, animated: false, completion: nil)
    }
    
    //MARK: - Navigation
    private func presentSettingsScreen() {
        let  mainView = UIStoryboard(name:"Main", bundle: nil)
        let presentationViewController : UIViewController = mainView.instantiateViewController(withIdentifier: "settingsViewContoller")
        navigationController?.pushViewController(presentationViewController, animated: true)
    }
}

//MARK: - UISearchResultsUpdating
extension ListViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        
        guard let text = searchController.searchBar.text else { return }
        viewModel.searchBarText.accept(text)
    }
}



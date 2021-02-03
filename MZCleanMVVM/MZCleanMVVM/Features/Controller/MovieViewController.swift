//
//  MovieViewController.swift
//  AssignmentApp
//
//  Created by Zulqurnain on 03/02/2021.
//  Copyright © 2021 Mohammad Zulqurnain. All rights reserved.
//
import UIKit


internal class MovieViewController: UIViewController, HudManager {
    private enum CellIdentifiers {
        static let id = "cellid"
    }
    
     var viewModel: MovieViewModel!
 
    var tableView : UITableView = {
        var tableView = UITableView()
        return tableView
    }()
    
    fileprivate func setupView() {
        self.view.addSubview(tableView)
        tableView.fillSuperview()
        tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: CellIdentifiers.id)
        tableView.isHidden = true
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 600
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.prefetchDataSource = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
         setupView()
    }
}

extension MovieViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.totalCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.id, for: indexPath) as! MovieTableViewCell

        if isLoadingCell(for: indexPath) {
        } else {
            cell.viewModel = viewModel.movie(at: indexPath.row)
        }
        
        return cell
        
        
    }
}

extension MovieViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = DetailedmovieViewController()
        controller.viewModel = viewModel.movie(at: indexPath.row)
        controller.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(controller, animated: true)
    }
}

extension MovieViewController: MovieViewModelDelegate {
    
    func onFetchCompleted(with newIndexPathsToReload: [IndexPath]?) {
        guard newIndexPathsToReload != nil else {
            MZSpinner.stop()
            tableView.isHidden = false
            tableView.reloadData()
            return
        }
    }
    
    
    func onFetchFailed(with reason: String) {
        MZSpinner.stop()
        
        let title = "Warning"
        let action = UIAlertAction(title: "OK", style: .default)
        displayAlert(with: title , message: reason, actions: [action])
    }
    
    
}

private extension MovieViewController {
    func isLoadingCell(for indexPath: IndexPath) -> Bool {
        print("viewing number\(indexPath.row) \(viewModel.totalCount) ,avabilalbe\(viewModel.currentCount)")
        return indexPath.row >= viewModel.currentCount
    }
    
    func visibleIndexPathsToReload(intersecting indexPaths: [IndexPath]) -> [IndexPath] {
        let indexPathsForVisibleRows = tableView.indexPathsForVisibleRows ?? []
        let indexPathsIntersection = Set(indexPathsForVisibleRows).intersection(indexPaths)
        return Array(indexPathsIntersection)
    }
}

extension MovieViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        if indexPaths.contains(where: isLoadingCell) {
            viewModel.fetchMovies()
        }
    }
}










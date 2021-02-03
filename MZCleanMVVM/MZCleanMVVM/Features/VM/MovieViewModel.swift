//
//  MovieViewModel.swift
//  AssignmentApp
//
//  Created by Zulqurnain on 03/02/2021.
//  Copyright © 2021 Mohammad Zulqurnain. All rights reserved.
//

import Foundation

final class MovieViewModel {
    private weak var delegate: MovieViewModelDelegate?
    
    private var movies: [Movie] = []
    private var currentPage = 1
    private var total = 0
    private var isFetchInProgress = false
    
    var client : MZDataProvider!
    var pageName : String!
    init( pageName: String, client : MZDataProvider = MZClientHTTPNetworking(), delegate: MovieViewModelDelegate) {
        self.pageName = pageName
        self.client = client
        self.delegate = delegate
    }
    
    var totalCount: Int {
        return total
    }
    
    var currentCount: Int {
        return movies.count
    }
    
    func movie(at index: Int) -> Movie? {
        guard index < movies.count else { return nil }
        return movies[index]
    }
    
    func fetchMovies() {
        guard !isFetchInProgress else {
            return
        }
        
        isFetchInProgress = true
        let url = URL(string:Config.APIEndpoints.getNowPlaying(pageNaem: pageName, page: currentPage, key: tokenClosure()).path )!
        print(url)
        client.fetchRemote(MovieList.self, url: url) { result in
            switch result {
            case .failure(let error):
                DispatchQueue.main.async { [unowned self] in
                    self.isFetchInProgress = false
                    self.delegate?.onFetchFailed(with: error.reason)
                }
            case .success(let response):
                DispatchQueue.main.async { [unowned self] in
                    
                    if let movieList = response as? MovieList,
                        (self.currentPage + 1) < movieList.totalPages ?? self.currentPage {
                        self.currentPage += 1
                    }
                    self.isFetchInProgress = false
                    
                    if let response = response as? MovieList {
                        self.total = response.totalResults ?? 0
                        if let results =  response.results {
                            self.movies.append(contentsOf: results)
                        }
                        if response.page ?? 0 > 1 {
                            if let results =  response.results {
                                let indexPathsToReload = self.calculateIndexPathsToReload(from: results)
                                self.delegate?.onFetchCompleted(with: indexPathsToReload)
                            }
                        } else {
                            self.delegate?.onFetchCompleted(with: .none)
                        }
                    }
                    
                }
            }
        }
        
    }
    
    private func calculateIndexPathsToReload(from newModerators: [Movie]) -> [IndexPath] {
        let startIndex = movies.count - newModerators.count
        let endIndex = startIndex + newModerators.count
        return (startIndex..<endIndex).map { IndexPath(row: $0, section: 0) }
    }
}





//
//  TopRatedViewController.swift
//  AssignmentApp
//
//  Created by Zulqurnain on 03/02/2021.
//  Copyright © 2021 Mohammad Zulqurnain. All rights reserved.
//

import UIKit

class TopRatedViewController : MovieViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        MZSpinner.spin()
        viewModel = MovieViewModel(pageName: MoviesEndPoint.getTopRates.rawValue, delegate: self)
        viewModel.fetchMovies()
    }
}



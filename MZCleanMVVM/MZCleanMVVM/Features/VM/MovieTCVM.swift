//
//  MovieTCVM.swift
//  AssignmentApp
//
//  Created by Zulqurnain on 03/02/2021.
//  Copyright © 2021 Mohammad Zulqurnain. All rights reserved.
//

import Foundation



protocol MovieTCVM {
    var articleVM: Movie { get }
    var ratingVM: String { get }
    var titleVM: String { get }
    var overviewVM: String { get }
    var releseDateVM: String { get }
    var smallpreviewVM: String { get }
    var posterviewVM: String { get }
}


extension Movie: MovieTCVM {
    
    var titleVM: String {
        return title ?? ""
    }
    
    var ratingVM: String {
        return "Rating: " + "\(voteAverage ?? 0.0)"
    }
    var overviewVM: String {
        return overview ?? ""
    }
    
    var releseDateVM: String {
        return "Release date: " + "\(releaseDate ?? "")"
    }
    
    var smallpreviewVM: String {
        return backdropPath ?? ""
    }
    
    var posterviewVM: String {
        return posterPath ?? ""
    }
    
    
    var articleVM: Movie {
        return self
    }
    
}

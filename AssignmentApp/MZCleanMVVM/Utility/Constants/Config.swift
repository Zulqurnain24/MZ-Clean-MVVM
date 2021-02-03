//
//  Config.swift
//  AssignmentApp
//
//  Created by Zulqurnain on 03/02/2021.
//  Copyright © 2021 Mohammad Zulqurnain. All rights reserved.
//

import Foundation

enum MoviesEndPoint: String {
    case getnowPlaying  = "movie/popular"
    case getTopRates = "movie/top_rated"
}

struct Config {
    
    private struct Domains {
        static let Dev = "https://api.themoviedb.org"
        static let UAT = "https://image.tmdb.org"
        static let Local = "192.145.5.0"
        static let QA = "themoviedb.qa.com"
    }
    
    private  struct Routes {
        static let Api = "/3"
        static let ApiImage = "/t/p"
    }
    
    private  static let Domain = Domains.Dev
    private  static let DomainIamage = Domains.UAT
    private  static let Route = Routes.Api
    private  static let imageRoute = Routes.ApiImage
    private  static let BaseURL = Domain + Route
    private  static let BaseURLImage = DomainIamage + imageRoute
    
    static var FacebookLogin: String {
        return BaseURL  + ""
    }

    enum SmallImageDownload {
        case endpath(withName: String)
        var path: String {
            switch self {
            case let .endpath(withName):
                return BaseURLImage +  "/w45/" + withName
            }
        }
    }
    
    enum PosterImageDownload {
        case endpath(withName: String)
        var path: String {
            switch self {
            case let .endpath(withName):
                return BaseURLImage +  "/original/" + withName
            }
        }
    }
    
    enum APIEndpoints {
        case getNowPlaying(pageNaem : String,page:Int,key: String)
        var path: String {
            switch self {
            case let .getNowPlaying(pageName,page,key):
                return BaseURL  + "/\(pageName)?api_key=\(key)&page=\(page)"
            }
        }
    }
}

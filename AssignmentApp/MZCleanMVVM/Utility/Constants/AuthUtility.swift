//
//  AuthUtility.swift
//  AssignmentApp
//
//  Created by Zulqurnain on 03/02/2021.
//  Copyright © 2021 Mohammad Zulqurnain. All rights reserved.
//

import Foundation

let tokenClosure: () -> String = {
    AuthUtility.Auth().token
}

class AuthUtility {
    class func Auth() -> (isValidIn: Bool, token: String) {
        return (isValidIn: true, token: "26bd27c2f63ddd742d5bcdfe5129f5d0")
    }
    
    //below going to implement token expire
}

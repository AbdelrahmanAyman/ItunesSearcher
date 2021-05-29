//
//  Connectivity.swift
//  ItunesSearcher
//
//  Created by AH MARWAN  on 29/05/21.
//

import Foundation
import Alamofire

class Connectivity {
    class func isConnectedToInternet() -> Bool {
        return NetworkReachabilityManager()?.isReachable ?? false
    }
}

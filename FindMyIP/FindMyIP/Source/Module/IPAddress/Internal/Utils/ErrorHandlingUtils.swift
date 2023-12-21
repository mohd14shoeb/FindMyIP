//
//  ErrorHandlingUtils.swift
//  FindMyIP
//
//  Created by Shoeb Khan on 21/12/23.
//

import Foundation
import Alamofire

struct ErrorHandlingUtils {
    // MARK: Error handle
    static func parseURLError(_ error: AFError?) -> String {
        var errorMessage = "Unknown Error found"
        
        guard let afError = error else {
            return errorMessage
        }

        switch afError {
        case .sessionTaskFailed(let sessionError):
            if let urlError = sessionError as? URLError {
                errorMessage = urlErrorHandling(urlError: urlError)
            } else {
                errorMessage = "Error: \(afError.localizedDescription)"
            }
        default:
            errorMessage = "Error: \(afError.localizedDescription)"
        }
        
        return errorMessage
    }
    
    private static func urlErrorHandling(urlError: URLError) -> String {
        var errorMessage = ""
        
        switch urlError.code {
        case .notConnectedToInternet:
            errorMessage = "Error: The Internet connection appears to be offline."
        default:
            errorMessage = "Error: \(urlError.localizedDescription)"
        }
        
        return errorMessage
    }
}


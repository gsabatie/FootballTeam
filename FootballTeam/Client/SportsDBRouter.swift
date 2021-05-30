//
//  SportsDBRouter.swift
//  FootballTeam
//
//  Created by guillaume sabatié on 27/05/2021.
//

import Foundation
import Alamofire

enum SportDBRouter: URLRequestConvertible {
    case searchTeamInLeague(String, String)

    // MARK: - Properties

    var baseURL: URL {
        return URL(string: "https://www.thesportsdb.com/api/v1/json/1/")!
    }

    var method: HTTPMethod {
        switch self {
        case .searchTeamInLeague:
            return .get
        }
    }

    var path: String {
        switch self {
        case .searchTeamInLeague:
            return "search_all_teams"
        }
    }

    // MARK: - URLRequestConvertible

    func asURLRequest() throws -> URLRequest {
        let url = baseURL.appendingPathComponent(path).appendingPathExtension("php")
        var request = URLRequest(url: url)
        request.method = method

        switch self {
        case let .searchTeamInLeague(language, searchScope):
            request = try URLEncodedFormParameterEncoder().encode(["l": "\(language) \(searchScope)"], into: request)
        }

        return request
    }
}

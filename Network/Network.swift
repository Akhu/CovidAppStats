//
//  Network.swift
//  CovidStat
//
//  Created by Anthony Da Cruz on 19/07/2020.
//

import Foundation
import Combine

extension String {
    static let shortDate: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    var stringDate: Date? {
        return String.shortDate.date(from: self)
    }
}

enum APIError: Error, LocalizedError {
    case unknown, apiError(reason: String), parserError(reason:String)
    
    var errorDescription: String? {
        switch self {
        case .unknown:
            return "Unknown error occurred"
        case .apiError(let reason), .parserError(let reason):
            return reason
        }
    }
}

func fetch(url: URL) -> AnyPublisher<Data, APIError> {
    let request = URLRequest(url: url)
    
    return URLSession.DataTaskPublisher(request: request, session: .shared)
        .tryMap { data, response in
            guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
                throw APIError.unknown
            }
            return data
        }
        .mapError { error in
            if let error = error as? APIError {
                return error
            } else {
                return APIError.apiError(reason: error.localizedDescription)
            }
        }
        .eraseToAnyPublisher()
}

func fetch<T: Decodable>(url: URL) -> AnyPublisher<T, APIError> {
    fetch(url: url)
        .decode(type: T.self, decoder: JSONDecoder())
        .mapError { error in
            if let error = error as? DecodingError {
                var errorToReport = error.localizedDescription
                switch error {
                case .dataCorrupted(let context):
                    let details = context.underlyingError?.localizedDescription ?? context.codingPath.map { $0.stringValue }.joined(separator: ".")
                    errorToReport = "\(context.debugDescription) - (\(details))"
                case .keyNotFound(let key, let context):
                    let details = context.underlyingError?.localizedDescription ?? context.codingPath.map { $0.stringValue }.joined(separator: ".")
                    errorToReport = "\(context.debugDescription) (key: \(key), (\(details))"
                case .typeMismatch(let type, let context):
                    let details = context.underlyingError?.localizedDescription ?? context.codingPath.map { $0.stringValue }.joined(separator: ".")
                    errorToReport = "\(context.debugDescription) (type: \(type), (\(details))"
                case .valueNotFound(let type, let context):
                    let details = context.underlyingError?.localizedDescription ?? context.codingPath.map { $0.stringValue }.joined(separator: ".")
                    errorToReport = "\(context.debugDescription) (type: \(type), (\(details))"
                @unknown default:
                    break
                }
                return APIError.parserError(reason: errorToReport)
            } else {
                return APIError.apiError(reason: error.localizedDescription)
            }
        }.eraseToAnyPublisher()
}

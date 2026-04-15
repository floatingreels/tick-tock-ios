//
//  DivergingResponseSerializer.swift
//  TickTock
//
//  Created by David Gunzburg on 08/04/2026.
//  Thanks to @Charles Muchene: https://medium.com/@charlesmuchene/custom-response-handler-in-alamofire-80267c3773a9
//  Thanks to @Sebastien: https://stackoverflow.com/questions/64557970/how-to-decode-the-body-of-an-error-in-alamofire-5
//

import Alamofire
import Foundation

final class DivergingResponseSerializer<T: Decodable>: ResponseSerializer {
    
    private let errorUnknownMessage = "Unknown error"
    private let emptyResponseMessage = "Empty response"
    private let errorSerializationMesssage = "Error serializing response body"
    private let noDataMessage = "No additional data available"
    
    private let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }()

    public func serialize(request: URLRequest?, response: HTTPURLResponse?, data: Data?, error: Error?) throws -> Result<T, APIErrorResponse> {
        if let error {
            let apiError = APIErrorResponse(code: 0, message: errorUnknownMessage, args: [error.localizedDescription, getBodyString(data: data)])
            logResponseFailure(apiError)
            return .failure(apiError)
        } else if let response {
            print(response)
            do {
                if response.statusCode < 200 || response.statusCode >= 300 {
                    let result = try DecodableResponseSerializer<APIErrorResponse>(decoder: decoder).serialize(request: request, response: response, data: data, error: nil)
                    let apiError = APIErrorResponse(code: response.statusCode, message: result.message, args: [getBodyString(data: data)])
                    logResponseFailure(apiError)
                    return .failure(apiError)
                } else {
                    let apiResult = try DecodableResponseSerializer<T>(decoder: decoder).serialize(request: request, response: response, data: data, error: nil)
                    logResponseSuccess(code: response.statusCode, data: data)
                    return .success(apiResult)
                }
            } catch(let err) {
                let apiError = APIErrorResponse(code: response.statusCode, message: errorSerializationMesssage, args: [err.localizedDescription, getBodyString(data: data)])
                logResponseFailure(apiError)
                return .failure(apiError)
            }
        } else {
            let apiError = APIErrorResponse(code: 1, message: emptyResponseMessage, args: [getBodyString(data: data)])
            logResponseFailure(apiError)
            return .failure(apiError)
        }
    }
    
    private func getBodyString(data: Data?) -> String {
        guard let data else { return noDataMessage }
        return String(data: data, encoding: .utf8) ?? errorSerializationMesssage
    }
    
    private func logResponseFailure(_ error: APIErrorResponse) {
        var log = "❌  RESPONSE  ❌\n"
        if let code = error.code {
            log += "Error code: \(code)\n"
        }
        let message = error.message ?? Translation.Error.general_message.val
        log += "Error message: \(message)"
        if let args = error.args, !args.isEmpty {
            args.forEach { arg in
                log += "\nError body: \(arg)"
            }
        }
        log += "\n---------\n"
        print(log)
    }
    
    private func logResponseSuccess(code: Int, data: Data?) {
        var log = "✅  RESPONSE  ✅\n"
        log += "Status code: \(code)\n"
        log += "Response body:\n\(getBodyString(data: data))"
        log += "\n---------\n"
        print(log)
    }
}


extension DataRequest {
    
    @discardableResult func responseDivergingDecodable<T: Decodable>(
        queue: DispatchQueue = DispatchQueue.global(qos: .userInitiated),
        of t: T.Type,
        completionHandler: @escaping (Result<T, APIErrorResponse>) -> Void
    ) -> Self where T: Respondable {
        return response(queue: .main, responseSerializer: DivergingResponseSerializer<T>()) { response in
            switch response.result {
            case .success(let result):
                completionHandler(result)
            case .failure(let error):
                completionHandler(.failure(APIErrorResponse(code: 3, message: "Other error", args: [error.localizedDescription])))
            }
        }
    }
}

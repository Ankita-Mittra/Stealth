//
//  SignUpResponse.swift
//  Stealth777
//
//  Created by Fareed Alzoorani on 28/03/2022.
//


import Foundation
import Alamofire

// MARK: - SignUpResponse Model
struct SignUpResponse: Codable {
    let success: Bool
    let code: Int
    let message: String
    let version: Int
    let data: SignUpResponseDataClass
}

// MARK: - DataClass
struct SignUpResponseDataClass: Codable {
    let id, token: String?
}





//// MARK: Convenience initializers
//extension SignUpModel {
//    init(data: Data) throws {
//        self = try JSONDecoder().decode(SignUpModel.self, from: data)
//    }
//
//    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
//        guard let data = json.data(using: encoding) else {
//            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
//        }
//        try self.init(data: data)
//    }
//
//    init(fromURL url: URL) throws {
//        try self.init(data: try Data(contentsOf: url))
//    }
//
//    func jsonData() throws -> Data {
//        return try JSONEncoder().encode(self)
//    }
//
//    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
//        return String(data: try self.jsonData(), encoding: encoding)
//    }
//}
//
//// MARK: - Alamofire response handlers
//extension DataRequest {
//    fileprivate func decodableResponseSerializer<T: Decodable>() -> DataResponseSerializer<T> {
//        return DataResponseSerializer { _, response, data, error in
//            guard error == nil else { return .failure(error!) }
//
//            guard let data = data else {
//                return .failure(AFError.responseSerializationFailed(reason: .inputDataNil))
//            }
//
//            return Result { try JSONDecoder().decode(T.self, from: data) }
//        }
//    }
//
//    @discardableResult
//    fileprivate func responseDecodable<T: Decodable>(queue: DispatchQueue? = nil, completionHandler: @escaping (DataResponse<T>) -> Void) -> Self {
//        return response(queue: queue, responseSerializer: decodableResponseSerializer(), completionHandler: completionHandler)
//    }
//
//    @discardableResult
//    func responseSignUp(queue: DispatchQueue? = nil, completionHandler: @escaping (DataResponse<SignUpModel>) -> Void) -> Self {
//        return responseDecodable(queue: queue, completionHandler: completionHandler)
//    }
//}

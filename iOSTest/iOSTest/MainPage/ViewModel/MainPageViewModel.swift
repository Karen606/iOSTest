//
//  MainPageModelView.swift
//  iOSTest
//
//  Created by user on 30.06.23.
//

import Foundation

class MainPageViewModel {    
    func getCategories(completion: @escaping(Result<CategoriesModel, NetworkError>) -> ()) {
        if !Connectivity.isConnectedToInternet() {
            return
        }
        NetworkManager.shared.setupRequest(path: .getCategories, method: .get, header: .application_json) { result in
            switch result {
            case .success(let data):
                do {
                    let responseData = try JSONDecoder().decode(CategoriesModel.self, from: data)
                    completion(.success(responseData))
                } catch {
                    print(error)
                    completion(.failure(.serverError))
                }
            case .failure(_):
                completion(.failure(.serverError))
            }
        }
    }
}

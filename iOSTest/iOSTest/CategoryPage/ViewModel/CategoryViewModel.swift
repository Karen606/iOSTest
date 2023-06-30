//
//  CategoryViewModel.swift
//  iOSTest
//
//  Created by user on 30.06.23.
//

import Foundation

class CategoryViewModel {
    func getDishes(completion: @escaping(Result<DishesModel, NetworkError>) -> ()) {
        if !Connectivity.isConnectedToInternet() {
            return
        }
        NetworkManager.shared.setupRequest(path: .getDishes, method: .get, header: .application_json) { result in
            switch result {
            case .success(let data):
                do {
                    let responseData = try JSONDecoder().decode(DishesModel.self, from: data)
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

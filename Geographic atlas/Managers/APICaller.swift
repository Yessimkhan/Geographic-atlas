//
//  APICaller.swift
//  Netflix
//
//  Created by Yessimkhan Zhumash on 04.11.2022.
//

import Foundation


struct Constants{
    static let baseURL = "https://restcountries.com/v3.1/"
    static let all = "all/"
    static let country = "alpha/"
}
enum APIError: Error{
    case failedTorgetData
}


class APICaller{
    static let shared = APICaller()
    
    
//MARK: -get all countries
    func getCountries(compeletion: @escaping (Result<[CountryElement], Error>) -> Void){
        
        guard let url = URL(string: "\(Constants.baseURL)\(Constants.all)") else {
            return
        }
        
    
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)){
            data, _, error in
            guard let data = data, error == nil else{
                return
            }
            
            do{
                let decoder = JSONDecoder()
                let results = try decoder.decode(Country.self,from: data)
                compeletion(.success(results))
                print("success get countries")
                
            }catch{
                print("Nothing has been retrieved! \(error)")
                compeletion(.failure(APIError.failedTorgetData ))
            }
        }
        task.resume()
    }
//MARK: - get country details
    func getCountryDetalis(with query: String,compeletion: @escaping (Result<CountryDetail, Error>) -> Void){
        guard let url = URL(string: "\(Constants.baseURL)\(Constants.country)\(query)")else{return}
        print(url)
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)){
            data, _, error in
            guard let data = data, error == nil else{
                return
            }

            do{
                let decoder = JSONDecoder()
                let results = try decoder.decode(CountryDetails.self, from:data)
                compeletion(.success(results[0]))
                print("success get country details")
            }catch{
                compeletion(.failure(error))
                print(error)
            }
        }
        task.resume()
    }
    
}






//
//  APIFunctions.swift
//  COVIDStatisticsGov
//
//  Created by hyperactive on 17/11/2020.
//  Copyright © 2020 hyperactive. All rights reserved.
//

import Foundation
import Alamofire

class APIFunctions {
    
    let PORT = 5000
    var delegate: DataDelegate?
    static let functions = APIFunctions()
    
    func fetchData(_ completion: @escaping(_ error: NSError? ,_ data: Data?) -> Void){
        AF.request("http://localhost:\(PORT)/fetchData").response { response in
            guard let data = response.data else {
                completion(NSError(),nil)
                return
            }
            
            completion(nil,data)
        }
    }
    
    func fetchData() {
        AF.request("http://localhost:\(PORT)/fetchData").response { response in
            guard let data = response.data else { return }
            
            do {
                if var jsonArray = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]] {
                    self.sortJsonByDate(&jsonArray)
                    self.delegate?.updateData(newData: jsonArray)
                }
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
    }
    
    private func sortJsonByDate(_ array: inout [[String: Any]]) {
        
        array.sort(by: {(dict1, dict2) in
            guard let str1 = dict1[Constants.Keys.date] as? String else { return false }
            guard let str2 = dict2[Constants.Keys.date] as? String else { return false }
            guard let date1 = makeDateFrom(str1) else { return false }
            guard let date2 = makeDateFrom(str2) else { return false }
            
            return Calendar.current.compare(date1, to: date2, toGranularity: .day) == .orderedAscending
        })
    }
    
    private func makeDateFrom(_ string: String) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/mm/yyyy"
        guard let result = formatter.date(from: string) else { return nil }
        return result
    }
}

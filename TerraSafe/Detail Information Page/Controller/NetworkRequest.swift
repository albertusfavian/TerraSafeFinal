//
//  NetworkRequest.swift
//  TerraSafe
//
//  Created by Mac-albert on 11/06/21.
//

import Foundation

class NetworkRequest{
    
    var listTemp = [Float]()
    var listCondition = [String]()
    var listDate = [String]()
    
    func decodeJSONForecast(JSONData: Data){
        let response = try! JSONDecoder().decode(WeatherData.self, from: JSONData)
        var day: Int = 1
        if let data = response.list {
            for i in data {
                if let datetoday = i.dt_txt {
                    if convertDateToTime(stringDate: datetoday) == "06:00:00" {
                        if let temperatur = i.main?.temp {
                            listTemp.append(temperatur)
                            listDate.append(convertDateToString(stringDate: datetoday))
                        }
//                        print ("Day: \(day)")
                    }
//                    print(" ")
//                    print("day: \(day)")
//                    print("Temp : \(i.main.temp)")
//                    print("Temp Max : \(i.main.temp_max)")
//                    print("Temp Min : \(i.main.temp_min)")
//                    print("Feels Like : \(i.main.feels_like)")
//                    print("Humidity : \(i.main.humidity)")
                    if let weatherData = i.weather {
                        for j in weatherData {
                            if convertDateToTime(stringDate: datetoday) == "06:00:00" {
                                listCondition.append(j.main ?? "")
//                           print("Main : \(j.main)")
//                           print("Description : \(j.description)")
//                           print("Icon : \(j.icon)")
                            }
                        }
                    
                    }
                }

            }
        }

    }
    
    func pullJSONData(url: URL?,
                      completion: @escaping ([Float], [String], [String]) -> Void){
        
        let task = URLSession.shared.dataTask(with: url!) { data, response, error in
            if let error = error {
                print("Error : \(error.localizedDescription)")
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                print("Error : HTTP Response Code Error")
                return
            }
            
            guard let data = data else {
                print("Error : No Response")
                return
            }
            
            self.decodeJSONForecast(JSONData: data)
            completion(self.listTemp, self.listCondition, self.listDate)
        
        }
        task.resume()
    }
    
    func convertDateToTime(stringDate: String) -> String {
        let stringSplited = stringDate.components(separatedBy: " ")

        return stringSplited[1]
    }
    
    func convertDateToString(stringDate: String) -> String {
        let stringSplited = stringDate.components(separatedBy: " ")

        var newDate = ""
        var newDatePass = stringSplited[0].components(separatedBy: "-")
//        print (newDatePass[1])
        if newDatePass[1] == "06"{
            
            newDate = "\(newDatePass[2]) Juni"
        }
        else if newDatePass[2] == "07"{
            newDate = "\(newDatePass[2]) Juni"
        }
//        print("Date: \(newDate)")
        return newDate
    }
}

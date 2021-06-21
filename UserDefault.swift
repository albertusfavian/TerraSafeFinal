//
//  UserDefault.swift
//  TerraSafe
//
//  Created by Gede Wicaksana on 20/06/21.
//

import Foundation

extension UserDefaults{
    
    func setValueLoad(value: Bool?){
        if value != nil {
            UserDefaults.standard.set(value, forKey: "code")
        } else {
            UserDefaults.standard.removeObject(forKey: "code")
        }
        UserDefaults.standard.synchronize()
    }
    
    func getValueLoad() -> Bool? {
        return UserDefaults.standard.value(forKey: "code") as? Bool
    }
}

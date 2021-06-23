//
//  User.swift
//  NativeInterfacesApplication
//
//  Created by SimonBachmaier on 21.06.21.
//

import Foundation

@objc(User)
class User : NSObject {
    var id: Int;
    var name: String;
    
    @objc
    init(id: Int, name: String) {
        self.id = id;
        self.name = name;
    }
}

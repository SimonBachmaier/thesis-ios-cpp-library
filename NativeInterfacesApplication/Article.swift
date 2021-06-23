//
//  Article.swift
//  NativeInterfacesApplication
//
//  Created by SimonBachmaier on 21.06.21.
//

import Foundation

@objc (Article)
class Article : NSObject {
    var id: Int;
    var authorId: Int;
    var headline: String;
    var content: String;
    
    @objc
    init(id: Int, authorId: Int, headline: String, content: String) {
        self.id = id;
        self.authorId = authorId;
        self.headline = headline;
        self.content = content;
    }
}

//
//  ContentView.swift
//  NativeInterfacesApplication
//
//  Created by SimonBachmaier on 15.06.21.
//

import SwiftUI

struct ContentView: View {
    @State var articlesText = "";
    var body: some View {
        Text(ObjCBridge().helloMessage("Swift"))
            .padding()
        Button(action: {
            let path = "\(NSHomeDirectory())/Documents/"
            print(path)
            print(ObjCBridge().openDatabaseConnection("\(path)test.db")!)
            
            ObjCBridge().setupTestData()
            
            let users = ObjCBridge().getAllUsers() as NSArray as! [User]
            print("users: \(users.count)")
            let articles = ObjCBridge().getAllArticles() as NSArray as! [Article]
            
            for article in articles {
                for user in users {
                    if (article.authorId == user.id) {
                        articlesText += """
                        ---------- Article ----------
                        id: \(article.id)
                        headline: \(article.headline)
                        content: \(article.content)
                        authorId: \(article.authorId)
                        authorName: \(user.name)\n
                        """
                    }
                }
            }
            articlesText += "---------------------------";
            print(articlesText)
            
            print(ObjCBridge().closeDatabaseConnection()!)
        }) {
            Text("Get Articles")
        }
        ScrollView() { Text(articlesText) }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

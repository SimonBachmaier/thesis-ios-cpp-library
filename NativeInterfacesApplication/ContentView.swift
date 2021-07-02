//
//  ContentView.swift
//  NativeInterfacesApplication
//
//  Created by SimonBachmaier on 15.06.21.
//

import SwiftUI

struct ContentView: View {
    var objCBridge = ObjCBridge();
    @State var helloMessage = ObjCBridge().helloMessage("Swift");
    @State var articlesText = "";
    
    var body: some View {
        Text(helloMessage ?? "")
            .padding()
        Button(action: {
            // Run test
            var testNumber = 0;
            let t1 = Date().timeIntervalSince1970;
            for _ in 0...10000000 {
                testNumber = Int(objCBridge.addOne(Int32(testNumber)));
            }
            let t2 = Date().timeIntervalSince1970;
            helloMessage = "Test took \((t2-t1) * 1000)ms";
            
            /*
             * Connect to database and read data
             */
            let path = "\(NSHomeDirectory())/Documents/"
            print(path)
            print(objCBridge.openDatabaseConnection("\(path)test.db")!)
            
            objCBridge.setupTestData()
            
            let users = objCBridge.getAllUsers() as NSArray as! [User]
            print("users: \(users.count)")
            let articles = objCBridge.getAllArticles() as NSArray as! [Article]
            
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
            
            print(objCBridge.closeDatabaseConnection()!)
        }) {
            Text("Show articles and run test")
        }
        ScrollView() { Text(articlesText) }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

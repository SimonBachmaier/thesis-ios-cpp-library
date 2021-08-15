//
//  ContentView.swift
//  NativeInterfacesApplication
//
//  Created by SimonBachmaier on 15.06.21.
//

import SwiftUI

struct ContentView: View {
    @State var helloMessage = ObjCBridge.helloMessage("Swift"); 
    @State var articlesText = "";
    
    var body: some View {
        Text(helloMessage ?? "")
            .padding()
        Button(action: {
            // Run test
            let iterations = 10000000;
            var testNumber = 0;
            var t1:TimeInterval, t2:TimeInterval;
            
            t1 = Date().timeIntervalSince1970;
            for _ in 0...iterations {
                testNumber = Int(ObjCBridge.addOne(Int32(testNumber)));
            }
            t2 = Date().timeIntervalSince1970;
            let cppTime = t2 - t1;
            
            testNumber = 0;
            t1 = Date().timeIntervalSince1970;
            for _ in 0...iterations {
                testNumber = Int(ObjCBridge.addOneObjC(Int32(testNumber)));
            }
            t2 = Date().timeIntervalSince1970;
            let objCTime = t2 - t1;
            
            testNumber = 0;
            t1 = Date().timeIntervalSince1970;
            for _ in 0...iterations {
                testNumber = addOneSwift(x: testNumber);
            }
            t2 = Date().timeIntervalSince1970;
            let swiftTime = t2 - t1;
            
            helloMessage = "C++ test took \((Int)(cppTime * 1000))ms. ObjC test took \((Int)(objCTime * 1000))ms. Swift test took \((Int)(swiftTime * 1000))ms.";
            
            /*
             * Connect to database and read data
             */
            let path = "\(NSHomeDirectory())/Documents/"
            print(path)
            print(ObjCBridge.openDatabaseConnection("\(path)test.db")!)
            
            ObjCBridge.setupTestData()
            
            let users = ObjCBridge.getAllUsers() as NSArray as! [User]
            print("users: \(users.count)")
            let articles = ObjCBridge.getAllArticles() as NSArray as! [Article]
            
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
            
            print(ObjCBridge.closeDatabaseConnection()!)
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

func addOneSwift (x: Int) -> Int {
    return x + 1;
}

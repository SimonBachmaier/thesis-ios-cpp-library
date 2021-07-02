//
//  objc-bridge.m
//  NativeInterfacesApplication
//
//  Created by SimonBachmaier on 16.06.21.
//

#import <Foundation/Foundation.h>

#import "objc-bridge.h"
#import "inc/cross-platform-library.h"

@implementation ObjCBridge

- (NSString *) helloMessage: (NSString *) from {
    std::string msg = cpl::HelloMessage([@"Objective C++ and " stringByAppendingString:from].UTF8String);
    return [NSString
            stringWithCString:msg.c_str()
            encoding:NSUTF8StringEncoding];
}

- (int) addOne: (int) x {
    return cpl::AddOne(x);
}

- (NSString *) openDatabaseConnection: (NSString *) dbPath {
    std::string msg = "";
    
    std::string err = "";
    cpl::Database& db = cpl::Database::GetInstance();
    if (db.CreateConnection(dbPath.UTF8String, &err) == false)
        msg = err;
    
    return [NSString
            stringWithCString:msg.c_str()
            encoding:NSUTF8StringEncoding];
}

- (NSString *) closeDatabaseConnection {
    std::string msg = "";
    
    cpl::Database& db = cpl::Database::GetInstance();
    if (db.CloseConnection() == false)
        msg = "Error closing database connection";
    
    return [NSString
            stringWithCString:msg.c_str()
            encoding:NSUTF8StringEncoding];
}

- (void) setupTestData {
    cpl::Database& db = cpl::Database::GetInstance();
    db.SetupTestData();
}

- (NSMutableArray<User*>*) getAllUsers {
    cpl::Database& db = cpl::Database::GetInstance();
    std::vector<cpl::User> dbUsers;
    db.GetAllUsers(&dbUsers);
    
    NSMutableArray<User*>* users = [[NSMutableArray alloc] init];
    for (cpl::User user: dbUsers) {
        [users addObject:[[User alloc]
                          initWithId: user.id
                          name: [NSString stringWithCString:user.name.c_str() encoding:NSUTF8StringEncoding]]];
    }
    
    return users;
}

- (NSMutableArray<Article*>*) getAllArticles {
    cpl::Database& db = cpl::Database::GetInstance();
    std::vector<cpl::Article> dbArticles;
    db.GetAllArticles(&dbArticles);
    
    NSMutableArray<Article*>* articles = [[NSMutableArray alloc] init];
    for (cpl::Article article: dbArticles) {
        [articles addObject:[[Article alloc]
                             initWithId: article.id
                             authorId: article.author_id
                             headline: [NSString stringWithCString:article.headline.c_str() encoding:NSUTF8StringEncoding]
                             content: [NSString stringWithCString:article.headline.c_str() encoding:NSUTF8StringEncoding]]	];
    }
    
    return articles;
}

@end

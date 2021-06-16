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
    std::string msg = cpl::HelloMessage([@"Objective C and" stringByAppendingString:from].UTF8String);
    return [NSString
            stringWithCString:msg.c_str()
            encoding:NSUTF8StringEncoding];
}

- (NSString *) openDatabaseConnection: (NSString *) dbPath {
    std::string msg = "";
    
    std::string* err;
    cpl::Database& db = cpl::Database::GetInstance();
    if (db.CreateConnection(dbPath.UTF8String, err) == false)
        msg = *err;
    
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

- (void) getAllUsers {
    cpl::Database& db = cpl::Database::GetInstance();
    std::vector<cpl::User> users;
    db.GetAllUsers(&users);
}

- (void) getAllArticles {
    cpl::Database& db = cpl::Database::GetInstance();
    std::vector<cpl::Article> articles;
    db.GetAllArticles(&articles);
}

@end

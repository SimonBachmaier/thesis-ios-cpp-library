//
//  objc-bridge.h
//  NativeInterfacesApplication
//
//  Created by SimonBachmaier on 16.06.21.
//

#ifndef objc_bridge_h
#define objc_bridge_h


@interface ObjCBridge : NSObject

- (NSString *) helloMessage: (NSString *) from;
- (NSString *) openDatabaseConnection: (NSString *) dbPath;
- (NSString *) closeDatabaseConnection;
- (void) setupTestData;
- (void) getAllUsers;
- (void) getAllArticles;

@end

#endif /* objc_bridge_h */

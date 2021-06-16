//
//  HelloWorldWrapper.mm
//  NativeInterfacesApplication
//
//  Created by SimonBachmaier on 16.06.21.
//

#import <Foundation/Foundation.h>

#import "HelloWorldWrapper.h"
#import "inc/HelloWorld.h"

@implementation HelloWorldWrapper
- (NSString *) sayHello {
    HelloWorld helloWorld;
    std::string helloWorldMessage = helloWorld.sayHello();
    return [NSString
            stringWithCString:helloWorldMessage.c_str()
            encoding:NSUTF8StringEncoding];
}
@end

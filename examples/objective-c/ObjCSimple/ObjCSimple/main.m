//
//  main.m
//  ObjCSimple
//
//  Created by Ming Chow on 9/9/14.
//  Copyright (c) 2014 Ming Chow. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Foo.h"


int main(int argc, const char * argv[]) {
    @autoreleasepool {
        Foo *example1 = [[Foo alloc]init];
        [example1 greetBy:@"Emily"];
        [example1 greetByFirstName:@"Ron" With:@"Soda Pop"];
    }
    return 0;
}

//
//  main.m
//  SportsMgmtObjC
//
//  Created by Ming Chow on 1/24/12.
//  Copyright (c) 2012 Tufts University. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SportsClient.h"

int main (int argc, const char * argv[])
{
    @autoreleasepool {
        SportsClient *golfer = [[SportsClient alloc]initWithFirstName:@"Eldrick" withLastName:@"Tont"];
        [golfer print];
    }
    return 0;
}

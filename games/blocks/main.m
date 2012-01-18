//
//  main.m
//  blocks
//
//  Created by Benjamin Horn on 8/15/10.
//  Copyright University of Chicago 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#define PI 3.14159265
#define DEG PI/180

int main(int argc, char *argv[]) {
    
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
    int retVal = UIApplicationMain(argc, argv, nil, nil);
    [pool release];
    return retVal;
}

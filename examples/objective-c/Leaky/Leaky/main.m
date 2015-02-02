//
//  main.m
//  Leaky
//
//  Created by Ming Chow on 1/16/12.
//  Copyright (c) 2012 Tufts University. All rights reserved.
//

#import <Foundation/Foundation.h>

int main (int argc, const char * argv[])
{
    @autoreleasepool {
        NSMutableString *poc = [[NSMutableString alloc] initWithString:@"Leaker"];
        while (1) {
            [poc stringByAppendingFormat:poc];
        }        
    }
    return 0;
}


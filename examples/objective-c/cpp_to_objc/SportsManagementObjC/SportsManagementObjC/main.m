//
//  main.m
//  SportsMgmtObjC
//
//  Created by Ming Chow on 1/24/12.
//  Copyright (c) 2012 Tufts University. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SportsClient.h"
#import "Fighter.h"

int main (int argc, const char * argv[])
{
    @autoreleasepool {
        Fighter *e = [[Fighter alloc] initWithFirstName:@"Anderson" withLastName:@"Silva"];
        
        [e sendEmailWithSubject:@"Hello" withMessage:@"Good-bye!"];  
        
        Fighter *f = [[Fighter alloc] initWith:@"Jon" and:@"Jones" and:24 and:@"UNKNOWN"];
        f.affiliation = @"UFC";
        f.nickname = @"Bones";
        f.weight = 205;
        [f print];

    }
    return 0;
}

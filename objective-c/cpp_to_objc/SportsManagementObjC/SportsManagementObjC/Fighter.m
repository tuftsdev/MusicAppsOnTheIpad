//
//  Fighter.m
//  SportsMgmtObjC
//
//  Created by Ming Chow on 1/26/12.
//  Copyright (c) 2012 Tufts University. All rights reserved.
//

#import "Fighter.h"

@implementation Fighter

@synthesize weight, affiliation, nickname;

-(id) initWith:(NSString *)fname and:(NSString *)lname and:(unsigned int)a and:(NSString *)e
{
    NSLog(@"Starting record for fighter...");
    self = [super initWithFirstName:fname withLastName:lname withAge:a withEmail:e];
    if (self) {
        weight = 0;
        affiliation = @"";
        nickname = @"";
    }
    return self;
}

-(void) print
{
    NSLog(@"First Name => %@", [self firstName]);
    NSLog(@"Last Name => %@", [self lastName]);
    NSLog(@"E-Mail Address => %@", [self email]);
    NSLog(@"Age => %i", [self age]);
    NSLog(@"Weight => %i", weight);
    NSLog(@"Nickname => %@", nickname);
    NSLog(@"Affiliation => %@", affiliation);
}

-(void) dealloc
{
    NSLog(@"...boo...");
    //[super release];
}

@end

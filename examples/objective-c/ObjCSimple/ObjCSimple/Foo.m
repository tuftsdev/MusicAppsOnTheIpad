//
//  Foo.m
//  ObjCSimple
//
//  Created by Ming Chow on 9/9/14.
//  Copyright (c) 2014 Ming Chow. All rights reserved.
//

#import "Foo.h"

@implementation Foo

@synthesize flavor;

- (id)init {
    self = [super init];
    if (self) {
        NSArray *list = @[@"Tom", @"Dick", @"Harry", @18];
        NSLog(@"I fought the law...");
        for (NSString *item in list) {
            NSLog(@"***** %@", item);
        }
    }
    return self;
}

-(void)greetBy: (NSString *)firstName
{
    NSLog(@"Good day %@!", firstName);
}

-(void)greetByFirstName: (NSString *) firstName With: (NSString *) drinkOfTheDay
{
    NSLog(@"Hello %@, the drink of the day is %@ %@", firstName, flavor, drinkOfTheDay);
}

-(void) dealloc {
    NSLog(@"...and the law won.");
}


@end

//
//  Foo.h
//  ObjCSimple
//
//  Created by Ming Chow on 9/9/14.
//  Copyright (c) 2014 Ming Chow. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Foo : NSObject

@property NSString *flavor;

-(void)greetBy: (NSString *)firstName;
-(void)greetByFirstName: (NSString *) firstName With: (NSString *) drinkOfTheDay;

@end

//
//  Books.h
//  DataTest
//
//  Created by Ming Chow on 3/26/13.
//  Copyright (c) 2013 Tufts University. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Books : NSManagedObject

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * author;
@property (nonatomic, retain) NSString * isbn;

@end

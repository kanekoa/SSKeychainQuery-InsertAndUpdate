//
//  SSKeychainQuery+InsertAndUpdate.h
//  SSKeychainQuery+InsertAndUpdate
//
//  Created by kanekoa on 2013/05/22.
//  Copyright (c) 2013 kanekoa All rights reserved.
//

#import "SSKeychainQuery.h"

@interface SSKeychainQuery (InsertAndUpdate)
- (BOOL)insert:(NSError *__autoreleasing *)error;
- (BOOL)update:(NSError *__autoreleasing *)error;
@end

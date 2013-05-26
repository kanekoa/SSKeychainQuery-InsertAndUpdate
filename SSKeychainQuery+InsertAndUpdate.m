//
//  SSKeychainQuery+InsertAndUpdate.m
//  SSKeychainQuery+InsertAndUpdate
//
//  Created by kanekoa on 2013/05/22.
//  Copyright (c) 2013 kanekoa All rights reserved.
//

#import "SSKeychain.h"
#import "SSKeychainQuery+InsertAndUpdate.h"

@interface SSKeychainQuery ()
+ (NSError *)errorWithCode:(OSStatus)code;
- (NSMutableDictionary *)query;
@end

@implementation SSKeychainQuery (InsertAndUpdate)

- (BOOL)insert:(NSError *__autoreleasing *)error
{
    OSStatus status = SSKeychainErrorBadArguments;
    if (!self.service || !self.account || !self.passwordData) {
		if (error) {
			*error = [[self class] errorWithCode:status];
		}
		return NO;
	}

    NSMutableDictionary *query = [self query];
    [query setObject:self.passwordData forKey:(__bridge id)kSecValueData];
    if (self.label) {
        [query setObject:self.label forKey:(__bridge id)kSecAttrLabel];
    }
#if __IPHONE_4_0 && TARGET_OS_IPHONE
	CFTypeRef accessibilityType = [SSKeychain accessibilityType];
    if (accessibilityType) {
        [query setObject:(__bridge id)accessibilityType forKey:(__bridge id)kSecAttrAccessible];
    }
#endif
    status = SecItemAdd((__bridge CFDictionaryRef)query, NULL);

	if (status != errSecSuccess && error != NULL) {
		*error = [[self class] errorWithCode:status];
	}

	return (status == errSecSuccess);
}


- (BOOL)update:(NSError *__autoreleasing *)error
{
    OSStatus status = SSKeychainErrorBadArguments;
    if (!self.service || !self.account || !self.passwordData) {
        if (error) {
            *error = [[self class] errorWithCode:status];
        }
        return NO;
    }

    NSMutableDictionary *query = [self query];

    NSMutableDictionary *attributes = [[NSMutableDictionary alloc] init];
    [attributes setObject:self.passwordData forKey:(__bridge id)kSecValueData];
    if (self.label) {
        [attributes setObject:self.label forKey:(__bridge id)kSecAttrLabel];
    }
#if __IPHONE_4_0 && TARGET_OS_IPHONE
	CFTypeRef accessibilityType = [SSKeychain accessibilityType];
    if (accessibilityType) {
        [attributes setObject:(__bridge id)accessibilityType forKey:(__bridge id)kSecAttrAccessible];
    }
#endif

    status = SecItemUpdate((__bridge CFDictionaryRef)query, (__bridge CFDictionaryRef)attributes);

	if (status != errSecSuccess && error != NULL) {
		*error = [[self class] errorWithCode:status];
	}

	return (status == errSecSuccess);
}

@end

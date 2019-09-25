//
//  ObjCDelegateProxy.m
//  CombineCocoa
//
//  Created by Joan Disho on 25.09.19.
//

#import <Foundation/Foundation.h>
#import "ObjCDelegateProxy.h"
#import "CombineCocoa-Bridging-Header.h"

static NSSet *selectors;

@implementation ObjCDelegateProxy

+ (NSSet *) selectors {
    return selectors;
}

- (void)interceptedSelector:(SEL _Nonnull)selector arguments:(NSArray * _Nonnull)arguments {}

@end


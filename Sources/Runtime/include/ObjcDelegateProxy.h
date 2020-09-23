//
//  ObjcDelegateProxy.h
//  CombineCocoa
//
//  Created by Joan Disho on 25/09/2019.
//  Copyright © 2020 Combine Community. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ObjcDelegateProxy: NSObject

@property (nonnull, strong, atomic, readonly) NSSet <NSValue *> *selectors;

- (void)interceptedSelector:(SEL _Nonnull)selector arguments:(NSArray * _Nonnull)arguments;
- (BOOL)respondsToSelector:(SEL _Nonnull)aSelector;
- (BOOL)canRespondToSelector:(SEL _Nonnull)selector;

@end

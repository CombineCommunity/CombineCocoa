//
//  ObjcDelegateProxy.h
//  CombineCocoa
//
//  Created by Joan Disho on 25/09/2019.
//  Copyright © 2019 Joan Disho. All rights reserved.
//

@interface ObjcDelegateProxy : NSObject

+ (NSSet *_Nonnull) selectors;
- (void)interceptedSelector:(SEL _Nonnull)selector arguments:(NSArray * _Nonnull)arguments;

@end

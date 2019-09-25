//
//  ObjCDelegateProxy.h
//  CombineCocoa
//
//  Created by Joan Disho on 25.09.19.
//

#ifndef ObjCDelegateProxy_h
#define ObjCDelegateProxy_h


#endif /* ObjCDelegateProxy_h */

@interface ObjCDelegateProxy : NSObject

+ (NSSet *_Nonnull) selectors;
- (void)interceptedSelector:(SEL _Nonnull)selector arguments:(NSArray * _Nonnull)arguments;

@end

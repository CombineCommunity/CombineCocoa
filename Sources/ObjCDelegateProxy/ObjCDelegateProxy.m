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

NSArray * _Nonnull unpackInvocation(NSInvocation * _Nonnull invocation) {
    NSUInteger numberOfArguments = invocation.methodSignature.numberOfArguments;
    NSMutableArray *arguments = [NSMutableArray arrayWithCapacity:numberOfArguments - 2];

     // Ignore `self` and `_cmd` at index 0 and 1.
    for (NSUInteger index = 2; index < numberOfArguments; ++index) {
        const char *argumentType = [invocation.methodSignature getArgumentTypeAtIndex:index];

        // Skip const type qualifier.
        if (argumentType[0] == 'r') {
            argumentType++;
        }

        #define isArgumentType(type) \
            strcmp(argumentType, @encode(type)) == 0

        #define extractTypeAndSetValue(type, value) \
            type argument = 0; \
            [invocation getArgument:&argument atIndex:index]; \
            value = @(argument); \

        id _Nonnull value;

        if (isArgumentType(id) || isArgumentType(Class) || isArgumentType(void (^)(void))) {
            __unsafe_unretained id argument = nil;
            [invocation getArgument:&argument atIndex:index];
            value = argument;
        }
        else if (isArgumentType(char)) {
            extractTypeAndSetValue(char, value);
        }
        else if (isArgumentType(short)) {
            extractTypeAndSetValue(short, value);
        }
        else if (isArgumentType(int)) {
            extractTypeAndSetValue(int, value);
        }
        else if (isArgumentType(long)) {
            extractTypeAndSetValue(long, value);
        }
        else if (isArgumentType(long long)) {
            extractTypeAndSetValue(long long, value);
        }
        else if (isArgumentType(unsigned char)) {
             extractTypeAndSetValue(unsigned char, value);
        }
        else if (isArgumentType(unsigned short)) {
            extractTypeAndSetValue(unsigned short, value);
        }
        else if (isArgumentType(unsigned int)) {
            extractTypeAndSetValue(unsigned int, value);
        }
        else if (isArgumentType(unsigned long)) {
            extractTypeAndSetValue(unsigned long, value);
        }
        else if (isArgumentType(unsigned long long)) {
            extractTypeAndSetValue(unsigned long long, value);
        }
        else if (isArgumentType(float)) {
            extractTypeAndSetValue(float, value);
        }
        else if (isArgumentType(double)) {
            extractTypeAndSetValue(double, value);
        }
        else if (isArgumentType(BOOL)) {
            extractTypeAndSetValue(BOOL, value);
        }
        else if (isArgumentType(const char *)) {
            extractTypeAndSetValue(const char *, value);
        }
        else {
            NSUInteger size = 0;
            NSGetSizeAndAlignment(argumentType, &size, NULL);
            NSCParameterAssert(size > 0);
            uint8_t data[size];
            [invocation getArgument:&data atIndex:index];

            value = [NSValue valueWithBytes:&data objCType:argumentType];
        }

        [arguments addObject:value];
    }

    return arguments;
}

@end


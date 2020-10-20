//
//  ObjcDelegateProxy.m
//  CombineCocoa
//
//  Created by Joan Disho & Shai Mishali on 25/09/2019.
//  Copyright © 2020 Combine Community. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "include/ObjcDelegateProxy.h"
#import <objc/runtime.h>

#define OBJECT_VALUE(object) [NSValue valueWithNonretainedObject:(object)]

static NSMutableDictionary<NSValue *, NSSet<NSValue *> *> *allSelectors;

@implementation ObjcDelegateProxy

- (NSSet *)selectors {
    return allSelectors[OBJECT_VALUE(self.class)];
}

+ (void)initialize
{
    @synchronized (ObjcDelegateProxy.class) {
        if (!allSelectors) {
            allSelectors = [NSMutableDictionary new];
        }
        allSelectors[OBJECT_VALUE(self)] = [self selectorsOfClass:self
                     withEncodedReturnType:[NSString stringWithFormat:@"%s", @encode(void)]];
    }
}

- (BOOL)respondsToSelector:(SEL _Nonnull)aSelector {
    return [super respondsToSelector:aSelector] || [self canRespondToSelector:aSelector];
}

- (BOOL)canRespondToSelector:(SEL _Nonnull)selector {
    for (id current in allSelectors[OBJECT_VALUE(self.class)]) {
        if (selector == (SEL) [current pointerValue]) {
            return true;
        }
    }

    return false;
}

- (void)interceptedSelector:(SEL _Nonnull)selector arguments:(NSArray * _Nonnull)arguments {}

- (void)forwardInvocation:(NSInvocation *)anInvocation
{
    NSArray * _Nonnull arguments = unpackInvocation(anInvocation);
    [self interceptedSelector:anInvocation.selector arguments:arguments];
}

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

+ (NSSet <NSValue *> *) selectorsOfClass: (Class _Nonnull __unsafe_unretained) class
                   withEncodedReturnType: (NSString *) encodedReturnType {
    unsigned int protocolsCount = 0;
    Protocol * __unsafe_unretained _Nonnull * _Nullable protocolPointer = class_copyProtocolList(class, &protocolsCount);

    NSMutableSet <NSValue *> *allSelectors = [[self selectorsOfProtocolPointer:protocolPointer
                                                                         count:protocolsCount
                                                          andEncodedReturnType:encodedReturnType] mutableCopy];

    Class _Nonnull __unsafe_unretained superclass = class_getSuperclass(class);

    if(superclass != nil) {
        NSSet <NSValue *> *superclassSelectors = [self selectorsOfClass:superclass
                                                  withEncodedReturnType:encodedReturnType];
        [allSelectors unionSet:superclassSelectors];
    }

    free(protocolPointer);

    return allSelectors;
}

+ (NSSet <NSValue *> *) selectorsOfProtocol: (Protocol * __unsafe_unretained) protocol
                       andEncodedReturnType: (NSString *) encodedReturnType {
    unsigned int protocolMethodCount = 0;
    struct objc_method_description * _Nullable methodDescriptions = protocol_copyMethodDescriptionList(protocol, false, true, &protocolMethodCount);

    // Protocol pointers
    unsigned int protocolsCount = 0;
    Protocol * __unsafe_unretained _Nonnull * _Nullable protocols = protocol_copyProtocolList(protocol, &protocolsCount);

    NSMutableSet <NSValue *> *allSelectors = [NSMutableSet new];

    // Protocol methods
    for (NSInteger idx = 0; idx < protocolMethodCount; idx++) {
        struct objc_method_description description = methodDescriptions[idx];

        if ([self encodedMethodReturnTypeForMethod:description] == encodedReturnType) {
            [allSelectors addObject: [NSValue valueWithPointer:description.name]];
        }
    }

    if (protocols != nil) {
        [allSelectors unionSet: [self selectorsOfProtocolPointer:protocols
                                                           count:protocolsCount
                                            andEncodedReturnType:encodedReturnType]];
    }

    free(methodDescriptions);
    free(protocols);

    return allSelectors;
}

+ (NSSet <NSValue *> *) selectorsOfProtocolPointer: (Protocol * __unsafe_unretained * _Nullable) pointer
                                             count: (NSInteger) count
                       andEncodedReturnType: (NSString *) encodedReturnType {
    NSMutableSet <NSValue *> *allSelectors = [NSMutableSet new];

    for (NSInteger i = 0; i < count; i++) {
        Protocol * __unsafe_unretained _Nullable protocol = pointer[i];

        if (protocol == nil) { continue; }
        [allSelectors unionSet:[self selectorsOfProtocol:protocol
                                    andEncodedReturnType:encodedReturnType]];
    }

    return allSelectors;
}

+ (NSString *)encodedMethodReturnTypeForMethod: (struct objc_method_description) method {
    return [[NSString alloc] initWithBytes:method.types
                                    length:1
                                  encoding:NSASCIIStringEncoding];
}


@end


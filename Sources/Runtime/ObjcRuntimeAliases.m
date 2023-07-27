//
//  ObjcRuntimeAliases.m
//  
//
//  Created by Benjamin Deckys on 2023/07/27.
//

#import <objc/runtime.h>
#import <objc/message.h>

const IMP _combinecocoa_objc_msgForward = _objc_msgForward;

void _combinecocoa_objc_setAssociatedObject(
											const void* object,
											const void* key,
											id value,
											objc_AssociationPolicy policy
											) {
	__unsafe_unretained id obj = (__bridge typeof(obj)) object;
	objc_setAssociatedObject(obj, key, value, policy);
}

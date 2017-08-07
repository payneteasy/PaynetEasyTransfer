//
//  NSMutableDictionary+Values.m
//
//  Created by Ryan Maxwell on 3/08/13.
//  Copyright (c) 2013 Ryan Maxwell. All rights reserved.
//

#import "NSMutableDictionary+Values.h"

static NSString *const KeyPathDelimiter = @".";

@implementation NSMutableDictionary (Values)

- (void)set_Object:(id)object forPath:(NSString *)keyPath {
    [self set_Object:object forPath:keyPath createIntermediateDictionaries:YES replaceIntermediateObjects:YES];
}

- (void)set_Object:(id)object forPath:(NSString *)keyPath createIntermediateDictionaries:(BOOL)createIntermediates replaceIntermediateObjects:(BOOL)replaceIntermediates {
    [self set_Object:object onObject:self forPath:keyPath createIntermediateDictionaries:createIntermediates replaceIntermediateObjects:replaceIntermediates];
}

- (void)set_Object:(id)object onObject:(id)target forPath:(NSString *)keyPath createIntermediateDictionaries:(BOOL)createIntermediates replaceIntermediateObjects:(BOOL)replaceIntermediates {
    if (!object)
        return;
    
    if (!keyPath) {
        [NSException raise:NSInvalidArgumentException format:@""];
        return;
    }
    
    if ([keyPath rangeOfString:KeyPathDelimiter].location == NSNotFound) {
        [target setObject:object forKey:keyPath];
        return;
    }
    
    NSArray *pathComponents = [keyPath componentsSeparatedByString:KeyPathDelimiter];
    
    NSString *rootKey = [pathComponents objectAtIndex:0];
    
    NSMutableDictionary *replacementDict = [NSMutableDictionary dictionary];
    
    id previousObject = target;
    NSMutableDictionary *previousReplacement = replacementDict;
    
    BOOL reachedDictionaryLeaf = NO;
    
    for (NSString *path in pathComponents) {
        id currentObject = (reachedDictionaryLeaf) ? nil : [previousObject objectForKey:path];
        
        if (currentObject == nil) {
            reachedDictionaryLeaf = YES;
            
            if (createIntermediates) {
                NSMutableDictionary *newNode = [NSMutableDictionary dictionary];
                [previousReplacement setObject:newNode forKey:path];
                previousReplacement = newNode;
            } else {
                return;
            }
        } else if ([currentObject isKindOfClass:[NSDictionary class]]) {
            NSMutableDictionary *newNode = [currentObject mutableCopy];
            [previousReplacement setObject:newNode forKey:path];
#if !__has_feature(objc_arc)
            [newNode release];
#endif
            previousReplacement = newNode;
        } else {
            reachedDictionaryLeaf = YES;
            
            if (replaceIntermediates) {
                NSMutableDictionary *newNode = [NSMutableDictionary dictionary];
                [previousReplacement setObject:newNode forKey:path];
                previousReplacement = newNode;
            } else {
                return;
            }
        }
        
        previousObject = currentObject;
    }
    
    [replacementDict setValue:object forKeyPath:keyPath];
    
    [target setObject:[replacementDict objectForKey:rootKey] forKey:rootKey];
}

@end

//
//  NSDictionary+Values.m
//
//  Created by EIMEI on 2013/05/06.
//  Copyright (c) 2013 stack3.net (http://stack3.net/)
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import "NSDictionary+Values.h"

@implementation NSDictionary (Values)

#pragma mark - ForKey

- (BOOL)get_BoolForKey:(NSString *)key defaultValue:(BOOL)defaultValue
{
    id obj = [self objectForKey:key];
	if (obj && [obj isKindOfClass:[NSNumber class]]) {
		return [(NSNumber *)obj boolValue];
	} else {
		return defaultValue;
	}
}

- (BOOL)get_BoolForKey:(NSString *)key
{
	return [self get_BoolForKey:key defaultValue:NO];
}

- (NSInteger)get_IntegerForKey:(NSString *)key defaultValue:(NSInteger)defaultValue
{
	id obj = [self objectForKey:key];
	if (obj) {
        if ([obj isKindOfClass:[NSNumber class]]) {
            return [(NSNumber *)obj integerValue];
        } else if ([obj isKindOfClass:[NSString class]]) {
            return [(NSString *)obj integerValue];
        }
    }
    
    return defaultValue;
}

- (NSInteger)get_IntegerForKey:(NSString *)key
{
	return [self get_IntegerForKey:key defaultValue:0];
}

- (NSUInteger)get_UnsignedIntegerForKey:(NSString *)key defaultValue:(NSUInteger)defaultValue
{
	id obj = [self objectForKey:key];
	if (obj) {
        if ([obj isKindOfClass:[NSNumber class]]) {
            return [(NSNumber *)obj unsignedIntegerValue];
        } else if ([obj isKindOfClass:[NSString class]]) {
            return (NSInteger)strtoul([(NSString *)obj UTF8String], NULL, 0);
        }
    }
    
    return defaultValue;
}

- (NSUInteger)get_UnsignedIntegerForKey:(NSString *)key
{
	return [self get_UnsignedIntegerForKey:key defaultValue:0];
}

- (char)get_CharForKey:(NSString *)key defaultValue:(char)defaultValue
{
	id obj = [self objectForKey:key];
	if (obj) {
        if ([obj isKindOfClass:[NSNumber class]]) {
            return [(NSNumber *)obj charValue];
        } else if ([obj isKindOfClass:[NSString class]]) {
            return (char)[(NSString *)obj integerValue];
        }
    }
    
    return defaultValue;
}

- (char)get_CharForKey:(NSString *)key
{
	return [self get_CharForKey:key defaultValue:0];
}

- (unsigned char)get_UnsignedCharForKey:(NSString *)key defaultValue:(unsigned char)defaultValue
{
	id obj = [self objectForKey:key];
	if (obj) {
        if ([obj isKindOfClass:[NSNumber class]]) {
            return [(NSNumber *)obj unsignedCharValue];
        } else if ([obj isKindOfClass:[NSString class]]) {
            return (unsigned char)[(NSString *)obj integerValue];
        }
    }
    
    return defaultValue;
}

- (unsigned char)get_UnsignedCharForKey:(NSString *)key
{
	return [self get_UnsignedCharForKey:key defaultValue:0];
}

- (short)get_ShortForKey:(NSString *)key defaultValue:(short)defaultValue
{
	id obj = [self objectForKey:key];
	if (obj) {
        if ([obj isKindOfClass:[NSNumber class]]) {
            return [(NSNumber *)obj shortValue];
        } else if ([obj isKindOfClass:[NSString class]]) {
            return (short)[(NSString *)obj integerValue];
        }
    }
    
    return defaultValue;
}

- (short)get_ShortForKey:(NSString *)key
{
	return [self get_ShortForKey:key defaultValue:0];
}

- (unsigned short)get_UnsignedShortForKey:(NSString *)key defaultValue:(unsigned short)defaultValue
{
	id obj = [self objectForKey:key];
	if (obj) {
        if ([obj isKindOfClass:[NSNumber class]]) {
            return [(NSNumber *)obj unsignedShortValue];
        } else if ([obj isKindOfClass:[NSString class]]) {
            return (unsigned short)[(NSString *)obj integerValue];
        }
    }
    
    return defaultValue;
}

- (unsigned short)get_UnsignedShortForKey:(NSString *)key
{
	return [self get_UnsignedShortForKey:key defaultValue:0];
}

- (long)get_LongForKey:(NSString *)key defaultValue:(long)defaultValue
{
	id obj = [self objectForKey:key];
	if (obj) {
        if ([obj isKindOfClass:[NSNumber class]]) {
            return [(NSNumber *)obj longValue];
        } else if ([obj isKindOfClass:[NSString class]]) {
            return (long)[(NSString *)obj integerValue];
        }
    }
    
    return defaultValue;
}

- (long)get_LongForKey:(NSString *)key
{
	return [self get_LongForKey:key defaultValue:0];
}

- (unsigned long)get_UnsignedLongForKey:(NSString *)key defaultValue:(unsigned long)defaultValue
{
	id obj = [self objectForKey:key];
	if (obj) {
        if ([obj isKindOfClass:[NSNumber class]]) {
            return [(NSNumber *)obj unsignedLongValue];
        } else if ([obj isKindOfClass:[NSString class]]) {
            return (unsigned long)strtoul([(NSString *)obj UTF8String], NULL, 0);
        }
    }
    
    return defaultValue;
}

- (unsigned long)get_UnsignedLongForKey:(NSString *)key
{
	return [self get_UnsignedLongForKey:key defaultValue:0];
}

- (long long)get_LongLongForKey:(NSString *)key defaultValue:(long long)defaultValue
{
	id obj = [self objectForKey:key];
	if (obj) {
        if ([obj isKindOfClass:[NSNumber class]]) {
            return [(NSNumber *)obj longLongValue];
        } else if ([obj isKindOfClass:[NSString class]]) {
            return (long long)strtoll([(NSString *)obj UTF8String], NULL, 0);
        }
    }
    
    return defaultValue;
}

- (long long)get_LongLongForKey:(NSString *)key
{
	return [self get_LongLongForKey:key defaultValue:0];
}

- (unsigned long long)get_UnsignedLongLongForKey:(NSString *)key defaultValue:(unsigned long long)defaultValue
{
	id obj = [self objectForKey:key];
	if (obj) {
        if ([obj isKindOfClass:[NSNumber class]]) {
            return [(NSNumber *)obj unsignedLongLongValue];
        } else if ([obj isKindOfClass:[NSString class]]) {
            return (unsigned long long)strtoull([(NSString *)obj UTF8String], NULL, 0);
        }
    }
    
    return defaultValue;
}

- (unsigned long long)get_UnsignedLongLongForKey:(NSString *)key
{
	return [self get_UnsignedLongLongForKey:key defaultValue:0];
}

- (int8_t)get_Int8ForKey:(NSString *)key defaultValue:(int8_t)defaultValue
{
    return [self get_CharForKey:key defaultValue:defaultValue];
}

- (int8_t)get_Int8ForKey:(NSString *)key
{
	return [self get_CharForKey:key];
}

- (uint8_t)get_UInt8ForKey:(NSString *)key defaultValue:(uint8_t)defaultValue
{
    return [self get_UnsignedCharForKey:key defaultValue:defaultValue];
}

- (uint8_t)get_UInt8ForKey:(NSString *)key
{
	return [self get_UnsignedCharForKey:key];
}

- (int16_t)get_Int16ForKey:(NSString *)key defaultValue:(int16_t)defaultValue
{
    return [self get_ShortForKey:key defaultValue:defaultValue];
}

- (int16_t)get_Int16ForKey:(NSString *)key
{
	return [self get_ShortForKey:key];
}

- (uint16_t)get_UInt16ForKey:(NSString *)key defaultValue:(uint16_t)defaultValue
{
    return [self get_UnsignedShortForKey:key defaultValue:defaultValue];
}

- (uint16_t)get_UInt16ForKey:(NSString *)key
{
	return [self get_UnsignedShortForKey:key];
}

- (int32_t)get_Int32ForKey:(NSString *)key defaultValue:(int32_t)defaultValue
{
    return (int32_t)[self get_LongForKey:key defaultValue:defaultValue];
}

- (int32_t)get_Int32ForKey:(NSString *)key
{
	return (int32_t)[self get_LongForKey:key];
}

- (uint32_t)get_UInt32ForKey:(NSString *)key defaultValue:(uint32_t)defaultValue
{
    return (uint32_t)[self get_UnsignedLongForKey:key defaultValue:defaultValue];
}

- (uint32_t)get_UInt32ForKey:(NSString *)key
{
	return (uint32_t)[self get_UnsignedLongForKey:key];
}

- (int64_t)get_Int64ForKey:(NSString *)key defaultValue:(int64_t)defaultValue
{
    return [self get_LongLongForKey:key defaultValue:defaultValue];
}

- (int64_t)get_Int64ForKey:(NSString *)key
{
	return [self get_LongLongForKey:key];
}

- (uint64_t)get_UInt64ForKey:(NSString *)key defaultValue:(uint64_t)defaultValue
{
	return [self get_UnsignedLongLongForKey:key defaultValue:defaultValue];
}

- (uint64_t)get_UInt64ForKey:(NSString *)key
{
	return [self get_UnsignedLongLongForKey:key];
}

- (float)get_FloatForKey:(NSString *)key defaultValue:(float)defaultValue
{
	id obj = [self objectForKey:key];
	if (obj) {
        if ([obj isKindOfClass:[NSNumber class]]) {
            return [(NSNumber *)obj floatValue];
        } else if ([obj isKindOfClass:[NSString class]]) {
            return [(NSString *)obj floatValue];
        }
    }
    
    return defaultValue;
}

- (float)get_FloatForKey:(NSString *)key
{
	return [self get_FloatForKey:key defaultValue:0];
}

- (double)get_DoubleForKey:(NSString *)key defaultValue:(double)defaultValue
{
	id obj = [self objectForKey:key];
	if (obj) {
        if ([obj isKindOfClass:[NSNumber class]]) {
            return [(NSNumber *)obj doubleValue];
        } else if ([obj isKindOfClass:[NSString class]]) {
            return [(NSString *)obj doubleValue];
        }
    }
    
    return defaultValue;
}

- (double)get_DoubleForKey:(NSString *)key
{
	return [self get_DoubleForKey:key defaultValue:0];
}

- (NSTimeInterval)get_TimeIntervalForKey:(NSString *)key defaultValue:(NSTimeInterval)defaultValue
{
    return [self get_DoubleForKey:key defaultValue:defaultValue];
}

- (NSTimeInterval)get_TimeIntervalForKey:(NSString *)key
{
	return [self get_DoubleForKey:key defaultValue:0];
}

- (id)get_ObjectForKey:(NSString *)key defaultValue:(NSString *)defaultValue
{
	id obj = [self objectForKey:key];
	if (obj) {
		return obj;
	} else {
		return defaultValue;
	}
}

- (id)get_ObjectForKey:(NSString *)key
{
    return [self get_ObjectForKey:key defaultValue:nil];
}

- (NSString *)get_StringForKey:(NSString *)key defaultValue:(NSString *)defaultValue
{
	id obj = [self objectForKey:key];
	if (obj) {
        if ([obj isKindOfClass:[NSString class]]) {
            return obj;
        } else if ([obj isKindOfClass:[NSNumber class]]) {
            return [(NSNumber *)obj stringValue];
        }
    }
    
    return defaultValue;
}

- (NSString *)get_StringForKey:(NSString *)key
{
	return [self get_StringForKey:key defaultValue:nil];
}

- (NSArray *)get_ArrayForKey:(NSString *)key defaultValue:(NSArray *)defaultValue
{
	id obj = [self objectForKey:key];
    if (obj && [obj isKindOfClass:[NSArray class]]) {
		return obj;
	} else {
		return defaultValue;
	}
}

- (NSArray *)get_ArrayForKey:(NSString *)key
{
	return [self get_ArrayForKey:key defaultValue:nil];
}

- (NSDictionary *)get_DictionaryForKey:(NSString *)key defaultValue:(NSDictionary *)defaultValue
{
	id obj = [self objectForKey:key];
    if (obj && [obj isKindOfClass:[NSDictionary class]]) {
		return obj;
	} else {
		return defaultValue;
	}
}

- (NSDictionary *)get_DictionaryForKey:(NSString *)key
{
	return [self get_DictionaryForKey:key defaultValue:nil];
}

- (NSDate *)get_DateForKey:(NSString *)key defaultValue:(NSDate *)defaultValue
{
	id obj = [self objectForKey:key];
    if (obj && [obj isKindOfClass:[NSDate class]]) {
		return obj;
	} else {
		return defaultValue;
	}
}

- (NSDate *)get_DateForKey:(NSString *)key
{
	return [self get_DateForKey:key defaultValue:nil];
}

- (NSData *)get_DataForKey:(NSString  *)key defaultValue:(NSData *)defaultValue
{
    id obj = [self objectForKey:key];
	if (obj && [obj isKindOfClass:[NSData class]]) {
		return obj;
	} else {
		return defaultValue;
	}
}

- (NSData *)get_DataForKey:(NSString *)key
{
    return [self get_DataForKey:key defaultValue:nil];
}

- (NSURL *)get_URLForKey:(NSString *)key defaultValue:(NSURL *)defaultValue
{
    id obj = [self objectForKey:key];
	if (obj && [obj isKindOfClass:[NSURL class]]) {
		return obj;
	} else {
		return defaultValue;
	}
}

- (NSURL *)get_URLForKey:(NSString *)key
{
    return [self get_URLForKey:key defaultValue:nil];
}

#pragma mark - ForPath

- (NSDictionary *)get_DictionaryForPaths:(NSArray *)paths
{
    if (paths.count == 0) {
        return nil;
    }
    
    NSDictionary *target = self;
    for (int i = 0; i < paths.count - 1; i++) {
        NSString *key = [paths objectAtIndex:i];
        target = [target get_DictionaryForKey:key];
        if (!target) {
            return nil;
        }
    }
    
    return target;
}

- (BOOL)get_BoolForPath:(NSString *)path defaultValue:(BOOL)defaultValue
{
    NSArray *paths = [path componentsSeparatedByString:@"."];
    if (paths.count == 1) {
        return [self get_BoolForKey:paths.lastObject];
    } else if (paths.count >= 2) {
        NSDictionary *obj = [self get_DictionaryForPaths:paths];
        return [obj get_BoolForKey:paths.lastObject];
    }
    
    return defaultValue;
}

- (BOOL)get_BoolForPath:(NSString *)path
{
    return [self get_BoolForPath:path defaultValue:NO];
}

- (NSInteger)get_IntegerForPath:(NSString *)path defaultValue:(NSInteger)defaultValue
{
    NSArray *paths = [path componentsSeparatedByString:@"."];
    if (paths.count == 1) {
        return [self get_IntegerForKey:paths.lastObject];
    } else if (paths.count >= 2) {
        NSDictionary *obj = [self get_DictionaryForPaths:paths];
        return [obj get_IntegerForKey:paths.lastObject];
    }
    
    return defaultValue;
}

- (NSInteger)get_IntegerForPath:(NSString *)path
{
    return [self get_IntegerForPath:path defaultValue:0];
}

- (NSUInteger)get_UnsignedIntegerForPath:(NSString *)path defaultValue:(NSUInteger)defaultValue
{
    NSArray *paths = [path componentsSeparatedByString:@"."];
    if (paths.count == 1) {
        return [self get_UnsignedIntegerForKey:paths.lastObject];
    } else if (paths.count >= 2) {
        NSDictionary *obj = [self get_DictionaryForPaths:paths];
        return [obj get_UnsignedIntegerForKey:paths.lastObject];
    }
    
    return defaultValue;
}

- (NSUInteger)get_UnsignedIntegerForPath:(NSString *)path
{
    return [self get_UnsignedIntegerForPath:path defaultValue:0];
}

- (char)get_CharForPath:(NSString *)path defaultValue:(char)defaultValue
{
    NSArray *paths = [path componentsSeparatedByString:@"."];
    if (paths.count == 1) {
        return [self get_CharForKey:paths.lastObject];
    } else if (paths.count >= 2) {
        NSDictionary *obj = [self get_DictionaryForPaths:paths];
        return [obj get_CharForKey:paths.lastObject];
    }
    
    return defaultValue;
}

- (char)get_CharForPath:(NSString *)path
{
    return [self get_CharForPath:path defaultValue:0];
}

- (unsigned char)get_UnsignedCharForPath:(NSString *)path defaultValue:(unsigned char)defaultValue
{
    NSArray *paths = [path componentsSeparatedByString:@"."];
    if (paths.count == 1) {
        return [self get_UnsignedCharForKey:paths.lastObject];
    } else if (paths.count >= 2) {
        NSDictionary *obj = [self get_DictionaryForPaths:paths];
        return [obj get_UnsignedCharForKey:paths.lastObject];
    }
    
    return defaultValue;
}

- (unsigned char)get_UnsignedCharForPath:(NSString *)path
{
    return [self get_UnsignedCharForPath:path defaultValue:0];
}

- (short)get_ShortForPath:(NSString *)path defaultValue:(short)defaultValue
{
    NSArray *paths = [path componentsSeparatedByString:@"."];
    if (paths.count == 1) {
        return [self get_ShortForKey:paths.lastObject];
    } else if (paths.count >= 2) {
        NSDictionary *obj = [self get_DictionaryForPaths:paths];
        return [obj get_ShortForKey:paths.lastObject];
    }
    
    return defaultValue;
}

- (short)get_ShortForPath:(NSString *)path
{
    return [self get_ShortForPath:path defaultValue:0];
}

- (unsigned short)get_UnsignedShortForPath:(NSString *)path defaultValue:(unsigned short)defaultValue
{
    NSArray *paths = [path componentsSeparatedByString:@"."];
    if (paths.count == 1) {
        return [self get_UnsignedShortForKey:paths.lastObject];
    } else if (paths.count >= 2) {
        NSDictionary *obj = [self get_DictionaryForPaths:paths];
        return [obj get_UnsignedShortForKey:paths.lastObject];
    }
    
    return defaultValue;
}

- (unsigned short)get_UnsignedShortForPath:(NSString *)path
{
    return [self get_UnsignedShortForPath:path defaultValue:0];
}

- (long)get_LongForPath:(NSString *)path defaultValue:(long)defaultValue
{
    NSArray *paths = [path componentsSeparatedByString:@"."];
    if (paths.count == 1) {
        return [self get_LongForKey:paths.lastObject];
    } else if (paths.count >= 2) {
        NSDictionary *obj = [self get_DictionaryForPaths:paths];
        return [obj get_LongForKey:paths.lastObject];
    }
    
    return defaultValue;
}

- (long)get_LongForPath:(NSString *)path
{
    return [self get_LongForPath:path defaultValue:0];
}

- (unsigned long)get_UnsignedLongForPath:(NSString *)path defaultValue:(unsigned long)defaultValue
{
    NSArray *paths = [path componentsSeparatedByString:@"."];
    if (paths.count == 1) {
        return [self get_UnsignedLongForKey:paths.lastObject];
    } else if (paths.count >= 2) {
        NSDictionary *obj = [self get_DictionaryForPaths:paths];
        return [obj get_UnsignedLongForKey:paths.lastObject];
    }
    
    return defaultValue;
}

- (unsigned long)get_UnsignedLongForPath:(NSString *)path
{
    return [self get_UnsignedLongForPath:path defaultValue:0];
}

- (long long)get_LongLongForPath:(NSString *)path defaultValue:(long long)defaultValue
{
    NSArray *paths = [path componentsSeparatedByString:@"."];
    if (paths.count == 1) {
        return [self get_LongLongForKey:paths.lastObject];
    } else if (paths.count >= 2) {
        NSDictionary *obj = [self get_DictionaryForPaths:paths];
        return [obj get_LongLongForKey:paths.lastObject];
    }
    
    return defaultValue;
}

- (long long)get_LongLongForPath:(NSString *)path
{
    return [self get_LongLongForPath:path defaultValue:0];
}

- (unsigned long long)get_UnsignedLongLongForPath:(NSString *)path defaultValue:(unsigned long long)defaultValue
{
    NSArray *paths = [path componentsSeparatedByString:@"."];
    if (paths.count == 1) {
        return [self get_LongLongForKey:paths.lastObject];
    } else if (paths.count >= 2) {
        NSDictionary *obj = [self get_DictionaryForPaths:paths];
        return [obj get_UnsignedLongLongForKey:paths.lastObject];
    }
    
    return defaultValue;
}

- (unsigned long long)get_UnsignedLongLongForPath:(NSString *)path
{
    return [self get_UnsignedLongLongForPath:path defaultValue:0];
}

- (int8_t)get_Int8ForPath:(NSString *)path
{
    return [self get_CharForPath:path];
}

- (int8_t)get_Int8ForPath:(NSString *)path defaultValue:(int8_t)defaultValue
{
    return [self get_CharForPath:path defaultValue:defaultValue];
}

- (uint8_t)get_UInt8ForPath:(NSString *)path
{
    return [self get_UnsignedCharForPath:path];
}

- (uint8_t)get_UInt8ForPath:(NSString *)path defaultValue:(uint8_t)defaultValue
{
    return [self get_UnsignedCharForPath:path defaultValue:defaultValue];
}

- (int16_t)get_Int16ForPath:(NSString *)path
{
    return [self get_ShortForPath:path];
}

- (int16_t)get_Int16ForPath:(NSString *)path defaultValue:(int16_t)defaultValue
{
    return [self get_ShortForPath:path defaultValue:defaultValue];
}

- (uint16_t)get_UInt16ForPath:(NSString *)path
{
    return [self get_UnsignedShortForPath:path];
}

- (uint16_t)get_UInt16ForPath:(NSString *)path defaultValue:(uint16_t)defaultValue
{
    return [self get_UnsignedShortForPath:path defaultValue:defaultValue];
}

- (int32_t)get_Int32ForPath:(NSString *)path
{
    return (int32_t)[self get_LongForPath:path];
}

- (int32_t)get_Int32ForPath:(NSString *)path defaultValue:(int32_t)defaultValue
{
    return (int32_t)[self get_LongForPath:path defaultValue:defaultValue];
}

- (uint32_t)get_UInt32ForPath:(NSString *)path
{
    return (uint32_t)[self get_UnsignedLongForPath:path];
}

- (uint32_t)get_UInt32ForPath:(NSString *)path defaultValue:(uint32_t)defaultValue
{
    return (uint32_t)[self get_UnsignedLongForPath:path defaultValue:defaultValue];
}

- (int64_t)get_Int64ForPath:(NSString *)path
{
    return [self get_LongLongForPath:path];
}

- (int64_t)get_Int64ForPath:(NSString *)path defaultValue:(int64_t)defaultValue
{
    return [self get_LongLongForPath:path defaultValue:defaultValue];
}

- (uint64_t)get_UInt64ForPath:(NSString *)path
{
    return [self get_UnsignedLongLongForPath:path];
}

- (uint64_t)get_UInt64ForPath:(NSString *)path defaultValue:(uint64_t)defaultValue
{
    return [self get_UnsignedLongLongForPath:path defaultValue:defaultValue];
}

- (float)get_FloatForPath:(NSString *)path
{
    return [self get_FloatForPath:path defaultValue:0];
}

- (float)get_FloatForPath:(NSString *)path defaultValue:(float)defaultValue
{
    NSArray *paths = [path componentsSeparatedByString:@"."];
    if (paths.count == 1) {
        return [self get_FloatForKey:paths.lastObject];
    } else if (paths.count >= 2) {
        NSDictionary *obj = [self get_DictionaryForPaths:paths];
        return [obj get_FloatForKey:paths.lastObject];
    }
    
    return defaultValue;
}

- (double)get_DoubleForPath:(NSString *)path
{
    return [self get_DoubleForPath:path defaultValue:0];
}

- (double)get_DoubleForPath:(NSString *)path defaultValue:(double)defaultValue
{
    NSArray *paths = [path componentsSeparatedByString:@"."];
    if (paths.count == 1) {
        return [self get_DoubleForKey:paths.lastObject];
    } else if (paths.count >= 2) {
        NSDictionary *obj = [self get_DictionaryForPaths:paths];
        return [obj get_DoubleForKey:paths.lastObject];
    }
    
    return defaultValue;
}

- (NSObject *)get_ObjectForPath:(NSString *)path defaultValue:(NSObject *)defaultValue
{
    NSArray *paths = [path componentsSeparatedByString:@"."];
    if (paths.count == 1) {
        return [self get_ObjectForKey:paths.lastObject];
    } else if (paths.count >= 2) {
        NSDictionary *obj = [self get_DictionaryForPaths:paths];
        return [obj get_ObjectForKey:paths.lastObject];
    }
    
    return defaultValue;
}

- (NSObject *)get_ObjectForPath:(NSString *)path
{
    return [self get_ObjectForPath:path defaultValue:nil];
}

- (NSString *)get_StringForPath:(NSString *)path defaultValue:(NSString *)defaultValue
{
    NSArray *paths = [path componentsSeparatedByString:@"."];
    if (paths.count == 1) {
        return [self get_StringForKey:paths.lastObject];
    } else if (paths.count >= 2) {
        NSDictionary *obj = [self get_DictionaryForPaths:paths];
        return [obj get_StringForKey:paths.lastObject];
    }
    
    return defaultValue;
}

- (NSString *)get_StringForPath:(NSString *)path
{
    return [self get_StringForPath:path defaultValue:nil];
}

- (NSArray *)get_ArrayForPath:(NSString *)path defaultValue:(NSArray *)defaultValue
{
    NSArray *paths = [path componentsSeparatedByString:@"."];
    if (paths.count == 1) {
        return [self get_ArrayForKey:paths.lastObject];
    } else if (paths.count >= 2) {
        NSDictionary *obj = [self get_DictionaryForPaths:paths];
        return [obj get_ArrayForKey:paths.lastObject];
    }
    
    return defaultValue;
}

- (NSArray *)get_ArrayForPath:(NSString *)path
{
    return [self get_ArrayForPath:path defaultValue:nil];
}

- (NSDictionary *)get_DictionaryForPath:(NSString *)path defaultValue:(NSDictionary *)defaultValue
{
    NSArray *paths = [path componentsSeparatedByString:@"."];
    if (paths.count == 1) {
        return [self get_DictionaryForKey:paths.lastObject];
    } else if (paths.count >= 2) {
        NSDictionary *obj = [self get_DictionaryForPaths:paths];
        return [obj get_DictionaryForKey:paths.lastObject];
    }
    
    return defaultValue;
}

- (NSDictionary *)get_DictionaryForPath:(NSString *)path
{
    return [self get_DictionaryForPath:path defaultValue:nil];
}

- (NSDate *)get_DateForPath:(NSString *)path defaultValue:(NSDate *)defaultValue {
    NSArray *paths = [path componentsSeparatedByString:@"."];
    if (paths.count == 1) {
        return [self get_DateForKey:paths.lastObject];
    } else if (paths.count >= 2) {
        NSDictionary *obj = [self get_DictionaryForPaths:paths];
        return [obj get_DateForKey:paths.lastObject];
    }
    
    return defaultValue;
}

- (NSDate *)get_DateForPath:(NSString *)path {
    return [self get_DateForPath:path defaultValue:nil];
}

- (NSData *)get_DataForPath:(NSString *)path defaultValue:(NSData *)defaultValue
{
    NSArray *paths = [path componentsSeparatedByString:@"."];
    if (paths.count == 1) {
        return [self get_DataForKey:paths.lastObject];
    } else if (paths.count >= 2) {
        NSDictionary *obj = [self get_DictionaryForPaths:paths];
        return [obj get_DataForKey:paths.lastObject];
    }
    
    return defaultValue;
}

- (NSData *)get_DataForPath:(NSString *)path
{
    return [self get_DataForPath:path defaultValue:nil];
}

- (NSURL *)get_URLForPath:(NSString *)path defaultValue:(NSURL *)defaultValue
{
    NSArray *paths = [path componentsSeparatedByString:@"."];
    if (paths.count == 1) {
        return [self get_URLForKey:paths.lastObject];
    } else if (paths.count >= 2) {
        NSDictionary *obj = [self get_DictionaryForPaths:paths];
        return [obj get_URLForKey:paths.lastObject];
    }
    
    return defaultValue;
}

- (NSURL *)get_URLForPath:(NSString *)path
{
    return [self get_URLForPath:path defaultValue:nil];
}

@end

//
//  NSDictionary+Values.h
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

#import <Foundation/Foundation.h>

/**
 * @brief Category methods to get values.
 *
 * USAGE:
 *   [dict get_IntegerForKey:@"value"]
 *     -> If the value was integer, it returns NSInteger value.
 *   [dict get_StringForKey:@"user.name"]
 *     -> You can get value from a nested dictionary.
 *        These methods are useful to get values from dictionary parsed JSON.
 */
@interface NSDictionary (Values)

#pragma mark - ForKey

- (BOOL)get_BoolForKey:(NSString *)key defaultValue:(BOOL)defaultValue;
- (BOOL)get_BoolForKey:(NSString *)key;
- (NSInteger)get_IntegerForKey:(NSString *)key defaultValue:(NSInteger)defaultValue;
- (NSInteger)get_IntegerForKey:(NSString *)key;
- (NSUInteger)get_UnsignedIntegerForKey:(NSString *)key defaultValue:(NSUInteger)defaultValue;
- (NSUInteger)get_UnsignedIntegerForKey:(NSString *)key;
- (char)get_CharForKey:(NSString *)key defaultValue:(char)defaultValue;
- (char)get_CharForKey:(NSString *)key;
- (unsigned char)get_UnsignedCharForKey:(NSString *)key defaultValue:(unsigned char)defaultValue;
- (unsigned char)get_UnsignedCharForKey:(NSString *)key;
- (short)get_ShortForKey:(NSString *)key defaultValue:(short)defaultValue;
- (short)get_ShortForKey:(NSString *)key;
- (unsigned short)get_UnsignedShortForKey:(NSString *)key defaultValue:(unsigned short)defaultValue;
- (unsigned short)get_UnsignedShortForKey:(NSString *)key;
- (long)get_LongForKey:(NSString *)key defaultValue:(long)defaultValue;
- (long)get_LongForKey:(NSString *)key;
- (unsigned long)get_UnsignedLongForKey:(NSString *)key defaultValue:(unsigned long)defaultValue;
- (unsigned long)get_UnsignedLongForKey:(NSString *)key;
- (long long)get_LongLongForKey:(NSString *)key defaultValue:(long long)defaultValue;
- (long long)get_LongLongForKey:(NSString *)key;
- (unsigned long long)get_UnsignedLongLongForKey:(NSString *)key defaultValue:(unsigned long long)defaultValue;
- (unsigned long long)get_UnsignedLongLongForKey:(NSString *)key;
- (int8_t)get_Int8ForKey:(NSString *)key defaultValue:(int8_t)defaultValue;
- (int8_t)get_Int8ForKey:(NSString *)key;
- (uint8_t)get_UInt8ForKey:(NSString *)key defaultValue:(uint8_t)defaultValue;
- (uint8_t)get_UInt8ForKey:(NSString *)key;
- (int16_t)get_Int16ForKey:(NSString *)key defaultValue:(int16_t)defaultValue;
- (int16_t)get_Int16ForKey:(NSString *)key;
- (uint16_t)get_UInt16ForKey:(NSString *)key defaultValue:(uint16_t)defaultValue;
- (uint16_t)get_UInt16ForKey:(NSString *)key;
- (int32_t)get_Int32ForKey:(NSString *)key defaultValue:(int32_t)defaultValue;
- (int32_t)get_Int32ForKey:(NSString *)key;
- (uint32_t)get_UInt32ForKey:(NSString *)key defaultValue:(uint32_t)defaultValue;
- (uint32_t)get_UInt32ForKey:(NSString *)key;
- (int64_t)get_Int64ForKey:(NSString *)key defaultValue:(int64_t)defaultValue;
- (int64_t)get_Int64ForKey:(NSString *)key;
- (uint64_t)get_UInt64ForKey:(NSString *)key defaultValue:(uint64_t)defaultValue;
- (uint64_t)get_UInt64ForKey:(NSString *)key;
- (float)get_FloatForKey:(NSString *)key defaultValue:(float)defaultValue;
- (float)get_FloatForKey:(NSString *)key;
- (double)get_DoubleForKey:(NSString *)key defaultValue:(double)defaultValue;
- (double)get_DoubleForKey:(NSString *)key;
- (NSTimeInterval)get_TimeIntervalForKey:(NSString *)key defaultValue:(NSTimeInterval)defaultValue;
- (NSTimeInterval)get_TimeIntervalForKey:(NSString *)key;
- (id)get_ObjectForKey:(NSString *)key defaultValue:(id)defaultValue;
- (id)get_ObjectForKey:(NSString *)key;
- (NSString *)get_StringForKey:(NSString *)key defaultValue:(NSString *)defaultValue;
- (NSString *)get_StringForKey:(NSString *)key;
- (NSArray *)get_ArrayForKey:(NSString *)key defaultValue:(NSArray *)defaultValue;
- (NSArray *)get_ArrayForKey:(NSString *)key;
- (NSDictionary *)get_DictionaryForKey:(NSString *)key defaultValue:(NSDictionary *)defaultValue;
- (NSDictionary *)get_DictionaryForKey:(NSString *)key;
- (NSDate *)get_DateForKey:(NSString *)key defaultValue:(NSDate *)defaultValue;
- (NSDate *)get_DateForKey:(NSString *)key;
- (NSData *)get_DataForKey:(NSString *)key defaultValue:(NSData *)defaultValue;
- (NSData *)get_DataForKey:(NSString *)key;
- (NSURL *)get_URLForKey:(NSString *)key defaultValue:(NSURL *)defaultValue;
- (NSURL *)get_URLForKey:(NSString *)key;

#pragma mark - ForPath

- (BOOL)get_BoolForPath:(NSString *)path defaultValue:(BOOL)defaultValue;
- (BOOL)get_BoolForPath:(NSString *)path;
- (NSInteger)get_IntegerForPath:(NSString *)path defaultValue:(NSInteger)defaultValue;
- (NSInteger)get_IntegerForPath:(NSString *)path;
- (NSUInteger)get_UnsignedIntegerForPath:(NSString *)path defaultValue:(NSUInteger)defaultValue;
- (NSUInteger)get_UnsignedIntegerForPath:(NSString *)path;
- (char)get_CharForPath:(NSString *)path defaultValue:(char)defaultValue;
- (char)get_CharForPath:(NSString *)path;
- (unsigned char)get_UnsignedCharForPath:(NSString *)path defaultValue:(unsigned char)defaultValue;
- (unsigned char)get_UnsignedCharForPath:(NSString *)path;
- (short)get_ShortForPath:(NSString *)path defaultValue:(short)defaultValue;
- (short)get_ShortForPath:(NSString *)path;
- (unsigned short)get_UnsignedShortForPath:(NSString *)path defaultValue:(unsigned short)defaultValue;
- (unsigned short)get_UnsignedShortForPath:(NSString *)path;
- (long)get_LongForPath:(NSString *)path defaultValue:(long)defaultValue;
- (long)get_LongForPath:(NSString *)path;
- (unsigned long)get_UnsignedLongForPath:(NSString *)path defaultValue:(unsigned long)defaultValue;
- (unsigned long)get_UnsignedLongForPath:(NSString *)path;
- (long long)get_LongLongForPath:(NSString *)path defaultValue:(long long)defaultValue;
- (long long)get_LongLongForPath:(NSString *)path;
- (unsigned long long)get_UnsignedLongLongForPath:(NSString *)path defaultValue:(unsigned long long)defaultValue;
- (unsigned long long)get_UnsignedLongLongForPath:(NSString *)path;
- (int8_t)get_Int8ForPath:(NSString *)path defaultValue:(int8_t)defaultValue;
- (int8_t)get_Int8ForPath:(NSString *)path;
- (uint8_t)get_UInt8ForPath:(NSString *)path defaultValue:(uint8_t)defaultValue;
- (uint8_t)get_UInt8ForPath:(NSString *)path;
- (int16_t)get_Int16ForPath:(NSString *)path defaultValue:(int16_t)defaultValue;
- (int16_t)get_Int16ForPath:(NSString *)path;
- (uint16_t)get_UInt16ForPath:(NSString *)path defaultValue:(uint16_t)defaultValue;
- (uint16_t)get_UInt16ForPath:(NSString *)path;
- (int32_t)get_Int32ForPath:(NSString *)path defaultValue:(int32_t)defaultValue;
- (int32_t)get_Int32ForPath:(NSString *)path;
- (uint32_t)get_UInt32ForPath:(NSString *)path defaultValue:(uint32_t)defaultValue;
- (uint32_t)get_UInt32ForPath:(NSString *)path;
- (int64_t)get_Int64ForPath:(NSString *)path defaultValue:(int64_t)defaultValue;
- (int64_t)get_Int64ForPath:(NSString *)path;
- (uint64_t)get_UInt64ForPath:(NSString *)path defaultValue:(uint64_t)defaultValue;
- (uint64_t)get_UInt64ForPath:(NSString *)path;
- (float)get_FloatForPath:(NSString *)path defaultValue:(float)defaultValue;
- (float)get_FloatForPath:(NSString *)path;
- (double)get_DoubleForPath:(NSString *)path defaultValue:(double)defaultValue;
- (double)get_DoubleForPath:(NSString *)path;
- (NSObject *)get_ObjectForPath:(NSString *)path defaultValue:(NSObject *)defaultValue;
- (NSObject *)get_ObjectForPath:(NSString *)path;
- (NSString *)get_StringForPath:(NSString *)path defaultValue:(NSString *)defaultValue;
- (NSString *)get_StringForPath:(NSString *)path;
- (NSArray *)get_ArrayForPath:(NSString *)path defaultValue:(NSArray *)defaultValue;
- (NSArray *)get_ArrayForPath:(NSString *)path;
- (NSDictionary *)get_DictionaryForPath:(NSString *)path defaultValue:(NSDictionary *)defaultValue;
- (NSDictionary *)get_DictionaryForPath:(NSString *)path;
- (NSDate *)get_DateForPath:(NSString *)path defaultValue:(NSDate *)defaultValue;
- (NSDate *)get_DateForPath:(NSString *)path;
- (NSData *)get_DataForPath:(NSString *)path defaultValue:(NSData *)defaultValue;
- (NSData *)get_DataForPath:(NSString *)path;
- (NSURL *)get_URLForPath:(NSString *)path defaultValue:(NSURL *)defaultValue;
- (NSURL *)get_URLForPath:(NSString *)path;

@end

// This file is generated and will be overwritten automatically.

#import <Foundation/Foundation.h>

/** Settings class provides non-persistent, in-process key-value storage. */
NS_SWIFT_NAME(Settings)
__attribute__((visibility ("default")))
@interface MBMSettings : NSObject

// This class provides custom init which should be called
- (nonnull instancetype)init NS_UNAVAILABLE;

// This class provides custom init which should be called
+ (nonnull instancetype)new NS_UNAVAILABLE;

/**
 * @brief Sets setting value for a specified key.
 *
 * @param key - Key
 * @param value - Value
 */
+ (void)setForKey:(nonnull NSString *)key
            value:(nonnull id)value;
/**
 * @brief Return value for provided key.
 *
 * @param key - Key
 *
 * @return Value if key is presented in settings otherwise - NullValue
 */
+ (nonnull id)getForKey:(nonnull NSString *)key __attribute((ns_returns_retained));

@end

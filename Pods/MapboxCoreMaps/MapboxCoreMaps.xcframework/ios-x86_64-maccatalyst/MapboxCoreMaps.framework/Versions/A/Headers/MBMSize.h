// This file is generated and will be overwritten automatically.

#import <Foundation/Foundation.h>

/** @brief Size type */
NS_SWIFT_NAME(Size)
__attribute__((visibility ("default")))
@interface MBMSize : NSObject

// This class provides custom init which should be called
- (nonnull instancetype)init NS_UNAVAILABLE;

// This class provides custom init which should be called
+ (nonnull instancetype)new NS_UNAVAILABLE;

- (nonnull instancetype)initWithWidth:(float)width
                               height:(float)height;

/** @brief width of the size */
@property (nonatomic, readonly) float width;

/** @brief height of the size */
@property (nonatomic, readonly) float height;


- (BOOL)isEqualToSize:(nonnull MBMSize *)other;

@end

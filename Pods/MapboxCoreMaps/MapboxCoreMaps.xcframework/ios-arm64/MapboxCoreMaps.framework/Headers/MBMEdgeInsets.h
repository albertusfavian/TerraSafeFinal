// This file is generated and will be overwritten automatically.

#import <Foundation/Foundation.h>

/**
 * @brief The distance on each side between rectangles, when one is contained into other.
 *
 * All fields' values are in \link MapOptions#size platform pixel \endlink units.
 */
NS_SWIFT_NAME(EdgeInsets)
__attribute__((visibility ("default")))
@interface MBMEdgeInsets : NSObject

// This class provides custom init which should be called
- (nonnull instancetype)init NS_UNAVAILABLE;

// This class provides custom init which should be called
+ (nonnull instancetype)new NS_UNAVAILABLE;

- (nonnull instancetype)initWithTop:(double)top
                               left:(double)left
                             bottom:(double)bottom
                              right:(double)right;

/** @brief Padding from the top. */
@property (nonatomic, readonly) double top;

/** @brief Padding from the left. */
@property (nonatomic, readonly) double left;

/** @brief Padding from the bottom. */
@property (nonatomic, readonly) double bottom;

/** @brief Padding from the right. */
@property (nonatomic, readonly) double right;


- (BOOL)isEqualToEdgeInsets:(nonnull MBMEdgeInsets *)other;

@end

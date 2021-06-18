// This file is generated and will be overwritten automatically.

#import <Foundation/Foundation.h>

/**
 * @brief A bezier curve that can be used e.g. in the easing functionality of animations
 * @sa easing
 */
NS_SWIFT_NAME(UnitBezier)
__attribute__((visibility ("default")))
@interface MBMUnitBezier : NSObject

// This class provides custom init which should be called
- (nonnull instancetype)init NS_UNAVAILABLE;

// This class provides custom init which should be called
+ (nonnull instancetype)new NS_UNAVAILABLE;

- (nonnull instancetype)initWithP1x:(double)p1x
                                p1y:(double)p1y
                                p2x:(double)p2x
                                p2y:(double)p2y;

/** @brief x value of point 1 of the bezier curve */
@property (nonatomic, readonly) double p1x;

/** @brief y value of point 1 of the bezier curve */
@property (nonatomic, readonly) double p1y;

/** @brief x value of point 2 of the bezier curve */
@property (nonatomic, readonly) double p2x;

/** @brief x value of point 2 of the bezier curve */
@property (nonatomic, readonly) double p2y;


@end

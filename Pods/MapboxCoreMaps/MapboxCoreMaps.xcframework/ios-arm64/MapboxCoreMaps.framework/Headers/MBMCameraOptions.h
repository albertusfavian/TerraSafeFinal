// This file is generated and will be overwritten automatically.

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@class MBMEdgeInsets;
@class MBMScreenCoordinate;

/**
 * @brief Various options for describing the viewpoint of a map. All fields are
 * optional.
 *
 * Anchor and center points are mutually exclusive, with preference for the
 * center point when both are set.
 */
NS_SWIFT_NAME(CameraOptions)
__attribute__((visibility ("default")))
@interface MBMCameraOptions : NSObject

// This class provides custom init which should be called
- (nonnull instancetype)init NS_UNAVAILABLE;

// This class provides custom init which should be called
+ (nonnull instancetype)new NS_UNAVAILABLE;

- (nonnull instancetype)initWithCenter:(nullable CLLocation *)center
                               padding:(nullable MBMEdgeInsets *)padding
                                anchor:(nullable MBMScreenCoordinate *)anchor
                                  zoom:(nullable NSNumber *)zoom
                               bearing:(nullable NSNumber *)bearing
                                 pitch:(nullable NSNumber *)pitch NS_REFINED_FOR_SWIFT;

/** @brief Coordinate at the center of the map. */
@property (nonatomic, readonly, nullable) CLLocation *center NS_REFINED_FOR_SWIFT;

/**
 * @brief Padding around the interior of the view that affects the frame of
 * reference for `center`.
 */
@property (nonatomic, readonly, nullable) MBMEdgeInsets *padding NS_REFINED_FOR_SWIFT;

/**
 * @brief Point of reference for `zoom` and `angle`, assuming an origin at the
 * top-left corner of the view.
 */
@property (nonatomic, readonly, nullable) MBMScreenCoordinate *anchor NS_REFINED_FOR_SWIFT;

/**
 * @brief Zero-based zoom level. Constrained to the minimum and maximum zoom
 * levels.
 */
@property (nonatomic, readonly, nullable) NSNumber *zoom NS_REFINED_FOR_SWIFT;

/** @brief Bearing, measured in degrees from true north. Wrapped to [0, 360). */
@property (nonatomic, readonly, nullable) NSNumber *bearing NS_REFINED_FOR_SWIFT;

/**
 * @brief Pitch toward the horizon measured in degrees , with 0 deg resulting in a
 * two-dimensional map.
 */
@property (nonatomic, readonly, nullable) NSNumber *pitch NS_REFINED_FOR_SWIFT;


@end

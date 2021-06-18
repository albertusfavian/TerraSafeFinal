// This file is generated and will be overwritten automatically.

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@class MBMEdgeInsets;

/** @brief Describes the viewpoint of the map. */
NS_SWIFT_NAME(CameraState)
__attribute__((visibility ("default")))
@interface MBMCameraState : NSObject

// This class provides custom init which should be called
- (nonnull instancetype)init NS_UNAVAILABLE;

// This class provides custom init which should be called
+ (nonnull instancetype)new NS_UNAVAILABLE;

- (nonnull instancetype)initWithCenter:(CLLocationCoordinate2D)center
                               padding:(nonnull MBMEdgeInsets *)padding
                                  zoom:(double)zoom
                               bearing:(double)bearing
                                 pitch:(double)pitch;

/** @brief Coordinate at the center of the map. */
@property (nonatomic, readonly) CLLocationCoordinate2D center;

/**
 * @brief Padding around the interior of the view that affects the frame of
 * reference for `center`.
 */
@property (nonatomic, readonly, nonnull) MBMEdgeInsets *padding;

/**
 * @brief Zero-based zoom level. Constrained to the minimum and maximum zoom
 * levels.
 */
@property (nonatomic, readonly) double zoom;

/** @brief Bearing, measured in degrees from true north. Wrapped to [0, 360). */
@property (nonatomic, readonly) double bearing;

/**
 * @brief Pitch toward the horizon measured in degrees , with 0 deg resulting in a
 * two-dimensional map.
 */
@property (nonatomic, readonly) double pitch;


@end

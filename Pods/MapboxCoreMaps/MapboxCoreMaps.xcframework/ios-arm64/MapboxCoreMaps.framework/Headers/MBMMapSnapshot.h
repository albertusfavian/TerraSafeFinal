// This file is generated and will be overwritten automatically.

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@class MBMImage;
@class MBMScreenCoordinate;

/** @brief An image snapshot of a map rendered by MapSnapshotter. */
NS_SWIFT_NAME(MapSnapshot)
__attribute__((visibility ("default")))
@interface MBMMapSnapshot : NSObject

// This class provides custom init which should be called
- (nonnull instancetype)init NS_UNAVAILABLE;

// This class provides custom init which should be called
+ (nonnull instancetype)new NS_UNAVAILABLE;

/**
 * @brief Calculate screen coordinate on the snapshot from geographical coordinate.
 *
 * @param coordinate Geographical coordinate.
 * @returns screen coordinate in \link MapOptions#size platform pixels \endlink on the snapshot for geographical coordinate.
 */
- (nonnull MBMScreenCoordinate *)screenCoordinateForCoordinate:(CLLocationCoordinate2D)coordinate __attribute((ns_returns_retained));
/**
 * @brief Calculate geographical coordinates from a point on the snapshot.
 *
 * @param screenCoordinate Screen coordinates on the snapshot in \link MapOptions#size platform pixels \endlink
 * @return Geographical coordinates for point on the snapshot.
 */
- (CLLocationCoordinate2D)coordinateForScreenCoordinate:(nonnull MBMScreenCoordinate *)screenCoordinate;
/**
 * @brief Get list of attributions for the sources in this snapshot.
 *
 * @returns list of attributions for the sources in this snapshot.
 */
- (nonnull NSArray<NSString *> *)attributions __attribute((ns_returns_retained));
/**
 * @brief Get the rendered snapshot image data.
 *
 * @returns rendered snapshot image data.
 */
- (nonnull MBMImage *)image __attribute((ns_returns_retained));

@end

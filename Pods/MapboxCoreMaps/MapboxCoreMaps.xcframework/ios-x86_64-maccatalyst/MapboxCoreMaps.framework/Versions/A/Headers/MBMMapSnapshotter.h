// This file is generated and will be overwritten automatically.

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <MapboxCoreMaps/MBMCameraManager.h>

@class MBMMapSnapshotOptions;
@class MBMSize;

/** @brief MapSnapshotter exposes functionality to capture static map images. */
NS_SWIFT_NAME(MapSnapshotter)
__attribute__((visibility ("default")))
@interface MBMMapSnapshotter : MBMCameraManager

// This class provides custom init which should be called
- (nonnull instancetype)init NS_UNAVAILABLE;

// This class provides custom init which should be called
+ (nonnull instancetype)new NS_UNAVAILABLE;

/**
 * @brief Construct a new snapshotter.
 *
 * @param options Options to configure the snapshotter.
 */
- (nonnull instancetype)initWithOptions:(nonnull MBMMapSnapshotOptions *)options;

/**
 * @brief Sets the size of the snapshot
 *
 * @param size The new size of the snapshot in \link MapOptions#size platform pixels \endlink
 */
- (void)setSizeForSize:(nonnull MBMSize *)size;
/**
 * @brief Gets the size of the snapshot
 *
 * @return Snapshot size in \link MapOptions#size platform pixels \endlink
 */
- (nonnull MBMSize *)getSize __attribute((ns_returns_retained));
/** @brief Returns TRUE if the snapshotter is in the tile mode. */
- (BOOL)isInTileMode;
/**
 * @brief Sets the snapshotter to the tile mode.
 *
 * In the tile mode, the snapshotter fetches the still image of a single tile.
 *
 * @param set Bool representing if the snapshotter is in the tile mode.
 */
- (void)setTileModeForSet:(BOOL)set;
/**
 * @brief Cancel the current snapshot operation.
 *
 * Cancel the current snapshot operation, if any. The callback passed to the start method
 * is called with error parameter set.
 */
- (void)cancel;
/**
 * @brief Get elevation for the given coordinate.
 * Note: Elevation is only available for the visible region on the screen.
 *
 * @param coordinate defined as longitude-latitude pair.
 *
 * @return Elevation (in meters) multiplied by current terrain exaggeration, or empty if elevation for the coordinate is not available.
 */
- (nullable NSNumber *)getElevationForCoordinate:(CLLocationCoordinate2D)coordinate __attribute((ns_returns_retained));

@end

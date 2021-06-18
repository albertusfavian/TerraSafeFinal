// This file is generated and will be overwritten automatically.

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <MapboxCoreMaps/MBMConstrainMode.h>
#import <MapboxCoreMaps/MBMMapDebugOptions.h>
#import <MapboxCoreMaps/MBMNorthOrientation.h>
#import <MapboxCoreMaps/MBMViewportMode.h>
@class MBXFeature;
#import <MapboxCoreMaps/MBMCameraManager.h>

@class MBMMapOptions;
@class MBMRenderedQueryOptions;
@class MBMResourceOptions;
@class MBMScreenBox;
@class MBMScreenCoordinate;
@class MBMSize;
@class MBMSourceQueryOptions;
@protocol MBMMapClient;

/**
 * @brief Map class provides map rendering functionality.
 *
 */
NS_SWIFT_NAME(Map)
__attribute__((visibility ("default")))
@interface MBMMap : MBMCameraManager

// This class provides custom init which should be called
- (nonnull instancetype)init NS_UNAVAILABLE;

// This class provides custom init which should be called
+ (nonnull instancetype)new NS_UNAVAILABLE;

/**
 * @brief Initializes the map object.
 *
 * @param client The map client of the map
 * @param mapOptions The map options that the map adheres to
 * @param resourceOptions The resource options that the map adheres to
 */
- (nonnull instancetype)initWithClient:(nonnull id<MBMMapClient>)client
                            mapOptions:(nonnull MBMMapOptions *)mapOptions
                       resourceOptions:(nonnull MBMResourceOptions *)resourceOptions;

/**
 * @brief Creates the infrastructure needed for rendering the map.
 * It should be called before any call to render(). Must be called on the render thread.
 */
- (void)createRenderer;
/**
 * @brief Destroys the infrastructure needed for rendering the map, releasing resources.
 * Must be called on the render thread.
 */
- (void)destroyRenderer;
/** @brief Renders the map */
- (void)render;
/**
 * @brief Sets the size of the map
 * @param size The new size of the map in \link MapOptions#size platform pixels \endlink
 */
- (void)setSizeForSize:(nonnull MBMSize *)size;
/**
 * @brief Gets the size of the map.
 *
 * @return size The size of the map in \link MapOptions#size platform pixels \endlink
 */
- (nonnull MBMSize *)getSize __attribute((ns_returns_retained));
/** @brief Triggers a repaint of the map */
- (void)triggerRepaint;
/**
 * @brief Tells the map rendering engine that there is currently a gesture in progress. This
 * affects how the map renders labels, as it will use different texture filters if a gesture
 * is ongoing.
 *
 * @param inProgress Bool representing if a gesture is in progress
 */
- (void)setGestureInProgressForInProgress:(BOOL)inProgress;
/** @brief Returns TRUE if a gesture is currently in progress. */
- (BOOL)isGestureInProgress;
/**
 * @brief Tells the map rendering engine that the animation is currently performed by the
 * user (e.g. with a `jumpTo()` calls series). It adjusts the engine for the animation use case.
 * In particular, it brings more stability to symbol placement and rendering.
 *
 * @param inProgress Bool representing if user animation is in progress
 */
- (void)setUserAnimationInProgressForInProgress:(BOOL)inProgress;
/** @brief Returns TRUE if user animation is currently in progress. */
- (BOOL)isUserAnimationInProgress;
/**
 * @brief When loading a map, if `PrefetchZoomDelta` is set to any number greater than 0,
 * the map will first request a tile at zoom level lower than `zoom - delta`, with requested
 * zoom level a multiple of `delta`, in an attempt to display a full map at lower resolution as quick as possible.
 *
 * @param delta The new prefetch zoom delta
 */
- (void)setPrefetchZoomDeltaForDelta:(uint8_t)delta;
/** @brief Returns the map's prefetch zoom delta. */
- (uint8_t)getPrefetchZoomDelta;
/** @brief Sets the north orientation mode. */
- (void)setNorthOrientationForOrientation:(MBMNorthOrientation)orientation;
/** @brief Sets the map constrain mode. */
- (void)setConstrainModeForMode:(MBMConstrainMode)mode;
/** @brief Sets the viewport mode. */
- (void)setViewportModeForMode:(MBMViewportMode)mode;
/** @brief Returns the map's options */
- (nonnull MBMMapOptions *)getMapOptions __attribute((ns_returns_retained));
/** @brief Returns the map's debug options. */
- (nonnull NSArray<NSNumber *> *)getDebug __attribute((ns_returns_retained));
/** @brief Sets the map's debug options and enables debug mode based on the passed value. */
- (void)setDebugForDebugOptions:(nonnull NSArray<NSNumber *> *)debugOptions
                          value:(BOOL)value;
/**
 * @brief Returns true when the map is completely rendered, false otherwise. A partially
 * rendered map ranges from nothing rendered at all to only labels missing.
 */
- (BOOL)isMapLoaded;
/**
 * @brief Updates the state map of a feature within a style source.
 *
 * Update entries in the state map of a given feature within a style source. Only entries listed in the
 * \p state map will be updated. An entry in the feature state map that is not listed in \p state will
 * retain its previous value.
 *
 * Note that updates to feature state are asynchronous, so changes made by this method migth not be
 * immediately visible using getStateFeature().
 *
 * @param sourceId Style source identifier.
 * @param sourceLayerId Style source layer identifier (for multi-layer sources such as vector sources).
 * @param featureId Identifier of the feature whose state should be updated.
 * @param state Map of entries to update with their respective new values.
 */
- (void)setFeatureStateForSourceId:(nonnull NSString *)sourceId
                     sourceLayerId:(nullable NSString *)sourceLayerId
                         featureId:(nonnull NSString *)featureId
                             state:(nonnull id)state;
/**
 * @brief Removes entries from a feature state map.
 *
 * Remove a specified entry or all entries from a feature's state map, depending on the value of
 * \p stateKey.
 *
 * Note that updates to feature state are asynchronous, so changes made by this method migth not be
 * immediately visible using getStateFeature().
 *
 * @param sourceId Style source identifier.
 * @param sourceLayerId Style source layer identifier (for multi-layer sources such as vector sources).
 * @param featureId Identifier of the feature whose state should be removed.
 * @param stateKey Key of the entry to remove. If empty, the entire state is removed.
 */
- (void)removeFeatureStateForSourceId:(nonnull NSString *)sourceId
                        sourceLayerId:(nullable NSString *)sourceLayerId
                            featureId:(nonnull NSString *)featureId
                             stateKey:(nullable NSString *)stateKey;
/** @brief Reduces memory use. Useful to call when the application gets paused or sent to background. */
- (void)reduceMemoryUse;
/**
 * @brief Gets the resource options for the map.
 *
 * All optional fields of the retuned object are initialized with the actual values.
 *
 * Note that result of this method is different from the ResourceOptions that were provided to the map's constructor.
 *
 * @return ResourceOptions for the map.
 */
- (nonnull MBMResourceOptions *)getResourceOptions __attribute((ns_returns_retained));
/**
 * @brief Gets elevation for the given coordinate.
 * Note: Elevation is only available for the visible region on the screen.
 *
 * @param coordinate defined as longitude-latitude pair.
 *
 * @return Elevation (in meters) multiplied by current terrain exaggeration, or empty if elevation for the coordinate is not available.
 */
- (nullable NSNumber *)getElevationForCoordinate:(CLLocationCoordinate2D)coordinate __attribute((ns_returns_retained));

@end

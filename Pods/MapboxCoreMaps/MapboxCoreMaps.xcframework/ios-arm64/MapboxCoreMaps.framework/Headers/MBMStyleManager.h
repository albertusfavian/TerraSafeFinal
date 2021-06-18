// This file is generated and will be overwritten automatically.

#import <Foundation/Foundation.h>
@class MBXExpected;
@class MBXFeature;
#import <MapboxCoreMaps/MBMObservable.h>

@class MBMCameraOptions;
@class MBMCanonicalTileID;
@class MBMCoordinateBounds;
@class MBMCustomGeometrySourceOptions;
@class MBMImage;
@class MBMImageContent;
@class MBMImageStretches;
@class MBMLayerPosition;
@class MBMStyleObjectInfo;
@class MBMStylePropertyValue;
@class MBMTransitionOptions;
@protocol MBMCustomLayerHost;

NS_SWIFT_NAME(StyleManager)
__attribute__((visibility ("default")))
@interface MBMStyleManager : MBMObservable

/**
 * @brief Get the URI of the current Mapbox Style in use.
 *
 * @return A string containing a Mapbox style URI.
 */
- (nonnull NSString *)getStyleURI __attribute((ns_returns_retained));
/**
 * @brief Load style from provided URI.
 *
 * This is an asynchronious call. In order to get result of this operation please use @see MapObserver#onMapChanged
 * or @see MapObserver#onMapLoadError. In case of successful style load you should get @see MapChange#DidFullyLoadStyle.
 * And in case of error @see MapLoadError#StyleLoadError will be generated.
 *
 * \attention This method should be called on the same thread where @see Map object is initialized.
 *
 * @param uri URI where the style should be loaded from.
 */
- (void)setStyleURIForUri:(nonnull NSString *)uri;
/**
 * @brief Get the JSON serialization string of the current Mapbox Style in use.
 *
 * @return A JSON string containing a serialized Mapbox Style.
 */
- (nonnull NSString *)getStyleJSON __attribute((ns_returns_retained));
/**
 * @brief Load the style from a provided JSON string.
 *
 * \attention This method should be called on the same thread where @see Map object is initialized.
 *
 * @param json A JSON string containing a serialized Mapbox Style.
 */
- (void)setStyleJSONForJson:(nonnull NSString *)json;
/**
 * @brief Returns the map style's default camera, if any, or a default camera otherwise.
 * The map style default camera is defined as follows:
 * - center: https://docs.mapbox.com/mapbox-gl-js/style-spec/#root-center
 * - zoom: https://docs.mapbox.com/mapbox-gl-js/style-spec/#root-zoom
 * - bearing: https://docs.mapbox.com/mapbox-gl-js/style-spec/#root-bearing
 * - pitch: https://docs.mapbox.com/mapbox-gl-js/style-spec/#root-pitch
 *
 * The style default camera is re-evaluated when a new style is loaded.
 *
 * @return Returns the map style default camera.
 */
- (nonnull MBMCameraOptions *)getStyleDefaultCamera __attribute((ns_returns_retained));
/**
 * @brief Returns the map style's transition options. By default, the style parser will attempt
 * to read the style default transition options, if any, fallbacking to an immediate transition
 * otherwise. Transition options can be overriden via setStyleTransition, but the options are
 * reset once a new style has been loaded.
 *
 * The style transition is re-evaluated when a new style is loaded.
 *
 * @return Returns the map style transition options.
 */
- (nonnull MBMTransitionOptions *)getStyleTransition __attribute((ns_returns_retained));
/**
 * @brief Overrides the map style's transition options with user-provided options.
 *
 * The style transition is re-evaluated when a new style is loaded.
 *
 * @param transitionOptions Map style transition options.
 */
- (void)setStyleTransitionForTransitionOptions:(nonnull MBMTransitionOptions *)transitionOptions;
/**
 * @brief Checks whether a given style layer exists.
 *
 * Runtime style layers are valid until they are either removed or a new style is loaded.
 *
 * @param layerId Style layer identifier.
 *
 * @return True if the given style layer exists, false otherwise.
 */
- (BOOL)styleLayerExistsForLayerId:(nonnull NSString *)layerId;
/**
 * @brief Returns the existing style layers.
 *
 * @return The list containing the information about existing style layer objects.
 */
- (nonnull NSArray<MBMStyleObjectInfo *> *)getStyleLayers __attribute((ns_returns_retained));
/**
 * @brief Gets the value of style layer \p property.
 *
 * @param layerId Style layer identified.
 * @param property Style layer property name.
 * @return The value of \p property in the layer with \p layerId.
 */
- (nonnull MBMStylePropertyValue *)getStyleLayerPropertyForLayerId:(nonnull NSString *)layerId
                                                          property:(nonnull NSString *)property __attribute((ns_returns_retained));
/**
 * @brief Gets the default value of style layer \p property.
 *
 * @param layerType Style layer type.
 * @param property Style layer property name.
 * @return The default value of \p property for the layers with type \p layerType.
 */
+ (nonnull MBMStylePropertyValue *)getStyleLayerPropertyDefaultValueForLayerType:(nonnull NSString *)layerType
                                                                        property:(nonnull NSString *)property __attribute((ns_returns_retained));
/**
 * @brief Gets the value of style source \p property.
 *
 * @param sourceId Style source identified.
 * @param property Style source property name.
 * @return The value of \p property in the source with \p sourceId.
 */
- (nonnull MBMStylePropertyValue *)getStyleSourcePropertyForSourceId:(nonnull NSString *)sourceId
                                                            property:(nonnull NSString *)property __attribute((ns_returns_retained));
/**
 * @brief Gets the default value of style source \p property.
 *
 * @param sourceType Style source type.
 * @param property Style source property name.
 * @return The default value of \p property for the sources with type \p sourceType.
 */
+ (nonnull MBMStylePropertyValue *)getStyleSourcePropertyDefaultValueForSourceType:(nonnull NSString *)sourceType
                                                                          property:(nonnull NSString *)property __attribute((ns_returns_retained));
/**
 * @brief Checks whether a given style source exists.
 *
 * @param sourceId Style source identifier.
 *
 * @return True if the given source exists, false otherwise.
 */
- (BOOL)styleSourceExistsForSourceId:(nonnull NSString *)sourceId;
/**
 * @brief Returns the existing style sources.
 *
 * @return The list containing the information about existing style source objects.
 */
- (nonnull NSArray<MBMStyleObjectInfo *> *)getStyleSources __attribute((ns_returns_retained));
/**
 * @brief Gets the value of a style light \a property.
 *
 * @param property Style light property name.
 * @return Style light property value.
 */
- (nonnull MBMStylePropertyValue *)getStyleLightPropertyForProperty:(nonnull NSString *)property __attribute((ns_returns_retained));
/**
 * @brief Gets the value of a style terrain \a property.
 *
 * @param property Style terrain property name.
 * @return Style terrain property value.
 */
- (nonnull MBMStylePropertyValue *)getStyleTerrainPropertyForProperty:(nonnull NSString *)property __attribute((ns_returns_retained));
/**
 * @brief Get an image from the style.
 *
 * @param imageId ID of the image.
 *
 * @return Image data associated with the given ID, or empty if no image is
 * associated with that ID.
 */
- (nullable MBMImage *)getStyleImageForImageId:(nonnull NSString *)imageId __attribute((ns_returns_retained));
/**
 * @brief Check if the style is completely loaded.
 *
 * @return TRUE if and only if the style JSON contents, the style specified sprite and sources are all loaded, otherwise returns FALSE.
 */
- (BOOL)isStyleLoaded;

@end

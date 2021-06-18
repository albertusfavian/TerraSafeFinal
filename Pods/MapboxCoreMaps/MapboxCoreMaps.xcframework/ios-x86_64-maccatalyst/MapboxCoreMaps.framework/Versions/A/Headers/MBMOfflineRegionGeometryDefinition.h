// This file is generated and will be overwritten automatically.

#import <Foundation/Foundation.h>
#import <MapboxCoreMaps/MBMGlyphsRasterizationMode.h>
@class MBXGeometry;

/**
 * @brief An offline region definition is a geographic region defined by a style URL,
 * a geometry, zoom range, and device pixel ratio. Both minZoom and maxZoom must be ≥ 0,
 * and maxZoom must be ≥ minZoom. maxZoom may be ∞, in which case for each tile source,
 * the region will include tiles from minZoom up to the maximum zoom level provided by that source.
 * pixelRatio must be ≥ 0 and should typically be 1.0 or 2.0.
 */
NS_SWIFT_NAME(OfflineRegionGeometryDefinition)
__attribute__((visibility ("default")))
@interface MBMOfflineRegionGeometryDefinition : NSObject

// This class provides custom init which should be called
- (nonnull instancetype)init NS_UNAVAILABLE;

// This class provides custom init which should be called
+ (nonnull instancetype)new NS_UNAVAILABLE;

- (nonnull instancetype)initWithStyleURL:(nonnull NSString *)styleURL
                                geometry:(nonnull MBXGeometry *)geometry
                                 minZoom:(double)minZoom
                                 maxZoom:(double)maxZoom
                              pixelRatio:(float)pixelRatio
                 glyphsRasterizationMode:(MBMGlyphsRasterizationMode)glyphsRasterizationMode;

/** @brief The style associated with the offline region */
@property (nonatomic, readonly, nonnull, copy) NSString *styleURL;

/** @brief The geometry that defines the boundary of the offline region */
@property (nonatomic, readonly, nonnull) MBXGeometry *geometry;

/** @brief Minimum zoom level for the offline region */
@property (nonatomic, readonly) double minZoom;

/** @brief Maximum zoom level for the offline region */
@property (nonatomic, readonly) double maxZoom;

/** @brief Pixel ratio to be accounted for when downloading assets */
@property (nonatomic, readonly) float pixelRatio;

/** @brief Specifies glyphs rasterization mode. It defines which glyphs will be loaded from the server */
@property (nonatomic, readonly) MBMGlyphsRasterizationMode glyphsRasterizationMode;


@end

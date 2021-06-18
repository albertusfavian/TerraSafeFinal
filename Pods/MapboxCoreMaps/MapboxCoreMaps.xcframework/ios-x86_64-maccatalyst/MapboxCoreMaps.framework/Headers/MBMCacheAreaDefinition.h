// This file is generated and will be overwritten automatically.

#import <Foundation/Foundation.h>
#import <MapboxCoreMaps/MBMGlyphsRasterizationMode.h>

@class MBMCoordinateBoundsZoom;

/**
 * @brief A cache area definition is a geographic region defined by a style URL,
 * locations at a certain zoom level and device pixel ratio.
 */
NS_SWIFT_NAME(CacheAreaDefinition)
__attribute__((visibility ("default")))
@interface MBMCacheAreaDefinition : NSObject

// This class provides custom init which should be called
- (nonnull instancetype)init NS_UNAVAILABLE;

// This class provides custom init which should be called
+ (nonnull instancetype)new NS_UNAVAILABLE;

- (nonnull instancetype)initWithStyleURI:(nonnull NSString *)styleURI
                               locations:(nonnull NSArray<MBMCoordinateBoundsZoom *> *)locations
                 glyphsRasterizationMode:(MBMGlyphsRasterizationMode)glyphsRasterizationMode;

- (nonnull instancetype)initWithStyleURI:(nonnull NSString *)styleURI
                               locations:(nonnull NSArray<MBMCoordinateBoundsZoom *> *)locations
                              pixelRatio:(float)pixelRatio
                 glyphsRasterizationMode:(MBMGlyphsRasterizationMode)glyphsRasterizationMode;

/** @brief The style associated with the offline region */
@property (nonatomic, readonly, nonnull, copy) NSString *styleURI;

/** @brief Map areas to be fetched */
@property (nonatomic, readonly, nonnull, copy) NSArray<MBMCoordinateBoundsZoom *> *locations;

/** @brief Pixel ratio to be accounted for when downloading assets */
@property (nonatomic, readonly) float pixelRatio;

/** @brief Specifies glyphs rasterization mode. It defines which glyphs will be loaded from the server */
@property (nonatomic, readonly) MBMGlyphsRasterizationMode glyphsRasterizationMode;


@end

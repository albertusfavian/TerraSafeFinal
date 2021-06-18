// This file is generated and will be overwritten automatically.

#import <Foundation/Foundation.h>
#import <MapboxCoreMaps/MBMGlyphsRasterizationMode.h>

/** @brief Describes the glyphs rasterization option values. */
NS_SWIFT_NAME(GlyphsRasterizationOptions)
__attribute__((visibility ("default")))
@interface MBMGlyphsRasterizationOptions : NSObject

// This class provides custom init which should be called
- (nonnull instancetype)init NS_UNAVAILABLE;

// This class provides custom init which should be called
+ (nonnull instancetype)new NS_UNAVAILABLE;

- (nonnull instancetype)initWithRasterizationMode:(MBMGlyphsRasterizationMode)rasterizationMode
                                       fontFamily:(nullable NSString *)fontFamily;

/** @brief Glyphs rasterization mode for client-side text rendering. */
@property (nonatomic, readonly) MBMGlyphsRasterizationMode rasterizationMode;

/**
 * @brief Font family to use as font fallback for client-side text renderings.
 *
 * Note: If local glyphs rasterization is enabled by setting \link GlyphsRasterizationMode \endlink with mode
 * "AllGlyphsRasterizedLocally" or "IdeographsRasterizedLocally", then the font family is required. Otherwise,
 * the map will fall back to use "NoGlyphsRasterizedLocally" mode.
 * Besides, if the font family is provided along with "NoGlyphsRasterizedLocally" mode, the map will then fall
 * back to use "IdeographsRasterizedLocally" mode.
 *
 */
@property (nonatomic, readonly, nullable, copy) NSString *fontFamily;


@end

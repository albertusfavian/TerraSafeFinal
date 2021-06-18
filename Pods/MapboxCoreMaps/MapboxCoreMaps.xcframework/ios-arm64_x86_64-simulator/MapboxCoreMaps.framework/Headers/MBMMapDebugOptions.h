// This file is generated and will be overwritten automatically.

#import <Foundation/Foundation.h>

/** @brief Options for enabling debugging features in a map. */
// NOLINTNEXTLINE(modernize-use-using)
typedef NS_CLOSED_ENUM(NSInteger, MBMMapDebugOptions)
{
    /**
     * @brief Edges of tile boundaries are shown as thick, red lines to help diagnose
     * tile clipping issues.
     */
    MBMMapDebugOptionsTileBorders,
    /** @brief Each tile shows its tile coordinate (x/y/z) in the upper-left corner. */
    MBMMapDebugOptionsParseStatus,
    /** @brief Each tile shows a timestamp indicating when it was loaded. */
    MBMMapDebugOptionsTimestamps,
    /**
     * @brief Edges of glyphs and symbols are shown as faint, green lines to help
     * diagnose collision and label placement issues.
     */
    MBMMapDebugOptionsCollision,
    /**
     * @brief Each drawing operation is replaced by a translucent fill. Overlapping
     * drawing operations appear more prominent to help diagnose overdrawing.
     */
    MBMMapDebugOptionsOverdraw,
    /** @brief The stencil buffer is shown instead of the color buffer. */
    MBMMapDebugOptionsStencilClip,
    /** @brief The depth buffer is shown instead of the color buffer. */
    MBMMapDebugOptionsDepthBuffer
} NS_SWIFT_NAME(MapDebugOptions);

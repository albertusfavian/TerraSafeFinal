// This file is generated and will be overwritten automatically.

#import <Foundation/Foundation.h>

/**
 * @brief Describes whether to constrain the map in both axes or only
 *        vertically e.g. while panning.
 */
// NOLINTNEXTLINE(modernize-use-using)
typedef NS_CLOSED_ENUM(NSInteger, MBMConstrainMode)
{
    /** @brief No constrains. */
    MBMConstrainModeNone,
    /** @brief Constrain to height only */
    MBMConstrainModeHeightOnly,
    /** @brief Constrain both width and height axes. */
    MBMConstrainModeWidthAndHeight
} NS_SWIFT_NAME(ConstrainMode);

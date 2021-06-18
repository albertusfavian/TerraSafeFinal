// This file is generated and will be overwritten automatically.

#import <Foundation/Foundation.h>

/** @brief Describe different kinds of style property values. */
// NOLINTNEXTLINE(modernize-use-using)
typedef NS_CLOSED_ENUM(NSInteger, MBMStylePropertyValueKind)
{
    /** Property value is not defined. */
    MBMStylePropertyValueKindUndefined,
    /** Property value is constant. */
    MBMStylePropertyValueKindConstant,
    /**
     * Property value is a style expression.
     *
     * \sa https://docs.mapbox.com/mapbox-gl-js/style-spec/#expressions
     */
    MBMStylePropertyValueKindExpression,
    /**
     * Property value is a style transition.
     *
     * \sa https://docs.mapbox.com/mapbox-gl-js/style-spec/#transition
     */
    MBMStylePropertyValueKindTransition
} NS_SWIFT_NAME(StylePropertyValueKind);

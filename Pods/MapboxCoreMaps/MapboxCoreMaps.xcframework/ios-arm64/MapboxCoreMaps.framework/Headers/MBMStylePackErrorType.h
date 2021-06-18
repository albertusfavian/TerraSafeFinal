// This file is generated and will be overwritten automatically.

#import <Foundation/Foundation.h>

/** @brief Describes the reason for a style package download request failure. */
// NOLINTNEXTLINE(modernize-use-using)
typedef NS_CLOSED_ENUM(NSInteger, MBMStylePackErrorType)
{
    /** @brief The operation was canceled. */
    MBMStylePackErrorTypeCanceled,
    /** @brief style package does not exist. */
    MBMStylePackErrorTypeDoesNotExist,
    /** @brief There is no available space to store the resources */
    MBMStylePackErrorTypeDiskFull,
    /** @brief Other reason. */
    MBMStylePackErrorTypeOther
} NS_SWIFT_NAME(StylePackErrorType);

NSString* MBMStylePackErrorTypeToString(MBMStylePackErrorType style_pack_error_type);

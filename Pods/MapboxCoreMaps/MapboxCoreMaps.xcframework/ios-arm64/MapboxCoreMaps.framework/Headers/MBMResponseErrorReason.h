// This file is generated and will be overwritten automatically.

#import <Foundation/Foundation.h>

/** @brief Describes the reason for an offline request response error. */
// NOLINTNEXTLINE(modernize-use-using)
typedef NS_CLOSED_ENUM(NSInteger, MBMResponseErrorReason)
{
    /** @brief The resource is not Found. */
    MBMResponseErrorReasonNotFound,
    /** @brief The server error. */
    MBMResponseErrorReasonServer,
    /** @brief The connection error. */
    MBMResponseErrorReasonConnection,
    /** @brief The error happened because of a rate limit. */
    MBMResponseErrorReasonRateLimit,
    /** @brief Other reason. */
    MBMResponseErrorReasonOther
} NS_SWIFT_NAME(ResponseErrorReason);

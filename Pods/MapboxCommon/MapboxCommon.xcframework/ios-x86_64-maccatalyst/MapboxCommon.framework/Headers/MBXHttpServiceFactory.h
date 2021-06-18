// This file is generated and will be overwritten automatically.

#import <Foundation/Foundation.h>

@protocol MBXHttpServiceInterface;

/**
 * HTTP service factory.
 *
 * This class is used to get a pointer/reference to HTTP service platform implementation.
 * In order to set a custom implementation, the client must call `setUserDefined()` method once before any actual HTTP service is required.
 */
NS_SWIFT_NAME(HttpServiceFactory)
__attribute__((visibility ("default")))
@interface MBXHttpServiceFactory : NSObject

// This class provides custom init which should be called
- (nonnull instancetype)init NS_UNAVAILABLE;

// This class provides custom init which should be called
+ (nonnull instancetype)new NS_UNAVAILABLE;

/** This method allows to set user defined HTTP service. */
+ (void)setUserDefinedForCustom:(nonnull id<MBXHttpServiceInterface>)custom;

@end

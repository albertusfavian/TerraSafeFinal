// This file is generated and will be overwritten automatically.

#import <Foundation/Foundation.h>

@class MBMCacheAreaDefinition;
@class MBMResourceOptions;
@class MBXCancelable;

/**
 * @brief Interface for managing the device cache.
 *
 * The methods can be used to manage the ambient cache.
 *
 */
NS_SWIFT_NAME(CacheManager)
__attribute__((visibility ("default")))
@interface MBMCacheManager : NSObject

// This class provides custom init which should be called
- (nonnull instancetype)init NS_UNAVAILABLE;

// This class provides custom init which should be called
+ (nonnull instancetype)new NS_UNAVAILABLE;

/**
 * @brief Construct a new cache manager.
 *
 * @param options Resource fetching options to be used by the cache manager.
 */
- (nonnull instancetype)initWithOptions:(nonnull MBMResourceOptions *)options;

/**
 * @brief Inserts the provided resource into the ambient cache.
 *
 * This method mimics the caching that would take place if the equivalent
 * resource were requested in the process of map rendering. Use this method
 * to preload the cache with resources you know will be requested.
 *
 * This method is asynchronous; the data may not be immediately available for
 * in-progress requests, though subsequent requests should have access to the
 * cached data.
 *
 * @param url The URL at which the data can normally be found.
 * @param data Response data to store for this resource. The data is expected to be uncompressed;
 * internally, the cache will compress data as necessary.
 * @param modified The date the resource was last modified.
 * @param expires The date after which the resource is no longer valid.
 * @param httpEntityTag An HTTP entity tag.
 * @param mustRevalidate A Boolean value indicating whether the data is still usable past the expiration date.
 */
- (void)insertIntoAmbientCacheForUrl:(nonnull NSString *)url
                                data:(nonnull NSString *)data
                            modified:(nullable NSDate *)modified
                             expires:(nullable NSDate *)expires
                       httpEntityTag:(nullable NSString *)httpEntityTag
                      mustRevalidate:(BOOL)mustRevalidate;

@end

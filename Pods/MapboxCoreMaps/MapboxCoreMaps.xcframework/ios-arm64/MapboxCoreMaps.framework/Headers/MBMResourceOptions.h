// This file is generated and will be overwritten automatically.

#import <Foundation/Foundation.h>
#import <MapboxCoreMaps/MBMTileStoreUsageMode.h>

@class MBXTileStore;

/** @brief Options to configure a resource */
NS_SWIFT_NAME(ResourceOptions)
__attribute__((visibility ("default")))
@interface MBMResourceOptions : NSObject

// This class provides custom init which should be called
- (nonnull instancetype)init NS_UNAVAILABLE;

// This class provides custom init which should be called
+ (nonnull instancetype)new NS_UNAVAILABLE;

- (nonnull instancetype)initWithAccessToken:(nonnull NSString *)accessToken
                                    baseURL:(nullable NSString *)baseURL
                                  cachePath:(nullable NSString *)cachePath
                                  assetPath:(nullable NSString *)assetPath
                                  cacheSize:(nullable NSNumber *)cacheSize
                                  tileStore:(nullable MBXTileStore *)tileStore NS_REFINED_FOR_SWIFT;

- (nonnull instancetype)initWithAccessToken:(nonnull NSString *)accessToken
                                    baseURL:(nullable NSString *)baseURL
                                  cachePath:(nullable NSString *)cachePath
                                  assetPath:(nullable NSString *)assetPath
                                  cacheSize:(nullable NSNumber *)cacheSize
                                  tileStore:(nullable MBXTileStore *)tileStore
                         tileStoreUsageMode:(MBMTileStoreUsageMode)tileStoreUsageMode NS_REFINED_FOR_SWIFT;

/** @brief the access token to access the resource */
@property (nonatomic, readonly, nonnull, copy) NSString *accessToken;

/** @brief the base URL */
@property (nonatomic, readonly, nullable, copy) NSString *baseURL;

/** @brief the path to the cache */
@property (nonatomic, readonly, nullable, copy) NSString *cachePath;

/** @brief the path to the assets */
@property (nonatomic, readonly, nullable, copy) NSString *assetPath;

/** @brief the size of the cache in bytes */
@property (nonatomic, readonly, nullable) NSNumber *cacheSize NS_REFINED_FOR_SWIFT;

/**
 * @brief the tile store instance
 *
 * This setting can be applied only if tile store usage is enabled,
 * otherwise it is ignored.
 *
 * If not set and tile store usage is enabled, a tile store at the default
 * location will be created and used.
 */
@property (nonatomic, readonly, nullable) MBXTileStore *tileStore;

/** @brief tile store usage mode. */
@property (nonatomic, readonly) MBMTileStoreUsageMode tileStoreUsageMode;


@end

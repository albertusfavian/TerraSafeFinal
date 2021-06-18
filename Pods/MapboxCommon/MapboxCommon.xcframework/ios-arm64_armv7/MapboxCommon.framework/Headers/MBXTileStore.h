// This file is generated and will be overwritten automatically.

#import <Foundation/Foundation.h>
#import <MapboxCommon/MBXTileDataDomain.h>
#import <MapboxCommon/MBXTileRegionLoadProgressCallback.h>

@class MBXCancelable;
@class MBXTileRegionLoadOptions;
@class MBXTilesetDescriptor;

/**
 * TileStore manages downloads and storage for requests to tile-related API endpoints, enforcing a disk usage
 * quota: tiles available on disk may be deleted to make room for a new download. This interface can be used by an
 * app developer to set the disk quota. The rest of TileStore API is intended for native SDK consumption only.
 */
NS_SWIFT_NAME(TileStore)
__attribute__((visibility ("default")))
@interface MBXTileStore : NSObject

// This class provides custom init which should be called
- (nonnull instancetype)init NS_UNAVAILABLE;

// This class provides custom init which should be called
+ (nonnull instancetype)new NS_UNAVAILABLE;

/**
 * Gets a TileStore instance for the given storage path. Creates a new one if one doesn't exist.
 *
 * If the given path is empty, the tile store at the default location is returned.
 * On iOS, this storage path is excluded from automatic cloud backup.
 * On Android, please exclude the storage path in your Manifest.
 * Please refer to the [Android Documentation](https://developer.android.com/guide/topics/data/autobackup.html#IncludingFiles) for detailed information.
 *
 * @param  path The path on disk where tiles and metadata will be stored
 * @return Returns a TileStore instance.
 */
+ (nonnull MBXTileStore *)getInstanceForPath:(nonnull NSString *)path __attribute((ns_returns_retained)) NS_REFINED_FOR_SWIFT;
/**
 * Gets a TileStore instance at the default location. Creates a new one if one doesn't exist.
 *
 * @return Returns a TileStore instance.
 */
+ (nonnull MBXTileStore *)getInstance __attribute((ns_returns_retained)) NS_REFINED_FOR_SWIFT;
/**
 * Removes a tile region.
 *
 * Removes a tile region from the existing packages list. The actual resources
 * eviction might be deferred. All pending loading operations for the tile region
 * with the given id will fail with Canceled error.
 *
 * @param id The tile region identifier.
 */
- (void)removeTileRegionForId:(nonnull NSString *)id;
/**
 * Sets additional options for this instance.
 *
 * @param key The configuration option that should be changed. Valid keys are listed in \c TileStoreOptions.
 * @param value The value for the configuration option, or null if it should be reset.
 */
- (void)setOptionForKey:(nonnull NSString *)key
                  value:(nonnull id)value;
/**
 * Sets additional options for this instance that are specific to a data type.
 *
 * @param key The configuration option that should be changed. Valid keys are listed in \c TileStoreOptions.
 * @param domain The data type this setting should be applied for.
 * @param value The value for the configuration option, or null if it should be reset.
 */
- (void)setOptionForKey:(nonnull NSString *)key
                 domain:(MBXTileDataDomain)domain
                  value:(nonnull id)value;

@end

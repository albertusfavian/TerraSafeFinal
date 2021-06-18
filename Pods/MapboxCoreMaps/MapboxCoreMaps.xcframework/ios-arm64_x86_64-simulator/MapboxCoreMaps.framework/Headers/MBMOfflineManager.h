// This file is generated and will be overwritten automatically.

#import <Foundation/Foundation.h>
#import <MapboxCoreMaps/MBMStylePackLoadProgressCallback.h>

@class MBMResourceOptions;
@class MBMStylePackLoadOptions;
@class MBMTilesetDescriptorOptions;
@class MBXCancelable;
@class MBXTilesetDescriptor;

/**
 * @brief OfflineManager manages downloads and storage for style packages and also produces tileset descriptors for the TileStore.
 *
 * All the asynchronous methods calls complete even if the `OfflineManager` instance gets out of scope before.
 */
NS_SWIFT_NAME(OfflineManager)
__attribute__((visibility ("default")))
@interface MBMOfflineManager : NSObject

// This class provides custom init which should be called
- (nonnull instancetype)init NS_UNAVAILABLE;

// This class provides custom init which should be called
+ (nonnull instancetype)new NS_UNAVAILABLE;

/**
 * @brief Construct a new offline manager
 *
 * @param resourceOptions the resource options to manage.
 */
- (nonnull instancetype)initWithResourceOptions:(nonnull MBMResourceOptions *)resourceOptions;

/**
 * @brief Construct a new TilesetDescriptor for the TileStore
 *
 * Tileset descriptors are used by the TileStore to create new offline regions.
 * Resolving the created tileset descriptor includes loading and parsing the style and might include
 * creation or update of a style package - depending on the given options.
 *
 * @param tilesetDescriptorOptions the resource options to manage.
 * @return Returns a new tileset descriptor
 */
- (nonnull MBXTilesetDescriptor *)createTilesetDescriptorForTilesetDescriptorOptions:(nonnull MBMTilesetDescriptorOptions *)tilesetDescriptorOptions __attribute((ns_returns_retained));
/**
 * @brief Removes a style package.
 *
 * Removes a style package from the existing packages list. The actual resources
 * eviction might be deferred. All pending loading operations for the style package
 * with the given id will fail with Canceled error.
 *
 * @param styleURI The URI of the style package's associated style
 */
- (void)removeStylePackForStyleURI:(nonnull NSString *)styleURI;

@end

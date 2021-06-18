// This file is generated and will be overwritten automatically.

#import <Foundation/Foundation.h>

@class MBMOfflineRegionGeometryDefinition;
@class MBMOfflineRegionTilePyramidDefinition;
@class MBMResourceOptions;

/**
 * @brief The OfflineRegionManager that manages offline packs. All of the class’s instance methods are asynchronous
 * reflecting the fact that offline resources are stored in a database. The offline manager maintains a canonical
 * collection of offline packs.
 */
NS_SWIFT_NAME(OfflineRegionManager)
__attribute__((visibility ("default")))
__attribute__((deprecated))
@interface MBMOfflineRegionManager : NSObject

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


@end

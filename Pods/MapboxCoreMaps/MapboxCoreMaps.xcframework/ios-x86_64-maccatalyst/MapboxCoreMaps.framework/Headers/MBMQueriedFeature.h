// This file is generated and will be overwritten automatically.

#import <Foundation/Foundation.h>
@class MBXFeature;

/**
 * @brief Represents query result that is returned in QueryFeaturesCallback.
 * @see Map#queryRenderedFeatures or Map#querySourceFeatures
 */
NS_SWIFT_NAME(QueriedFeature)
__attribute__((visibility ("default")))
@interface MBMQueriedFeature : NSObject

// This class provides custom init which should be called
- (nonnull instancetype)init NS_UNAVAILABLE;

// This class provides custom init which should be called
+ (nonnull instancetype)new NS_UNAVAILABLE;

- (nonnull instancetype)initWithFeature:(nonnull MBXFeature *)feature
                                 source:(nonnull NSString *)source
                            sourceLayer:(nullable NSString *)sourceLayer
                                  state:(nonnull id)state;

/** Feature returned by the query */
@property (nonatomic, readonly, nonnull) MBXFeature *feature;

/** Source id for a queried feature */
@property (nonatomic, readonly, nonnull, copy) NSString *source;

/**
 * Source layer id for a queried feature. May be null if source does not support layers, e.g., 'geojson' source,
 * or when source's data is not layered.
 */
@property (nonatomic, readonly, nullable, copy) NSString *sourceLayer;

/** Feature state for a queried feature. Type of the value is an Object, @see Map#setFeatureState */
@property (nonatomic, readonly, nonnull, copy) id state;


@end

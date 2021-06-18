// This file is generated and will be overwritten automatically.

#import <Foundation/Foundation.h>
@class MBXFeature;

/** @brief A value or a collection of a feature extension. */
NS_SWIFT_NAME(FeatureExtensionValue)
__attribute__((visibility ("default")))
@interface MBMFeatureExtensionValue : NSObject

// This class provides custom init which should be called
- (nonnull instancetype)init NS_UNAVAILABLE;

// This class provides custom init which should be called
+ (nonnull instancetype)new NS_UNAVAILABLE;

- (nonnull instancetype)initWithValue:(nullable id)value
                    featureCollection:(nullable NSArray<MBXFeature *> *)featureCollection;

/** @brief An optional value of a feature extension */
@property (nonatomic, readonly, nullable, copy) id value;

/** @brief An optional array of features from a feature extension. */
@property (nonatomic, readonly, nullable, copy) NSArray<MBXFeature *> *featureCollection;


@end

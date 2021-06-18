// This file is generated and will be overwritten automatically.

#import <MapboxCoreMaps/MBMCacheManager.h>
#import <MapboxCoreMaps/MBMAsyncOperationResultCallback_Internal.h>

@interface MBMCacheManager ()
- (void)invalidateAmbientCacheForCallback:(nonnull MBMAsyncOperationResultCallback)callback;
- (void)setMaximumAmbientCacheSizeForSize:(uint64_t)size
                                 callback:(nonnull MBMAsyncOperationResultCallback)callback;
- (void)clearAmbientCacheForCallback:(nonnull MBMAsyncOperationResultCallback)callback;
- (void)setDatabasePathForDbPath:(nonnull NSString *)dbPath
                        callback:(nonnull MBMAsyncOperationResultCallback)callback;
- (nonnull MBXCancelable *)prefetchAmbientCacheForCacheArea:(nonnull MBMCacheAreaDefinition *)cacheArea
                                                   callback:(nonnull MBMAsyncOperationResultCallback)callback __attribute((ns_returns_retained));
@end

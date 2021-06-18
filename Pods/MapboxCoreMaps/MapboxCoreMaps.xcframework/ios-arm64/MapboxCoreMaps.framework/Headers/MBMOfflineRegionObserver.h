// This file is generated and will be overwritten automatically.

#import <Foundation/Foundation.h>

@class MBMOfflineRegionStatus;
@class MBMResponseError;

/**
 * @brief A region can have a single observer, which gets notified whenever a change
 * to the region's status occurs.
 */
NS_SWIFT_NAME(OfflineRegionObserver)
@protocol MBMOfflineRegionObserver
/**
 * @brief Implement this method to be notified of a change in the status of an
 * offline region. Status changes include any change in state of the members
 * of OfflineRegionStatus.
 */
- (void)statusChangedForStatus:(nonnull MBMOfflineRegionStatus *)status;
/**
 * @brief Implement this method to be notified of errors encountered while downloading
 * regional resources. Such errors may be recoverable; for example the implementation
 * will attempt to re-request failed resources based on an exponential backoff
 * algorithm, or when it detects that network access has been restored.
 */
- (void)responseErrorForError:(nonnull MBMResponseError *)error;
/**
 * @brief Implement this method to be notified when the limit on the number of Mapbox
 * tiles stored for offline regions has been reached.
 */
- (void)mapboxTileCountLimitExceededForLimit:(uint64_t)limit;
@end

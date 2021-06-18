// This file is generated and will be overwritten automatically.

#import <Foundation/Foundation.h>
#import <MapboxCoreMaps/MBMTask.h>

/** @brief Interface for the MapClient. */
NS_SWIFT_NAME(MapClient)
@protocol MBMMapClient
/**
 * @brief A callback that notifies the client that the map contains updated information, and thus requires a new render to be scheduled.
 *
 * Note: this callback might be invoked from different threads and it blocks rendering, so
 * clients shall avoid performing any extra operations in this callback.
 */
- (void)scheduleRepaint;
/**
 * @brief Requests client to schedule task to be executed on client's scheduling system.
 *
 * Note: Implementation of this method is required when client uses dedicated rendering thread other then the thread
 * where Map instance is constructed.
 */
- (void)scheduleTaskForTask:(nonnull MBMTask)task;
@end

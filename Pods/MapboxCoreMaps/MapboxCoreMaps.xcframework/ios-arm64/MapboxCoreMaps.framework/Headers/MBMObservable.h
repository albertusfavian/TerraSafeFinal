// This file is generated and will be overwritten automatically.

#import <Foundation/Foundation.h>

@protocol MBMObserver;

/**
 * @brief Observable class provides basic Publish&Subscribe functionality. Classes that extend
 * this functionality and capable of generating events, have to specify event types and
 * corresponding data format for an event.
 */
NS_SWIFT_NAME(Observable)
__attribute__((visibility ("default")))
@interface MBMObservable : NSObject

/**
 * @brief Subscribes an Observer to a provided list of event types.
 * Observable will hold a strong reference to an Observer instance, therefore,
 * in order to stop receiving notifications, caller must call unsubscribe with an
 * Observer instance used for an initial subscription.
 *
 * @param observer an Observer
 * @param events an array of event types to be subscribed to.
 */
- (void)subscribeForObserver:(nonnull id<MBMObserver>)observer
                      events:(nonnull NSArray<NSString *> *)events;
/**
 * @brief Unsubscribes an Observer to a provided list of event types.
 * Observable will hold a strong reference to an Observer instance, therefore,
 * in order to stop receiving notifications, caller must call unsubscribe with an
 * Observer instance used for an initial subscription.
 *
 * @param observer an Observer
 * @param events an array of event types to be unsubscribed to.
 */
- (void)unsubscribeForObserver:(nonnull id<MBMObserver>)observer
                        events:(nonnull NSArray<NSString *> *)events;
/**
 * @brief Unsubscribes an Observer from all events.
 *
 * @param observer an Observer
 */
- (void)unsubscribeForObserver:(nonnull id<MBMObserver>)observer;

@end

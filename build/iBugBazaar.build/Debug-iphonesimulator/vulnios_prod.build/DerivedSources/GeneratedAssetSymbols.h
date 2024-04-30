#import <Foundation/Foundation.h>

#if __has_attribute(swift_private)
#define AC_SWIFT_PRIVATE __attribute__((swift_private))
#else
#define AC_SWIFT_PRIVATE
#endif

/// The "Cake" asset catalog image resource.
static NSString * const ACImageNameCake AC_SWIFT_PRIVATE = @"Cake";

/// The "Chiken" asset catalog image resource.
static NSString * const ACImageNameChiken AC_SWIFT_PRIVATE = @"Chiken";

/// The "Done" asset catalog image resource.
static NSString * const ACImageNameDone AC_SWIFT_PRIVATE = @"Done";

/// The "Home" asset catalog image resource.
static NSString * const ACImageNameHome AC_SWIFT_PRIVATE = @"Home";

/// The "Mix pizza" asset catalog image resource.
static NSString * const ACImageNameMixPizza AC_SWIFT_PRIVATE = @"Mix pizza";

/// The "Mixsalad" asset catalog image resource.
static NSString * const ACImageNameMixsalad AC_SWIFT_PRIVATE = @"Mixsalad";

/// The "Salad" asset catalog image resource.
static NSString * const ACImageNameSalad AC_SWIFT_PRIVATE = @"Salad";

/// The "Veg mix" asset catalog image resource.
static NSString * const ACImageNameVegMix AC_SWIFT_PRIVATE = @"Veg mix";

/// The "egg" asset catalog image resource.
static NSString * const ACImageNameEgg AC_SWIFT_PRIVATE = @"egg";

/// The "nachos" asset catalog image resource.
static NSString * const ACImageNameNachos AC_SWIFT_PRIVATE = @"nachos";

/// The "payatu" asset catalog image resource.
static NSString * const ACImageNamePayatu AC_SWIFT_PRIVATE = @"payatu";

/// The "pizza" asset catalog image resource.
static NSString * const ACImageNamePizza AC_SWIFT_PRIVATE = @"pizza";

/// The "sweet banana" asset catalog image resource.
static NSString * const ACImageNameSweetBanana AC_SWIFT_PRIVATE = @"sweet banana";

/// The "twitter-icon" asset catalog image resource.
static NSString * const ACImageNameTwitterIcon AC_SWIFT_PRIVATE = @"twitter-icon";

#undef AC_SWIFT_PRIVATE

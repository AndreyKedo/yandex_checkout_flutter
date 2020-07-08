#import "YandexCheckoutPlugin.h"
#if __has_include(<yandex_checkout/yandex_checkout-Swift.h>)
#import <yandex_checkout/yandex_checkout-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "yandex_checkout-Swift.h"
#endif

@implementation YandexCheckoutPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftYandexCheckoutPlugin registerWithRegistrar:registrar];
}
@end

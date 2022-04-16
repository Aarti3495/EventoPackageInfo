import 'package:evento_package/views/FullScreenVideo.dart';
import 'package:evento_package/views/checkout_pages/checkout.form.screen.dart';
import 'package:evento_package/views/checkout_pages/checkout.screen.dart';
import 'package:evento_package/views/event.booked.success.screen.dart';
import 'package:evento_package/views/event.detail.screen.dart';
import 'package:evento_package/views/filterScreen.dart';
import 'package:evento_package/views/forget.screen.dart';
import 'package:evento_package/views/fullscreenImage.dart';
import 'package:evento_package/views/home.layout.screen.dart';
import 'package:evento_package/views/language.currency.screen.dart';
import 'package:evento_package/views/otp.screen.dart';
import 'package:evento_package/views/pages/SuccessFailBooking.dart';
import 'package:evento_package/views/pages/entertainment.screen.dart';
import 'package:evento_package/views/partnerEventDetails.dart';
import 'package:evento_package/views/personalSkillsEventDetails.dart';
import 'package:evento_package/views/profile_pages/helpAndSupport.screen.dart';
import 'package:evento_package/views/profile_pages/history.screen.dart';
import 'package:evento_package/views/profile_pages/profile.screen.dart';
import 'package:evento_package/views/profile_pages/redeem.screen.dart';
import 'package:evento_package/views/profile_pages/referAndEarn.screen.dart';
import 'package:evento_package/views/profile_pages/wishlist.screen.dart';
import 'package:evento_package/views/reset.password.screen.dart';
import 'package:evento_package/views/signIn.screen.dart';
import 'package:evento_package/views/signup.screen.dart';
import 'package:evento_package/views/splash.screen.dart';
import 'package:evento_package/views/talk_with_organizer/talkwithorganizer.screen.dart';
import 'package:get/get.dart';
import 'route.names.dart';

RouteNames _routeName = RouteNames();

class AppRoute {
  final List<GetPage> getPages = [
    GetPage(
      name: _routeName.splash,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: _routeName.signIn,
      page: () => const SignInScreen(),
    ),
    GetPage(
      name: _routeName.forgetPassword,
      page: () => const ForgetPasswordScreen(),
    ),
    GetPage(
      name: _routeName.resetPassword,
      page: () => const ResetPasswordScreen(),
    ),
    GetPage(
      name: _routeName.signUp,
      page: () => const SignUpScreen(),
    ),
    GetPage(
      name: _routeName.otp,
      page: () => const OTPScreen(),
    ),
    GetPage(
      name: _routeName.layout,
      page: () => const HomeLayout(),
    ),
    GetPage(
      name: _routeName.profile,
      page: () => const ProfileScreen(),
    ),
    GetPage(
      name: _routeName.language,
      page: () => const LanguageCurrencyScreen(),
    ),
    GetPage(
      name: _routeName.filterScreen,
      page: () => const filterScreen(),
    ),
    GetPage(
      name: _routeName.checkOutForm,
      page: () => const CheckOutFormScreen(),
    ),
    GetPage(
      name: _routeName.checkout,
      page: () => const CheckoutScreen(),
    ),
    GetPage(
      name: _routeName.history,
      page: () => const HistoryScreen(),
    ),
    GetPage(
      name: _routeName.wishlist,
      page: () => const WishlistScreen(),
    ),
    GetPage(
      name: _routeName.successFailBooking,
      page: () => const SuccessFailBooking(),
    ),
    GetPage(
      name: _routeName.referEarn,
      page: () => const ReferEarnScreen(),
    ),
    GetPage(
      name: _routeName.redeem,
      page: () => const RedeemScreen(),
    ),
    GetPage(
      name: _routeName.eventBooked,
      page: () => const EventBookedScreen(),
    ),
    GetPage(
      name: _routeName.helpSupport,
      page: () => const HelpSupportScreen(),
    ),
    GetPage(
      name: _routeName.eventDetail,
      page: () => const EventDetailScreen(),
    ),
    GetPage(
      name: _routeName.partnerEventDetail,
      page: () => const PartnerEventDetailScreen(),
    ),
    GetPage(
      name: _routeName.personalSkillsEventDetailScreen,
      page: () => const PersonalSkillsEventDetailScreen(),
    ),
    GetPage(
      name: _routeName.entertainment,
      page: () => const Entertainment(),
    ),
    GetPage(
      name: _routeName.fullImageScreen,
      page: () => FullScreenImage(),
    ),
    GetPage(
      name: _routeName.fullvideoScreen,
      page: () => FullScreenVideo(),
    ),
    GetPage(
      name: RouteNames.talkWithOrganizer,
      page: () => TalkWithOrganizerScreen(),
    ),
  ];
}

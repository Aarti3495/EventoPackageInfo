import 'package:evento_package/views/pages/dashboard.screen.dart';
import 'package:evento_package/views/pages/entertainment.screen.dart';
import 'package:evento_package/views/pages/search.screen.dart';
import 'package:evento_package/views/pages/your.tickets.screen.dart';
import 'package:get/get.dart';

class   HomeLayoutController extends GetxController {
  int selectedIndex = 0;
  List tabNames = const [
    "Dashboard",
    "Search",
    "Entertainment",
    "Your Tickets"
  ];
  List tabScreens = const [
    DashboardScreen(),
    SearchScreen(),
    Entertainment(),
    YouTicketsScreen(),
  ];

  onTabChange(int index) {
    selectedIndex = index;
    update();
  }
}

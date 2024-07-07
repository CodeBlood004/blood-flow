import 'package:fitness_care/consts/imports.dart';
import 'package:fitness_care/controller/route_controller.dart';
import 'package:google_nav_bar/google_nav_bar.dart';


@immutable
class CustomNavBar extends StatelessWidget {

  CustomNavBar({super.key});

  final RouteController controller = Get.find<RouteController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: GNav(
        onTabChange: (value) {
          controller.updateScreenIndex(value);
        },
        // tabBackgroundColor: green,
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
        gap: 8.w,
        tabs: [
          GButton(
            icon: Icons.home,
            text: "Home",
            iconSize: 24.sp,
            textStyle: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
          ),
          GButton(
            icon: FontAwesomeIcons.person,
            text: "Profile",
            iconSize: 24.sp,
            textStyle: TextStyle(fontSize: 16.sp , fontWeight: FontWeight.bold),
          ),
          GButton(
            icon: Icons.history,
            text: "History",
            iconSize: 24.sp,
            textStyle: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
          ),
        ],
      ),
      body: Obx(
            () => controller.pages[controller.screenIndex.value],
      ),
    );
  }
}

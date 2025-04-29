import 'package:epsp_sige/models/SchoolModel.dart';
import 'package:epsp_sige/pages/BottomNavigationPage.dart';
import 'package:epsp_sige/pages/connexion/LoginPage.dart';
import 'package:epsp_sige/controllers/saved_forms_screen.dart';
import 'package:epsp_sige/pages/home/MyHomePage.dart';
import 'package:epsp_sige/pages/home/NavigationDrawerMenu.dart';
import 'package:epsp_sige/pages/home/widgets/DynamicAccessAccordion.dart';
import 'package:epsp_sige/pages/home/widgets/FormPage.dart';
import 'package:epsp_sige/pages/home/widgets/SchoolDetailPage.dart';
import 'package:epsp_sige/pages/home/widgets/SchoolListPage.dart';
import 'package:epsp_sige/pages/introduction/DiscoverPage.dart';
import 'package:epsp_sige/pages/introduction/OnBoardingPage.dart';
import 'package:epsp_sige/pages/introduction/SplashScreen.dart';
import 'package:epsp_sige/pages/news/NotificationsPage.dart';
import 'package:epsp_sige/pages/user/EditProfilePage.dart';
import 'package:epsp_sige/pages/user/ProfilPage.dart';
import 'package:epsp_sige/settings/SettingsPage.dart';
import 'package:epsp_sige/settings/lockthumbprint/LockByThumbPrintPage.dart';
import 'package:epsp_sige/utils/navigations.dart';
import 'package:flutter/material.dart';

import 'Routes.dart';

class RoutesManager {
  static Route? route(RouteSettings r) {
    switch (r.name) {
      case Routes.SplashScreenPageRoutes:
        return MaterialPageRoute(builder: (_) => SplashScreen());

      case Routes.DiscoverPageRoutes:
        return MaterialPageRoute(builder: (_) => DiscoverPage());

      case Routes.LoginPageRoutes:
        return MaterialPageRoute(builder: (_) => LoginPage());

      case Routes.BottomNavigationPageRoutes:
        return MaterialPageRoute(
            builder: (_) => BottomNavigationPage(Navigations.navigations));

      case Routes.HomePageRoutes:
        return MaterialPageRoute(
            builder: (_) => MyHomePage(Navigations.navigations));

      case Routes.ProfilPageRoutes:
        return MaterialPageRoute(builder: (_) => ProfilPage());

      case Routes.SettingsPageRoutes:
        return MaterialPageRoute(builder: (_) => SettingsPage());

      case Routes.NotificationsPageRoutes:
        return MaterialPageRoute(builder: (_) => NotificationsPage());

      case Routes.NavigationDrawerMenuRoutes:
        return MaterialPageRoute(builder: (_) => NavigationDrawerMenu());

      case Routes.EditProfilePageRoutes:
        return MaterialPageRoute(builder: (_) => EditProfilePage());

      case Routes.OnBoardingPageRoutes:
        return MaterialPageRoute(builder: (_) => OnBoardingPage());

      case Routes.LockByThumbPrintPageRoutes:
        return MaterialPageRoute(builder: (_) => LockByThumbPrintPage());

      case Routes.SavedFormsScreenRoutes:
        return MaterialPageRoute(builder: (_) => SavedFormsScreen());

      case Routes.FormListPageRoutes:
        return MaterialPageRoute(builder: (_) => FormListPage());

      case Routes.SchoolListPageRoutes:
        return MaterialPageRoute(
          settings: r, // Correction: utilisez le paramètre 'r'
          builder: (context) {
            final args = r.arguments as Map<String, dynamic>?;
            return SchoolListPage(
              establishments: args?['establishments'] ?? [],
            );
          },
        );

      case Routes.SchoolDetailPageRoutes:
        var args = r.arguments
            as Map<String, dynamic>?; // Cast to Map<String, dynamic>
        var schoolchoosed =
            <String, dynamic>{}; // Initialize as empty Map<String, dynamic>
        var schoolData =
            SchoolModel.fromJson(args ?? schoolchoosed); // Use the casted args
        return MaterialPageRoute(
          builder: (_) => SchoolDetailPage(school: schoolData),
        );

      default:
        return null;
    }
  }
}

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
// ignore: depend_on_referenced_packages
import 'package:provider/provider.dart';
import 'package:univs/core/resources/theme/colors.dart';
import 'package:univs/core/routes/router_import.gr.dart';

import 'page_provider.dart';

@RoutePage()
class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PageProvider(),
      child: AutoTabsRouter(
        routes: const [
          HomeRoute(),
          QuizRoute(),
          NotificationRoute(),
          SearchRoute(),
          CreatePostingRoute(),
          ProfileRoute(),
        ],
        transitionBuilder: (context, child, animation) => FadeTransition(
          opacity: animation,
          child: child,
        ),
        builder: (context, child) {
          final tabsRouter = AutoTabsRouter.of(context);
          return Consumer<PageProvider>(
            builder: (context, provider, _) {
              return Scaffold(
                body: child,
                backgroundColor: AppColors.colorWhite,
                bottomNavigationBar: BottomNavigationBar(
                  currentIndex: tabsRouter.activeIndex,
                  backgroundColor: AppColors.colorWhite,
                  selectedItemColor: AppColors.colorBlack,
                  unselectedItemColor: AppColors.colorBlack.withOpacity(0.5),
                  type: BottomNavigationBarType.fixed,
                  onTap: (value) {
                    tabsRouter.setActiveIndex(value);
                    provider.changeIndex(value);
                  },
                  items: [
                    BottomNavigationBarItem(
                      icon: Icon(
                        IconlyBold.home,
                        color: tabsRouter.activeIndex == 0
                            ? AppColors.colorBlack
                            : AppColors.colorBlack.withOpacity(0.5),
                      ),
                      label: '',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(
                        IconlyBold.document,
                        color: tabsRouter.activeIndex == 1
                            ? AppColors.colorBlack
                            : AppColors.colorBlack.withOpacity(0.5),
                      ),
                      label: '',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(
                        IconlyBold.notification,
                        color: tabsRouter.activeIndex == 2
                            ? AppColors.colorBlack
                            : AppColors.colorBlack.withOpacity(0.5),
                      ),
                      label: '',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(
                        IconlyBold.search,
                        color: tabsRouter.activeIndex == 3
                            ? AppColors.colorBlack
                            : AppColors.colorBlack.withOpacity(0.5),
                      ),
                      label: '',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(
                        IconlyBold.plus,
                        color: tabsRouter.activeIndex == 4
                            ? AppColors.colorBlack
                            : AppColors.colorBlack.withOpacity(0.5),
                      ),
                      label: '',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(
                        IconlyBold.profile,
                        color: tabsRouter.activeIndex == 5
                            ? AppColors.colorBlack
                            : AppColors.colorBlack.withOpacity(0.5),
                      ),
                      label: '',
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}

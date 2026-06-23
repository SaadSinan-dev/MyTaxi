import 'package:flutter/material.dart';
import 'package:my_taxi/features/map/presentation/widgets/body.dart';
import 'package:my_taxi/core/widgets/appbar/app_bar.dart';
import 'package:my_taxi/core/widgets/sidebar/app_sidebar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: CustomAppBar(
        title: 'My Taxi',
        showBackButton: false,
        showDrawerToggle: true,
        onDrawerToggle: () => _scaffoldKey.currentState?.openDrawer(),
      ),
      drawer: const AppSideBar(),
      body: const LocationBody(),
    );
  }
}

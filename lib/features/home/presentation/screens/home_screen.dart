import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_taxi/core/widgets/appbar/app_bar.dart';
import 'package:my_taxi/core/widgets/sidebar/app_side_bar.dart';
import 'package:my_taxi/features/map/data/repositories/location_repository_impl.dart';
import 'package:my_taxi/features/map/presentation/cubit/map_cubit.dart';
import 'package:my_taxi/features/map/presentation/cubit/map_state.dart';
import 'package:my_taxi/features/map/presentation/screens/map_screen.dart';
import 'package:my_taxi/features/map/presentation/widgets/map_skeleton_loader.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MapCubit(LocationRepository())..fetchLocation(),
      child: BlocBuilder<MapCubit, MapState>(
        builder: (context, state) {
          if (state.status == MapStatus.loading ||
              state.status == MapStatus.initial) {
            return Scaffold(
              key: _scaffoldKey,
              extendBodyBehindAppBar: true,
              backgroundColor: Colors.transparent,
              appBar: CustomAppBar(hasUnreadNotifications: true),
              drawer: const AppSideBar(),
              body: const MapSkeletonLoader(),
            );
          }

          return Scaffold(
            key: _scaffoldKey,
            extendBodyBehindAppBar: true,
            backgroundColor: Colors.transparent,
            appBar: CustomAppBar(hasUnreadNotifications: true),
            drawer: const AppSideBar(),
            body: const MapScreen(),
          );
        },
      ),
    );
  }
}

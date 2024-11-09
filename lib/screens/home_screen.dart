import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:go_router/go_router.dart';
import 'package:submission_intermediate/bloc/home/home_cubit.dart';
import 'package:submission_intermediate/bloc/home/home_state.dart';
import 'package:submission_intermediate/bloc/logout/logout_cubit.dart';
import 'package:submission_intermediate/common/navigation.dart';
import 'package:submission_intermediate/data/model/stories_response.dart';
import 'package:submission_intermediate/widgets/post_card.dart';

import '../common/app_localization.dart';
import '../widgets/my_app_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _showFab = true;
  final duration = const Duration(milliseconds: 300);

  void onResume() {
    context.read<HomeCubit>().initDataHome();
  }

  @override
  Widget build(BuildContext context) {
    return FocusDetector(
      onFocusGained: onResume,
      child: Scaffold(
        appBar: MyAppBar(
          hasBack: false,
          onPressedLogout: () {
            context.read<LogoutCubit>().logout();
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: AnimatedSlide(
          duration: duration,
          offset: _showFab ? Offset.zero : const Offset(0, 2),
          child: AnimatedOpacity(
            duration: duration,
            opacity: _showFab ? 1 : 0,
            child: FloatingActionButton(
              onPressed: () {
                context.goNamed(Navigation.addStory);
              },
              tooltip: AppLocalizations.of(context)!.addStory,
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              child: const Icon(Icons.add),
            ),
          ),
        ),
        body: NotificationListener<UserScrollNotification>(
          onNotification: (notification) {
            final scrollDirection = notification.direction;
            setState(() {
              if (scrollDirection == ScrollDirection.reverse) {
                _showFab = false;
              } else if (scrollDirection == ScrollDirection.forward) {
                _showFab = true;
              }
            });
            return true;
          },
          child: BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              switch (state) {
                case Loading():
                  return const Center(child: CircularProgressIndicator());
                case Success():
                  return showListStory(state.listStory);
                case Error():
                  return Center(
                    child: Text(
                      state.error,
                      style: const TextStyle(color: Colors.white),
                    ),
                  );
              }
            },
          ),
        ),
      ),
    );
  }

  Widget showListStory(List<ListStory> listStory) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ScrollConfiguration(
        behavior: const ScrollBehavior().copyWith(overscroll: false),
        child: ListView.separated(
          itemBuilder: (context, index) {
            return PostCard(
              key: Key(listStory[index].id),
              listStory: listStory[index],
              onTap: () {
                context.goNamed(
                  Navigation.detailStory,
                  pathParameters: {
                    'id': listStory[index].id,
                  },
                );
              },
            );
          },
          separatorBuilder: (context, index) {
            return const Padding(padding: EdgeInsets.all(8));
          },
          itemCount: listStory.length,
        ),
      ),
    );
  }
}

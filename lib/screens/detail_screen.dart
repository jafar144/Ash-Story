import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:submission_intermediate/bloc/detail/detail_cubit.dart';
import 'package:submission_intermediate/bloc/detail/detail_state.dart';
import 'package:submission_intermediate/data/model/detail_story_response.dart';

import '../common/app_colors.dart';
import '../helper/initial_name.dart';
import '../helper/last_post_time.dart';
import '../widgets/my_app_bar.dart';

class DetailScreen extends StatefulWidget {
  final String id;

  const DetailScreen({
    super.key,
    required this.id,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  void initState() {
    super.initState();
    context.read<DetailCubit>().initDataDetail(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(
        title: "Detail Story",
      ),
      body: BlocBuilder<DetailCubit, DetailState>(builder: (context, state) {
        switch (state) {
          case Loading():
            return const Center(child: CircularProgressIndicator());
          case Success():
            return _detailBuilder(state.story);
          case Error():
            return Center(child: Text(state.error));
        }
      }),
    );
  }

  Widget _detailBuilder(Story story) {
    return ScrollConfiguration(
      behavior: const ScrollBehavior().copyWith(overscroll: false),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(
              story.photoUrl,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.amber,
                        ),
                        child: Center(
                          child: Text(
                            initialName(story.name),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        story.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                  Text(
                    getLastPostTime(context, story.createdAt),
                    style: const TextStyle(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                story.description,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

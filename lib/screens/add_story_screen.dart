import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:submission_intermediate/bloc/add_story/add_story_cubit.dart';
import 'package:submission_intermediate/bloc/add_story/add_story_state.dart';
import 'package:submission_intermediate/bloc/add_story/image_path_cubit.dart';
import 'package:submission_intermediate/common/navigation.dart';
import 'package:submission_intermediate/helper/show_dialog.dart';
import 'package:submission_intermediate/widgets/my_app_bar.dart';

import '../common/app_colors.dart';
import '../common/app_localization.dart';
import '../widgets/rounded_button.dart';

class AddStoryScreen extends StatefulWidget {
  const AddStoryScreen({super.key});

  @override
  State<AddStoryScreen> createState() => _AddStoryScreenState();
}

class _AddStoryScreenState extends State<AddStoryScreen> {
  final _descriptionController = TextEditingController();

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: AppLocalizations.of(context)!.addStory,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ScrollConfiguration(
          behavior: const ScrollBehavior().copyWith(overscroll: false),
          child: SingleChildScrollView(
            child: Column(
              children: [
                BlocBuilder<ImagePathCubit, XFile?>(
                  builder: (context, imageFile) {
                    if (imageFile != null) {
                      return Image.file(
                        File(imageFile.path),
                        height: 225,
                        width: 300,
                        fit: BoxFit.cover,
                      );
                    } else {
                      return const Icon(
                        Icons.image,
                        size: 225,
                      );
                    }
                  },
                ),
                const SizedBox(height: 16),
                _cameryGallerySection(context),
                const SizedBox(height: 36),
                _descriptionSection(),
                const SizedBox(height: 32),
                _uploadButtonSection(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  TextField _descriptionSection() {
    return TextField(
      controller: _descriptionController,
      maxLines: 5,
      style: const TextStyle(color: AppColors.textSecondary),
      cursorColor: AppColors.textSecondary,
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.secondaryColor,
        hintText: AppLocalizations.of(context)!.description,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _uploadButtonSection(BuildContext context) {
    return BlocConsumer<AddStoryCubit, AddStoryState>(
      listener: (ctx, state) {
        if (state is Success) {
          if (context.mounted) {
            showSuccessDialog(
              context: context,
              message: AppLocalizations.of(context)!.successAddStory,
              onPressed: () {
                context.read<ImagePathCubit>().resetImageFile();
                context.goNamed(Navigation.home);
              },
            );
          }
        } else if (state is Error) {
          showErrorDialog(
            context: context,
            message: AppLocalizations.of(context)!.failedAddStory,
            onPressed: () {
              context.pop();
            },
          );
        }
      },
      builder: (context, state) {
        if (state is Loading) {
          return const RoundedButton(
            onTap: null,
            useBorder: false,
            isLoading: true,
          );
        }

        return RoundedButton(
          onTap: () {
            _upload(context);
          },
          useBorder: false,
          text: 'Upload',
          textColor: AppColors.primaryColor,
          backgroundColor: Colors.white,
        );
      },
    );
  }

  Row _cameryGallerySection(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: RoundedButton(
            text: 'Camera',
            textColor: AppColors.primaryColor,
            backgroundColor: Colors.white,
            useBorder: false,
            onTap: () => _onCameraView(context),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: RoundedButton(
            text: 'Gallery',
            useBorder: true,
            borderColor: Colors.white,
            onTap: () => _onGalleryView(context),
          ),
        ),
      ],
    );
  }

  _upload(BuildContext context) async {
    final addStoryCubit = context.read<AddStoryCubit>();
    final imageFile = context.read<ImagePathCubit>().imageFile;
    final description = _descriptionController.text;
    if (imageFile == null) {
      showErrorDialog(
        context: context,
        onPressed: () => context.pop(),
        message: AppLocalizations.of(context)!.pleaseAddImage,
      );
    } else if (description.isEmpty) {
      showErrorDialog(
        context: context,
        onPressed: () => context.pop(),
        message: AppLocalizations.of(context)!.pleaseAddDescription,
      );
    }

    final fileName = imageFile?.name;
    final bytes = await imageFile?.readAsBytes();

    await addStoryCubit.upload(
      bytes as List<int>,
      fileName!,
      description,
    );
    if (context.mounted) {
      context.read<ImagePathCubit>().resetImageFile;
    }
  }

  _onGalleryView(BuildContext context) async {
    final isMacOS = defaultTargetPlatform == TargetPlatform.macOS;
    final isLinux = defaultTargetPlatform == TargetPlatform.linux;
    if (isMacOS || isLinux) return;

    final imagePicker = ImagePicker();
    final XFile? pickedFile = await imagePicker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null && context.mounted) {
      context.read<ImagePathCubit>().setImageFile(pickedFile);
    }
  }

  _onCameraView(BuildContext context) async {
    final isAndroid = defaultTargetPlatform == TargetPlatform.android;
    final isiOS = defaultTargetPlatform == TargetPlatform.iOS;
    final isNotMobile = !(isAndroid || isiOS);
    if (isNotMobile) return;

    final picker = ImagePicker();

    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.camera,
      preferredCameraDevice: CameraDevice.front,
    );

    if (pickedFile != null && context.mounted) {
      context.read<ImagePathCubit>().setImageFile(pickedFile);
    }
  }
}

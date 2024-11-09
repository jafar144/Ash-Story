import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:submission_intermediate/helper/show_bottom_sheet.dart';

import '../common/app_colors.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool hasBack;
  final String title;
  final VoidCallback? onPressedLogout;

  const MyAppBar({
    super.key,
    this.hasBack = true,
    this.title = '',
    this.onPressedLogout,
  });

  @override
  Widget build(BuildContext context) {
    return hasBack
        ? AppBar(
            backgroundColor: AppColors.primaryColor,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              color: Colors.white,
              onPressed: () => context.pop(),
            ),
            elevation: 0,
            title: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
            centerTitle: true,
          )
        : AppBar(
            backgroundColor: AppColors.primaryColor,
            leading: Image.asset('assets/images/logo_app.png'),
            elevation: 0,
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: IconButton(
                  icon: const Icon(Icons.exit_to_app_outlined),
                  onPressed: () {
                    showCustomBottomSheet(context, onPressedLogout!);
                  },
                  color: Colors.white,
                ),
              ),
            ],
          );
  }

  @override
  Size get preferredSize => const Size.fromHeight(55);
}

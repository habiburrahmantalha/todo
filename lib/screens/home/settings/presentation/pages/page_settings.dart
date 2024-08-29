import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:todo/core/utils/extensions.dart';
import 'package:todo/screens/home/settings/blocs/settings_cubit.dart';
import 'package:todo/screens/task_create/data/models/comment.dart';
import 'package:todo/screens/task_create/presentation/widgets/comment_list.dart';
import 'package:todo/widgets/loading_indicator.dart';
import 'package:todo/widgets/raw_button.dart';

class PageSettings extends StatelessWidget {
  const PageSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Settings"),),
      body: Column(
        children: [
          // Text(
          //   AppLocalizations.of(context).settings_screen_theme_mode_option,
          //   style: TextStyle(
          //     fontSize: AppDimens.mediumFontSize,
          //     color: Theme.of(context).hintColor,
          //     fontWeight: FontWeight.w400,
          //   ),
          // ),
          BlocBuilder<SettingsCubit, SettingsState>(
            builder: (context, state) {
              ThemeMode themeMode = state.theme ?? (context.isDarkMode ? ThemeMode.dark : ThemeMode.light);
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    const Icon(FontAwesomeIcons.palette, color: Colors.grey),
                    const SizedBox(width: 12,),
                    Text(themeMode == ThemeMode.dark ? "Dark" : "Light", style: Theme.of(context).textTheme.labelLarge),
                    const Spacer(),
                    Switch(
                      value: themeMode == ThemeMode.dark,
                      onChanged: (value) {
                        context.read<SettingsCubit>().setAppTheme(value ? ThemeMode.dark : ThemeMode.light);
                      },
                    ),
                  ],
                ),
              );
            },
          ),

          if(kDebugMode)
          const WidgetColorCheck()
        ],
      ),
    );
  }
}

class WidgetColorCheck extends StatelessWidget {
  const WidgetColorCheck({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          Text("Widget Color Check", style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 12,),
          RawButton(
              padding: const EdgeInsets.all(12),
              child: Center(child: Text("Create Task", style: Theme.of(context).textTheme.titleMedium)),
              onTap: (){}
          ),
          const SizedBox(height: 12,),
          RawButton(
              color: Theme.of(context).colorScheme.onError,
              padding: const EdgeInsets.all(12),
              child: Center(child: Text("Create Task", style: Theme.of(context).textTheme.titleMedium)),
              onTap: (){}
          ),
          const SizedBox(height: 12,),
          const LoadingIndicator(),
          const SizedBox(height: 12,),
          CommentCardView(comment: Comment(content: " dkfjh dkfj")),
          const SizedBox(height: 12,),
        ],
      ),
    );
  }
}


import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:todo/core/utils/extensions.dart';
import 'package:todo/screens/home/settings/blocs/settings_cubit.dart';
import 'package:todo/screens/task/domain/entities/entity_comment.dart';
import 'package:todo/screens/task/presentation/widgets/comment_card_view.dart';
import 'package:todo/widgets/bottom_sheet_button.dart';
import 'package:todo/widgets/loading_indicator.dart';
import 'package:todo/widgets/raw_button.dart';

import 'language.dart';

class PageSettings extends StatelessWidget {
  const PageSettings({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text(context.tr("settings")),),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Icon(FontAwesomeIcons.language, color: Theme.of(context).iconTheme.color),
                const SizedBox(width: 12,),
                Text(context.tr("language"))
              ],
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: languageList.length,
            itemBuilder: (context, index) {
              return ListTile(
                onTap: (){
                  context.setLocale(Locale(languageList[index].code));
                },
                title: Text(languageList[index].title),
                leading: Radio<String>(
                  value: languageList[index].code,
                  groupValue: context.locale.languageCode,
                  onChanged: (value) {
                    context.setLocale(Locale(value ?? "en"));
                  },
                ),
              );
            },
          ),
          BlocBuilder<SettingsCubit, SettingsState>(
            builder: (context, state) {
              ThemeMode themeMode = state.theme ?? (context.isDarkMode ? ThemeMode.dark : ThemeMode.light);
              return Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    Icon(FontAwesomeIcons.palette, color: Theme.of(context).iconTheme.color),
                    const SizedBox(width: 12,),
                    Text("${context.tr("theme")} (${themeMode == ThemeMode.dark ? context.tr("dark") : context.tr("light")})", style: Theme.of(context).textTheme.labelLarge),
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
          //if(kDebugMode)
          //const WidgetColorCheck()
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
          const CommentCardView(comment: EntityComment(id: "", content: " comment card check", taskId: "", )),
          const SizedBox(height: 12,),
          BottomSheetButton(
            color: Colors.indigo[400],
            onTap: (){

            },
            label: "Edit", icon: Icons.edit,),
        ],
      ),
    );
  }
}


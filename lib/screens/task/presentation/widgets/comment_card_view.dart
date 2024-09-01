import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:todo/core/utils/utils.dart';
import 'package:todo/screens/task/domain/entities/entity_comment.dart';
import 'package:todo/screens/task/presentation/blocs/task_bloc.dart';
import 'package:todo/widgets/bottom_sheet_button.dart';
import 'package:todo/widgets/raw_button.dart';

class CommentCardView extends StatelessWidget {
  const CommentCardView({super.key, required this.comment});

  final EntityComment comment;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: Theme.of(context).hoverColor,
            borderRadius: BorderRadius.circular(8)
        ),
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          children: [
            const SizedBox(width: 12,),
            Text(comment.content),
            const Spacer(),
            RawButton(
                color: Colors.transparent,
                margin: const EdgeInsets.only(right: 8),
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                child: const Row(
                  children: [
                    FaIcon(FontAwesomeIcons.ellipsisVertical, color: Colors.grey, size: 18,)
                  ],
                ),
                onTap: (){
                  showCustomBottomSheet(
                      context,
                      isScrollControlled: true,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            BottomSheetButton(
                              color: Theme.of(context).colorScheme.onError,
                              onTap: (){
                                Navigator.pop(context);
                                context.read<TaskBloc>().add(DeleteTaskCommentEvent(commentId: comment.id, taskId: comment.taskId));
                              }, label: context.tr("delete"), icon: Icons.delete,),
                            const SizedBox(height: 24,),
                          ],
                        ),
                      )
                  );

                })
          ],
        )
    );
  }
}
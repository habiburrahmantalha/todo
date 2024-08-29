import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:todo/core/utils/utils.dart';
import 'package:todo/screens/task_create/data/models/comment.dart';
import 'package:todo/screens/task_create/presentation/blocs/task_bloc.dart';
import 'package:todo/widgets/bottom_sheet_button.dart';
import 'package:todo/widgets/loading_indicator.dart';
import 'package:todo/widgets/raw_button.dart';

class CommentList extends StatelessWidget {
  const CommentList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskBloc, TaskState>(
      builder: (context, state) {
        List<Comment> list = state.commentList ?? [];
        return Expanded(
            child: state.statusCommentList?.isLoading == true && list.isEmpty ? const LoadingIndicator() :  ListView.separated(
                shrinkWrap: true,
                itemBuilder: (context, index){
                  return CommentCardView(comment: list[index]);
                },
                separatorBuilder: (context, index){
                  return const SizedBox(height: 8,);
                },
                itemCount: list.length
            )
        );
      },
    );
  }
}

class CommentCardView extends StatelessWidget {
  const CommentCardView({super.key, required this.comment});

  final Comment comment;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: Theme.of(context).hoverColor,
            borderRadius: BorderRadius.circular(8)
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        child: Row(
          children: [
            Text(comment.content ?? ""),
            const Spacer(),
            RawButton(
                color: Colors.transparent,
                margin: const EdgeInsets.only(right: 8),
                padding: const EdgeInsets.all(8),
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
                            BottomSheetButton(onTap: (){
                              Navigator.pop(context);
                              context.read<TaskBloc>().add(DeleteTaskCommentEvent(commentId: comment.id ?? "", taskId: comment.taskId ?? ""));
                            }, label: "Delete", icon: Icons.delete,),
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

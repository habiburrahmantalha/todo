import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/screens/task/data/models/comment.dart';
import 'package:todo/screens/task/presentation/blocs/task_bloc.dart';
import 'package:todo/screens/task/presentation/widgets/comment_card_view.dart';
import 'package:todo/widgets/loading_indicator.dart';

class CommentList extends StatelessWidget {
  const CommentList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskBloc, TaskState>(
      builder: (context, state) {
        List<Comment> list = state.commentList ?? [];
        return state.statusCommentList?.isLoading == true && list.isEmpty ? const LoadingIndicator() :  ListView.separated(
          physics: const ClampingScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index){
              return CommentCardView(comment: list[index]);
            },
            separatorBuilder: (context, index){
              return const SizedBox(height: 8,);
            },
            itemCount: list.length
        );
      },
    );
  }
}



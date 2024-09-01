import 'package:easy_localization/easy_localization.dart';
import 'package:fbroadcast/fbroadcast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:todo/core/resource/resource.dart';
import 'package:todo/core/utils/utils.dart';
import 'package:todo/router/router.dart';
import 'package:todo/screens/home/presentation/screens/screen_home.dart';
import 'package:todo/screens/home/task_list/domain/entities/task.dart';
import 'package:todo/screens/task/presentation/blocs/task_bloc.dart';
import 'package:todo/screens/task/presentation/widgets/comment_list.dart';
import 'package:todo/screens/task/presentation/widgets/task_details_view.dart';
import 'package:todo/widgets/bottom_sheet_button.dart';
import 'package:todo/widgets/loading_indicator.dart';
import 'package:todo/widgets/raw_button.dart';

class ScreenTaskDetails extends StatefulWidget {
  static const String routeName = "task_details";
  const ScreenTaskDetails({super.key, this.task});
  final Task? task;

  @override
  State<ScreenTaskDetails> createState() {
    return _ScreenTaskDetailsState();
  }
}

class _ScreenTaskDetailsState extends State<ScreenTaskDetails> {

  TextEditingController textEditingController = TextEditingController();
  FocusNode focusNode = FocusNode();
  @override
  void initState() {
    super.initState();
    context.read<TaskBloc>().add(GetCommentListEvent(widget.task?.id ?? ""));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TaskBloc, TaskState>(
        listener: (context, state) {
          if(state.statusTaskDelete?.isSuccess == true){
            context.go(ScreenHome.routeName);
            FBroadcast.instance().broadcast(R.string.reloadTask);
            showOkToast(context.tr("task_deleted"), type: ToastType.error);
          }
          else if(state.statusTaskDelete?.isFailed == true){
            showOkToast(context.tr("something_went_wrong"), type: ToastType.error);
          }
        },
        builder: (context, state){
          return Scaffold(
            appBar: AppBar(
              title: Text(context.tr("task_details")),
              actions: [
                state.statusTaskDelete?.isLoading == true ? const Padding(
                  padding: EdgeInsets.only(right: 4),
                  child: LoadingIndicator(),
                ) :
                RawButton(
                    color: Colors.transparent,
                    margin: const EdgeInsets.only(right: 8),
                    padding: const EdgeInsets.all(12),
                    child: const Row(
                      children: [
                        FaIcon(FontAwesomeIcons.ellipsisVertical)
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
                                  color: Colors.blueGrey[400],
                                  onTap: (){
                                    Navigator.pop(context);
                                    context.go(RouterPaths.taskUpdatePathFromDetails, extra: widget.task);
                                  }, label: context.tr("edit"), icon: Icons.edit,),
                                BottomSheetButton(
                                  color: Theme.of(context).colorScheme.onError,
                                  onTap: (){
                                    Navigator.pop(context);
                                    context.read<TaskBloc>().add(DeleteTaskEvent(widget.task?.id ?? ""));
                                  }, label: context.tr("delete"), icon: Icons.delete,),
                                const SizedBox(height: 24,),
                              ],
                            ),
                          )
                      );
                    }),
              ],
            ),
            //context.go(RouterPaths.taskUpdatePathFromDetails, extra: widget.task);
            body: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  Expanded(
                      child:
                      ListView(
                        children: [
                          if(widget.task != null)
                          TaskDetailsView(task: widget.task!),
                          const SizedBox(height: 24,),
                          Text("${context.tr("comments")} (${(state.commentList ?? []).length})", style: Theme.of(context).textTheme.titleMedium),
                          const SizedBox(height: 12,),
                          const Divider(),
                          const CommentList(),
                        ],
                      )
                  ),
                  const SizedBox(height: 12,),
                  SafeArea(
                    child: Container(
                      constraints: const BoxConstraints(
                        maxHeight: 160,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                              child: TextField(
                                focusNode: focusNode,
                                controller: textEditingController,
                                maxLines: null,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                  hintText: context.tr("add_a_comment"),
                                  filled: true,
                                  suffixIcon: RawButton(
                                      color: Colors.transparent,
                                      margin: const EdgeInsets.all(4),
                                      onTap: (){
                                        if(textEditingController.text.isNotEmpty) {
                                          context.read<TaskBloc>().add(AddTaskCommentEvent(
                                            id: widget.task?.id ?? "",
                                            value: textEditingController.text,
                                          ));
                                          textEditingController.clear();
                                          focusNode.unfocus();
                                        }
                                      },
                                      child: Icon(Icons.send_rounded,  color: Theme.of(context).iconTheme.color)),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              )
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        }
    );
  }
}





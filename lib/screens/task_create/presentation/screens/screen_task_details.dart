import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:todo/core/utils/utils.dart';
import 'package:todo/router/router.dart';
import 'package:todo/screens/home/task_list/domain/entities/task.dart';
import 'package:todo/screens/task_create/presentation/blocs/task_bloc.dart';
import 'package:todo/screens/task_create/presentation/widgets/comment_list.dart';
import 'package:todo/widgets/bottom_sheet_button.dart';
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
    return BlocListener<TaskBloc, TaskState>(
      listener: (context, state) {
        if(state.statusTaskDelete?.isSuccess == true){
          context.go(RouterPaths.home);
        }
        else if(state.statusTaskDelete?.isFailed == true){

        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Task Details"),
          actions: [
            RawButton(
                color: Colors.transparent,
                margin: const EdgeInsets.only(right: 8),
                padding: const EdgeInsets.all(8),
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
                            BottomSheetButton(onTap: (){
                              Navigator.pop(context);
                              context.go(RouterPaths.taskEdit(widget.task?.id ?? ""), extra: widget.task);
                            }, label: "Edit", icon: Icons.edit,),
                            BottomSheetButton(onTap: (){
                              Navigator.pop(context);
                              context.read<TaskBloc>().add(DeleteTaskEvent(widget.task?.id ?? ""));
                            }, label: "Delete", icon: Icons.delete,),
                            const SizedBox(height: 24,),
                          ],
                        ),
                      )
                  );
                }),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Expanded(child:
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.task?.dueDate?.toIso8601String() ?? "", style: Theme.of(context).textTheme.bodySmall),
                  const Divider(),
                  Text("Title", style: Theme.of(context).textTheme.titleSmall,),
                  Text(widget.task?.content ?? "", style: Theme.of(context).textTheme.titleMedium,),
                  const SizedBox(height: 12,),
                  Text("Description", style: Theme.of(context).textTheme.titleSmall,),
                  Text(widget.task?.description ?? "", style: Theme.of(context).textTheme.bodyLarge),
                  const SizedBox(height: 24,),
                  const Divider(),
                  Text("Comments (${widget.task?.commentCount ?? 0})", style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 12,),
                  const CommentList(),
                ],
              )),
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
                              hintText: "Add a comment",
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
                                  child: const Icon(Icons.send_rounded,  )),
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
      ),
    );
  }
}


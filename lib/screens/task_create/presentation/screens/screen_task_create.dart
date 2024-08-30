import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo/core/constants/enums.dart';
import 'package:todo/core/utils/utils.dart';
import 'package:todo/screens/home/task_list/domain/entities/task.dart';
import 'package:todo/screens/task_create/presentation/blocs/task_bloc.dart';
import 'package:todo/widgets/bottom_app_bar_container.dart';
import 'package:todo/widgets/bottom_sheet_button.dart';
import 'package:todo/widgets/input_text_form_field.dart';
import 'package:todo/widgets/loading_indicator.dart';
import 'package:todo/widgets/raw_button.dart';


class ScreenTaskCreate extends StatefulWidget {
  static const String routeName = "task_create";
  final Task? task;
  const ScreenTaskCreate({super.key, this.task});

  @override
  State<ScreenTaskCreate> createState() {
    return _ScreenTaskCreateState();
  }
}

class _ScreenTaskCreateState extends State<ScreenTaskCreate> {

  final formKey = GlobalKey<FormState>();
  TextEditingController dateController = TextEditingController();
  FocusNode dateFocusNode = FocusNode();
  TextEditingController statusController = TextEditingController();
  FocusNode statusFocusNode = FocusNode();
  @override
  void initState() {
    super.initState();

    if(widget.task != null){
      dateController.text = widget.task?.dueDate?.toIso8601String() ?? "";
      statusController.text = widget.task?.status.title ?? "";
      context.read<TaskBloc>().add(SetStatusEvent(widget.task?.status ?? TaskStatus.todo));
      context.read<TaskBloc>().add(SetDateEvent(widget.task?.dueDate));
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TaskBloc, TaskState>(
      listener: (context, state){
        if(state.statusTaskCreate?.isSuccess == true){
          context.pop(true);
        }else if(state.statusTaskCreate?.isFailed == true){

        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(title: Text(widget.task != null ? "Update" : "Create"),),
          body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                child: Column(
                  children: [
                    InputTextFormField(
                      initialValue: widget.task?.content,
                      textInputAction: TextInputAction.next,
                      labelText: "Label",
                      hintText: "e.g Make dinner",
                      onChanged: (value){
                        context.read<TaskBloc>().add(SetTitleEvent(value));
                      },
                    ),
                    const SizedBox(height: 12,),
                    InputTextFormField(
                      initialValue: widget.task?.description,
                      textInputAction: TextInputAction.newline,
                      labelText: "Description",
                      hintText: "e.g Enter the steps to prepare dinner",
                      onChanged: (value){
                        context.read<TaskBloc>().add(SetDescriptionEvent(value));
                      },
                    ),
                    const SizedBox(height: 12,),
                    InputTextFormField(
                      focusNode: dateFocusNode,
                      controller: dateController,
                      readOnly: true,
                      labelText: "Due Date",
                      onTap: (){
                        showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day),
                          lastDate: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + 90),
                        ).then((selectedDate) {
                          if (selectedDate != null) {
                            dateController.text = "${selectedDate.year}-${selectedDate.month}-${selectedDate.day}";
                            dateFocusNode.unfocus();
                            setDueDateTime(selectedDate);
                          }
                        });
                      },
                    ),
                    const SizedBox(height: 12,),
                    InputTextFormField(
                      focusNode: statusFocusNode,
                      controller: statusController,
                      readOnly: true,
                      labelText: "Status",
                      onTap: (){
                        showSelectStatusBottomSheet(context, (value){
                          statusController.text = value.title;
                          statusFocusNode.unfocus();
                          context.read<TaskBloc>().add(SetStatusEvent(value));
                        });
                      },
                    ),
                  ],
                ),
              )),
          bottomNavigationBar: BottomNavigationAppBar(
            child: RawButton(
                color: Theme.of(context).primaryColor,
                radius: 8,
                onTap: (){
                  if(widget.task != null){
                    context.read<TaskBloc>().add(const UpdateTaskEvent());
                  }else{
                    context.read<TaskBloc>().add(const CreateTaskEvent());
                  }

                }, child: state.statusTaskCreate?.isLoading == true ? const LoadingIndicator( ) : Center(child: Text(widget.task != null ? "Update": "Create"))),
          ),
        );
      },
    );
  }

  void setDueDateTime(DateTime selectedDate) {
    if (!mounted) return;
    context.read<TaskBloc>().add(SetDateEvent(selectedDate));
  }
}

showSelectStatusBottomSheet(BuildContext context, ValueChanged<TaskStatus> onSelect){
  showCustomBottomSheet(context,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: TaskStatus.values.map((e) =>
              BottomSheetButton(
                  onTap: (){
                    Navigator.pop(context);
                    onSelect(e);
                  },
                  icon: e.icon,
                  label: e.title
              )
          ).toList(),
        ),
      )
  );
}

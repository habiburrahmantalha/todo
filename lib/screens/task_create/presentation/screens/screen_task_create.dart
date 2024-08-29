import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo/router/router.dart';
import 'package:todo/screens/home/task_list/data/models/task.dart';
import 'package:todo/screens/task_create/presentation/blocs/task_bloc.dart';
import 'package:todo/widgets/bottom_app_bar_container.dart';
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
  FocusNode date = FocusNode();
  @override
  void initState() {
    super.initState();

    if(widget.task != null){
      dateController.text = widget.task?.due?.date ?? "";
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
          context.go(RouterPaths.home);
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
                TextFormField(
                  initialValue: widget.task?.content,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    label: const Text("Label"),
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
                  onChanged: (value){
                    context.read<TaskBloc>().add(SetTitleEvent(value));
                  },
                ),
                const SizedBox(height: 12,),
                TextFormField(
                  initialValue: widget.task?.description,
                  textInputAction: TextInputAction.newline,
                  decoration: InputDecoration(
                    label: const Text("Description"),
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
                  onChanged: (value){
                    context.read<TaskBloc>().add(SetDescriptionEvent(value));
                  },
                ),
                const SizedBox(height: 12,),
                TextFormField(
                  focusNode: date,
                  controller: dateController,
                  decoration: InputDecoration(
                    label: const Text("Due Date"),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    suffixIcon: const Icon(Icons.calendar_today),
                  ),
                    readOnly: true,
                  onTap: (){
                    showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day),
                      lastDate: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + 90),
                    ).then((selectedDate) {
                      if (selectedDate != null) {
                        dateController.text = "${selectedDate.year}-${selectedDate.month}-${selectedDate.day}";
                        date.unfocus();
                      }
                    });
                  },
                )
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
}

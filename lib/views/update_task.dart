import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zain_api/models/task.dart';
import 'package:zain_api/providers/user.dart';
import 'package:zain_api/services/auth.dart';
import 'package:zain_api/services/task.dart';
import 'package:zain_api/views/get_all_task.dart';
import 'package:zain_api/views/profile.dart';
import 'package:zain_api/views/register.dart';

class UpdateTaskView extends StatefulWidget {
  final Task model;

  const UpdateTaskView({super.key, required this.model});

  @override
  State<UpdateTaskView> createState() => _UpdateTaskViewState();
}

class _UpdateTaskViewState extends State<UpdateTaskView> {
  TextEditingController descriptionController = TextEditingController();
  bool isLoading = false;

  @override
  void initState() {
    descriptionController =
        TextEditingController(text: widget.model.description.toString());
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Task"),
      ),
      body: Column(
        children: [
          TextField(
            controller: descriptionController,
          ),
          SizedBox(
            height: 20,
          ),
          isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : ElevatedButton(
                  onPressed: () async {
                    if (descriptionController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("Description cannot be empty.")));
                      return;
                    }
                    try {
                      isLoading = true;
                      setState(() {});
                      await TaskServices()
                          .updateTask(
                              description: descriptionController.text,
                              taskID: widget.model.id.toString(),
                              token: userProvider.getToken().toString())
                          .then((val) {
                        isLoading = false;
                        setState(() {});
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text("Message"),
                                content:
                                    Text("Task has been updated successfully"),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    GetAllTaskView()));
                                      },
                                      child: Text("Okay"))
                                ],
                              );
                            });
                      });
                    } catch (e) {
                      isLoading = false;
                      setState(() {});
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text(e.toString())));
                    }
                  },
                  child: Text("Update Task")),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}

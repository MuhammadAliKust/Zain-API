import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zain_api/models/task.dart';
import 'package:zain_api/models/task_listing.dart';
import 'package:zain_api/providers/user.dart';
import 'package:zain_api/services/task.dart';

class GetCompletedTaskView extends StatelessWidget {
  const GetCompletedTaskView({super.key});

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Get Completed Task"),
      ),
      body: FutureProvider.value(
        value:
            TaskServices().getCompletedTask(userProvider.getToken().toString()),
        initialData: TaskListingModel(),
        builder: (context, child) {
          TaskListingModel taskListingModel = context.watch<TaskListingModel>();
          return taskListingModel.tasks == null
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  itemCount: taskListingModel.tasks!.length,
                  itemBuilder: (context, i) {
                    return ListTile(
                      leading: Icon(Icons.task),
                      title: Text(
                          taskListingModel.tasks![i].description.toString()),
                    );
                  });
        },
      ),
    );
  }
}

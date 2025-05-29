import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zain_api/models/task.dart';
import 'package:zain_api/models/task_listing.dart';
import 'package:zain_api/services/task.dart';
import 'package:zain_api/views/create_task.dart';
import 'package:zain_api/views/get_completed_task.dart';
import 'package:zain_api/views/get_inCompleted_task.dart';

import '../providers/user.dart';

class GetAllTaskView extends StatelessWidget {
  const GetAllTaskView({super.key});

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Get All Task"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => GetCompletedTaskView()));
              },
              icon: Icon(Icons.circle)),
          IconButton(onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => GetInCompletedTaskView()));

          }, icon: Icon(Icons.incomplete_circle)),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => CreateTaskView()));
        },
        child: Icon(Icons.add),
      ),
      body: FutureProvider.value(
        value: TaskServices().getAllTask(userProvider.getToken().toString()),
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

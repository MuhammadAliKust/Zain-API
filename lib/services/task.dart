import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:zain_api/models/task.dart';
import 'package:zain_api/models/task_listing.dart';

class TaskServices {
  String baseURL = "https://todo-nu-plum-19.vercel.app";

  ///Create Task
  Future<TaskModel> createTask(
      {required String token, required String description}) async {
    try {
      http.Response response = await http.post(Uri.parse('$baseURL/todos/add'),
          headers: {'Content-Type': 'application/json', 'Authorization': token},
          body: jsonEncode({"description": description}));

      if (response.statusCode == 200 || response.statusCode == 201) {
        return TaskModel.fromJson(jsonDecode(response.body));
      } else {
        throw response.reasonPhrase.toString();
      }
    } catch (e) {
      throw e.toString();
    }
  }

  ///Get All Task
  Future<TaskListingModel> getAllTask(String token) async {
    try {
      http.Response response = await http.get(Uri.parse('$baseURL/todos/get'),
          headers: {'Authorization': token});

      if (response.statusCode == 200 || response.statusCode == 201) {
        return TaskListingModel.fromJson(jsonDecode(response.body));
      } else {
        throw response.reasonPhrase.toString();
      }
    } catch (e) {
      throw e.toString();
    }
  }

  ///Get Completed Task
  Future<TaskListingModel> getCompletedTask(String token) async {
    try {
      http.Response response = await http.get(
          Uri.parse('$baseURL/todos/completed'),
          headers: {'Authorization': token});

      if (response.statusCode == 200 || response.statusCode == 201) {
        return TaskListingModel.fromJson(jsonDecode(response.body));
      } else {
        throw response.reasonPhrase.toString();
      }
    } catch (e) {
      throw e.toString();
    }
  }

  ///Get InCompleted Task

  Future<TaskListingModel> getInCompletedTask(String token) async {
    try {
      http.Response response = await http.get(
          Uri.parse('$baseURL/todos/incomplete'),
          headers: {'Authorization': token});

      if (response.statusCode == 200 || response.statusCode == 201) {
        return TaskListingModel.fromJson(jsonDecode(response.body));
      } else {
        throw response.reasonPhrase.toString();
      }
    } catch (e) {
      throw e.toString();
    }
  }

  ///Search Task
  Future<TaskListingModel> searchTask(
      {required String token, required String searchTask}) async {
    try {
      http.Response response = await http.get(
          Uri.parse('$baseURL/todos/search?keywords=$searchTask'),
          headers: {'Authorization': token});

      if (response.statusCode == 200 || response.statusCode == 201) {
        return TaskListingModel.fromJson(jsonDecode(response.body));
      } else {
        throw response.reasonPhrase.toString();
      }
    } catch (e) {
      throw e.toString();
    }
  }

  ///Filter Task
  Future<TaskListingModel> filterTask(
      {required String token,
      required String startDate,
      required String endDate}) async {
    try {
      http.Response response = await http.get(
          Uri.parse(
              '$baseURL/todos/filter?startDate=$startDate&endDate=$endDate'),
          headers: {'Authorization': token});

      if (response.statusCode == 200 || response.statusCode == 201) {
        return TaskListingModel.fromJson(jsonDecode(response.body));
      } else {
        throw response.reasonPhrase.toString();
      }
    } catch (e) {
      throw e.toString();
    }
  }
}

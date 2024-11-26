import 'package:flutter/material.dart';
import '../models/task.dart';
import '../services/task_storage.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController taskController = TextEditingController();
  final List<Task> tasks = [];
  int selectedPriority = 2;

  @override
  void initState() {
    super.initState();
    TaskStorage.loadTasks().then((loadedTasks) {
      setState((){
        tasks.addAll(loadedTasks);
      });
      print("Loaded tasks: $loadedTasks");
    });
  }

  void addTask() {
    if (taskController.text.isNotEmpty) {
      setState(() {
        tasks.add(Task(
          title: taskController.text,
          priority: selectedPriority,
        ));
        taskController.clear();
        selectedPriority = 2;
      });
      TaskStorage.saveTasks(tasks);
    }
  }

  void deleteTask(int index) {
    setState(() {
      tasks.removeAt(index);
    });
    TaskStorage.saveTasks(tasks);
  }

  void deleteCompletedTasks() {
    setState(() {
      tasks.removeWhere((task) => task.isCompleted);
    });
    TaskStorage.saveTasks(tasks);
  }

  void editTask(int index) {
    final TextEditingController editController =
    TextEditingController(text: tasks[index].title);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Task'),
          content: TextField(
            maxLines: null,
            controller: editController,
            decoration: InputDecoration(
              labelText: 'Edit your task',
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  tasks[index].title = editController.text;
                });
                Navigator.pop(context);
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
    TaskStorage.saveTasks(tasks);
  }

  void toggleTaskCompletion(int index) {
    setState(() {
      tasks[index].isCompleted = !tasks[index].isCompleted;
    });
    TaskStorage.saveTasks(tasks);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar('To-do List'),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                InputField(controller: taskController),
                SizedBox(width: 8),
                Priority(
                  selectedPriority: selectedPriority,
                  onChanged: (value) {
                    setState(() {
                      selectedPriority = value!;
                    });
                  },
                ),
                SizedBox(width: 8.0),
                AddButton(onpressed: addTask),
              ],
            ),
          ),
          SizedBox(height: 16),
          TaskList(
            tasks: tasks,
            toggleTaskCompletion: toggleTaskCompletion,
            deleteTask: deleteTask,
            editTask: editTask,),
          DeleteCompletedButton(onpressed: deleteCompletedTasks),
        ],
      ),
    );
  }

  PreferredSizeWidget buildAppBar(String title) {
    return AppBar(
      backgroundColor: Colors.blue,
      title: Text(
        title,
        style: TextStyle(
          fontSize: 40.0,
          fontWeight: FontWeight.w800,
          color: Colors.white,
        ),
      ),
      centerTitle: true,
    );
  }
}


class InputField extends StatelessWidget {
  final TextEditingController controller;

  const InputField({
    required this.controller,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextField(
        controller: controller,
        maxLines: null,
        keyboardType: TextInputType.multiline,
        decoration: InputDecoration(
          labelText: 'Add a new task',
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}


class Priority extends StatelessWidget {
  final int selectedPriority;
  final ValueChanged<int?> onChanged;

  const Priority({
    required this.selectedPriority,
    required this.onChanged,
    super.key});

  @override
  Widget build(BuildContext context) {
    return DropdownButton<int>(
      value: selectedPriority,
      items: [
        DropdownMenuItem(
          value: 1,
          child: Text('High'),
        ),
        DropdownMenuItem(
          value: 2,
          child: Text('Medium'),
        ),
        DropdownMenuItem(
          value: 3,
          child: Text('Low'),
        ),
      ],
      onChanged: onChanged,
    );
  }
}


class AddButton extends StatelessWidget {
  final VoidCallback onpressed;

  const AddButton({
    required this.onpressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 10,
        ),
      ),
      onPressed: onpressed,
      child: Text('Add'),
    );
  }
}

class TaskList extends StatelessWidget {

  final List<Task> tasks;
  final ValueChanged<int> toggleTaskCompletion;
  final ValueChanged<int> deleteTask;
  final ValueChanged<int> editTask;

  const TaskList({
    required this.tasks,
    required this.toggleTaskCompletion,
    required this.deleteTask,
    required this.editTask,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: tasks.isEmpty
          ? Center(
        child: Text('Nothing Yet!'),
      )
          : ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.symmetric(
              vertical: 8.0,
              horizontal: 16.0,
            ),
            elevation: 4.0,
            child: ListTile(
              leading: Checkbox(
                value: tasks[index].isCompleted,
                onChanged: (value) {
                  toggleTaskCompletion(index);
                },
              ),
              title: Row(
                children: [
                  Icon(
                    Icons.flag,
                    color: tasks[index].priority == 1
                        ? Colors.red
                        : tasks[index].priority == 2
                        ? Colors.orange
                        : Colors.yellow,
                  ),
                  SizedBox(width: 8.0),
                  Expanded(
                    child: Text(
                      tasks[index].title,
                      maxLines: null,
                      style: TextStyle(
                        fontSize: 16.0,
                        decoration: tasks[index].isCompleted
                            ? TextDecoration.lineThrough
                            : null,
                      ),
                    ),
                  ),
                ],
              ),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                color: Colors.red,
                onPressed: () => deleteTask(index),
              ),
              onTap: () => editTask(index),
            ),
          );
        },
      ),
    );
  }
}

class DeleteCompletedButton extends StatelessWidget {

  final VoidCallback onpressed;

  const DeleteCompletedButton({
    required this.onpressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.0),
      child: ElevatedButton(
        onPressed: onpressed,
        child: Text('Delete Completed Tasks'),
      ),
    );
  }
}

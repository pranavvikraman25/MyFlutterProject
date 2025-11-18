import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/task_model.dart';
import '../widgets/task_tile.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final taskBox = Hive.box<TaskModel>("tasksBox");

  final TextEditingController controller = TextEditingController();

  void addTask() {
    if (controller.text.trim().isNotEmpty) {
      taskBox.add(TaskModel(title: controller.text.trim()));
      controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Tasks"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    decoration: const InputDecoration(
                      hintText: "Enter task...",
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: addTask,
                ),
              ],
            ),
          ),
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: taskBox.listenable(),
              builder: (context, Box<TaskModel> box, _) {
                if (box.values.isEmpty) {
                  return const Center(child: Text("No tasks yet"));
                }

                return ListView.builder(
                  itemCount: box.length,
                  itemBuilder: (_, index) {
                    final task = box.getAt(index);
                    return TaskTile(
                      task: task!,
                      onChanged: (value) {
                        task.isDone = value!;
                        task.save();
                      },
                      onDelete: () {
                        box.deleteAt(index);
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

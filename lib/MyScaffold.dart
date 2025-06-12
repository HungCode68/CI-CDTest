import "package:flutter/material.dart";

class MyScaffold extends StatelessWidget {
  const MyScaffold({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hello Hung Coder"),
      ),

      body: Center(child : Text("abc"),),
      floatingActionButton: FloatingActionButton(onPressed: (){print("pressed");},
          child: const Icon(Icons.add_a_photo),

      ),
      bottomNavigationBar: BottomNavigationBar(items: [
        BottomNavigationBarItem(icon: Icon(Icons.backpack), label: "Quay Lại"),
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.list), label: "Option"),

      ]),

    );
  }
}

import 'package:flutter/material.dart'; 

void main() {
  runApp(const ListTitleApp());
}

class ListTitleApp extends StatelessWidget {
  const ListTitleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: ListTitleExample());  
  }
}

class ListTitleExample extends StatefulWidget{
  const ListTitleExample({super.key});

  @override
  State<ListTitleExample> createState() => _ListTitleExampleState();
}

class _ListTitleExampleState extends State<ListTitleExample>{
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: const Text('ListTile Example')),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder:(BuildContext context, int index){
          return ListTile(
            leading: const Icon(Icons.person),
            title: Text('Item $index'),
            trailing: index == _selectedIndex
                ? const Icon(Icons.check_circle)
                : const Icon(Icons.radio_button_unchecked),
            selected: index == _selectedIndex,
            selectedTileColor: Colors.blue.withOpacity(0.3),
            onTap: () {
              setState(() {
                _selectedIndex = index;
              });
            },
          );
        },
      ),
    );
  }
}

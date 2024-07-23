import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lesson6/controller/inventory_controller.dart';
import 'package:lesson6/model/inventory_item_model.dart';

class InventoryScreen extends StatefulWidget {
  const InventoryScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return InventoryScreenState();
  }
}

class InventoryScreenState extends State<InventoryScreen> {
  late InventoryController controller;
  final TextEditingController itemNameController = TextEditingController();
  Map<String, bool> itemEditing = {};
  Map<String, int> tempQuantities = {};

  @override
  void initState() {
    super.initState();
    final firestore = FirebaseFirestore.instance;
    final user = FirebaseAuth.instance.currentUser!;
    controller = InventoryController(firestore, user);
    debugPrint('User ID: ${user.uid}');
  }

  void _addItem() async {
    final name = itemNameController.text;
    if (name.length < 2) {
      _showSnackbar('Item name must be at least 2 characters long');
      return;
    }
    try {
      await controller.addItem(name);
      itemNameController.clear();
      _showSnackbar('Item added successfully!');
    } catch (e) {
      _showSnackbar(e.toString());
    }
  }

  void _updateItem(String id, int quantity) {
    setState(() {
      tempQuantities[id] = quantity;
    });
  }

  void _confirmUpdateItem(InventoryItem item) async {
    final newQuantity = tempQuantities[item.id] ?? item.quantity;
    try {
      await controller.updateItem(item.id, newQuantity);
      setState(() {
        itemEditing[item.id] = false;
      });
      _showSnackbar('Item updated successfully!');
    } catch (e) {
      _showSnackbar(e.toString());
    }
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  void _showAddItemDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.lightGreenAccent.shade100, // Pastel green
          title: const Text('Create a New Item'),
          content: TextField(
            controller: itemNameController,
            decoration: InputDecoration(
              labelText: 'Item Name',
              filled: true,
              fillColor: Colors.lightGreenAccent.shade100, // Pastel green
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
              style: TextButton.styleFrom(
                foregroundColor: Colors.black,
                backgroundColor: Colors.white, // White background
              ),
            ),
            TextButton(
              onPressed: () {
                _addItem();
                Navigator.of(context).pop();
              },
              child: const Text('Confirm'),
              style: TextButton.styleFrom(
                foregroundColor: Colors.black,
                backgroundColor: Colors.white, // White background
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inventory'),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<List<InventoryItem>>(
              stream: controller.getItems(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No items found.'));
                }
                final items = snapshot.data!;
                return ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index];
                    final isEditing = itemEditing[item.id] ?? false;
                    final currentQuantity = tempQuantities[item.id] ?? item.quantity;
                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                      decoration: BoxDecoration(
                        color: isEditing ? Colors.white : Colors.lightGreenAccent.shade100, // White background in editing mode
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: GestureDetector(
                        onLongPress: () {
                          setState(() {
                            itemEditing[item.id] = true;
                            tempQuantities[item.id] = item.quantity;
                          });
                        },
                        child: ListTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${item.name} (qty: $currentQuantity)',
                                style: TextStyle(
                                  color: isEditing ? Colors.lightBlue : Colors.black, // Light blue text color in editing mode
                                ),
                              ),
                              if (isEditing)
                                Row(
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.remove),
                                      color: Colors.lightBlue, // Light blue icon color in editing mode
                                      onPressed: currentQuantity > 0 ? () => _updateItem(item.id, currentQuantity - 1) : null,
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.add),
                                      color: Colors.lightBlue, // Light blue icon color in editing mode
                                      onPressed: () => _updateItem(item.id, currentQuantity + 1),
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.close),
                                      color: Colors.lightBlue, // Light blue icon color in editing mode
                                      onPressed: () {
                                        setState(() {
                                          itemEditing[item.id] = false;
                                          tempQuantities[item.id] = item.quantity;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                            ],
                          ),
                          trailing: isEditing
                              ? IconButton(
                                  icon: const Icon(Icons.done),
                                  color: Colors.lightBlue, // Light blue icon color in editing mode
                                  onPressed: () => _confirmUpdateItem(item),
                                )
                              : null,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddItemDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddUser extends StatefulWidget {
  const AddUser({super.key});

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  final ScrollController _scrollController = ScrollController();
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void _add() async {
    String name = _nameController.text.trim();
    String email = _emailController.text.trim();
    String address = _addressController.text.trim();
    DateTime registrationDate = DateTime.now();

    try {
      await _firestore.collection('users').add({
        'name': name,
        'email': email,
        'address': address,
        'date': registrationDate,
      });
      _scrollController.animateTo(
      0.0,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );

      // Show registration success message or navigate to another screen
      print('Registration successful');
    } catch (e) {
      // Handle registration failure
      print('Error registering user: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    prefixIcon: Icon(Icons.person),
                  ),
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.email),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  controller: _addressController,
                  decoration: InputDecoration(
                    labelText: 'Address',
                    prefixIcon: Icon(Icons.location_on),
                  ),
                ),
                SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: _add,
                  child: Text('Add User'),
                ),
              ],
            ),
            Expanded(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .orderBy('date', descending: false)
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Center(child: Text('No users'));
                  } else {
                    return ListView.builder(
                      controller: _scrollController,
                      reverse: true,
                      itemCount: snapshot.data?.docs.length,
                      itemBuilder: (context, index) {
                        var message = snapshot.data?.docs[index];
                        Timestamp timestamp = message?['date'];
                        DateTime dateTime = timestamp.toDate();
                        String formattedDate =
                            DateFormat('dd MMMM yyyy').format(dateTime);
                        return Card(
                          child: ListTile(
                            title: Text('${message?['name']} ( ${message?['address']})'),
                            leading: Text('${index+1}'),
                            subtitle: Text('${message?['email']}'),
                            trailing: Text(formattedDate),
                            // Display other message details as needed
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

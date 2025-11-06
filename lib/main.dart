import 'package:flutter/material.dart';
import 'database_helper.dart';
import 'models/password.dart';

void main() {
  runApp(PasswordManagerApp());
}

class PasswordManagerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Password Management',
      home: PasswordListScreen(),
    );
  }
}

class PasswordListScreen extends StatefulWidget {
  @override
  _PasswordListScreenState createState() => _PasswordListScreenState();
}

class _PasswordListScreenState extends State<PasswordListScreen> {
  final dbHelper = DatabaseHelper();
  List<Password> passwordList = [];

  @override
  void initState() {
    super.initState();
    _refreshPasswordList();
  }

  void _refreshPasswordList() async {
    final data = await dbHelper.getPasswords();
    setState(() {
      passwordList = data;
    });
  }

  void _addOrUpdatePassword({Password? password}) {
    final titleController = TextEditingController(text: password?.title);
    final usernameController = TextEditingController(text: password?.username);
    final passwordController = TextEditingController(text: password?.password);

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(password == null ? 'Tambah Password' : 'Edit Password'),
        content: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: 'Title'),
              ),
              TextField(
                controller: usernameController,
                decoration: InputDecoration(labelText: 'Username'),
              ),
              TextField(
                controller: passwordController,
                decoration: InputDecoration(labelText: 'Password'),
              ),
            ],
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () async {
              final newPassword = Password(
                id: password?.id,
                title: titleController.text,
                username: usernameController.text,
                password: passwordController.text,
              );

              if (password == null) {
                await dbHelper.insertPassword(newPassword);
              } else {
                await dbHelper.updatePassword(newPassword);
              }

              Navigator.of(context).pop();
              _refreshPasswordList();
            },
            child: Text(password == null ? 'Tambah' : 'Simpan'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Batal')
          ),
        ],
      ),
    );
  }

  void _deletePassword(int id) async {
    await dbHelper.deletePassword(id);
    _refreshPasswordList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Password Management')),
      body: ListView.builder(
        itemCount: passwordList.length,
        itemBuilder: (context, index) {
          final item = passwordList[index];
          return ListTile(
            title: Text(item.title),
            subtitle: Text(item.username),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () => _addOrUpdatePassword(password: item),
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => _deletePassword(item.id!),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addOrUpdatePassword(),
        child: Icon(Icons.add),
      ),
    );
  }
}
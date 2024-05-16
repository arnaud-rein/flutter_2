import 'package:flutter/material.dart';
import '../api/user_api.dart';
import '../model/user_model.dart';
import '../widgets/myscaffold.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key});
  @override
  State<StatefulWidget> createState() {
    return _UserListScreenState();
  }
}

class _UserListScreenState extends State<UserListScreen> {
  late Future<List<UserModel>> futureUsers;

  @override
  void initState() {
    super.initState();
    futureUsers = UserApi().fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      name: 'User List',
      body: FutureBuilder<List<UserModel>>(
        future: futureUsers,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erreur: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Aucun utilisateur trouvé.'));
          } else {
            List<UserModel> users = snapshot.data!;
            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                UserModel user = users[index];
                return ListTile(
                  title: Text('${user.firstName} ${user.lastName}'),
                  subtitle: Text(user.email),
                  onTap: () {
                    // Action à réaliser lors du clic sur un utilisateur
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}

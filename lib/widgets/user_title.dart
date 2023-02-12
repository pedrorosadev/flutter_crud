import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_crud/provider/users.dart';
import 'package:flutter_crud/routes/app_routes.dart';
import 'package:provider/provider.dart';
import '../models/user.dart';

class UserTile extends StatelessWidget {
  final User? user;

  const UserTile({super.key, this.user});

  @override
  Widget build(BuildContext context) {
    final avatar = user?.avatarURL == ""
        ? const CircleAvatar(
            child: Icon(Icons.person),
          )
        : CircleAvatar(backgroundImage: NetworkImage(user!.avatarURL));
    return ListTile(
      leading: avatar,
      title: Text(user!.name),
      subtitle: Text(user!.email),
      trailing: Container(
        width: 100,
        child: Row(
          children: <Widget>[
            IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(
                  AppRoutes.USER_FORM,
                  arguments: user,
                );
              },
              color: Colors.orange,
              icon: const Icon(Icons.edit),
            ),
            IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Excluir Usuário'),
                    content: const Text('Tem certeza?'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(false),
                        child: const Text('Não'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(true),
                        child: const Text('Sim'),
                      ),
                    ],
                  ),
                ).then((confirmed) => {
                      if (confirmed)
                        {
                          Provider.of<UsersProvider>(context, listen: false)
                              .delete(user!)
                        }
                    });
              },
              color: Colors.red,
              icon: const Icon(Icons.delete),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class DeleteWidget extends StatelessWidget {
  const DeleteWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Eliminar usuario'),
      content: const Text('Seguro desea eliminar el usuario?'),
      actions: [
        TextButton(
          child: Text('Aceptar',
              style: TextStyle(color: Theme.of(context).primaryColor)),
          onPressed: () {
            Navigator.pop(context, true);
          },
        ),
        TextButton(
          child:
              const Text('Cancelar', style: TextStyle(color: Colors.black54)),
          onPressed: () {
            Navigator.pop(context, false);
          },
        ),
      ],
    );
  }
}

import 'package:first_flutter_bloc/models/models.dart';
import 'package:first_flutter_bloc/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';

class NewUserScreen extends StatefulWidget {
  static String routeName = 'new_user';

  const NewUserScreen({super.key});

  @override
  State<NewUserScreen> createState() => _NewUserScreenState();
}

class _NewUserScreenState extends State<NewUserScreen> {
  final TextEditingController _nameTextEditingController =
      TextEditingController();
  final TextEditingController _emailTextEditingController =
      TextEditingController();

  late bool _errorName = false;
  late bool _errorEmail = false;
  late bool _errorSex = false;
  late bool _errorStatus = false;

  final List<ItemDropdown> listSex = [
    const ItemDropdown(label: 'Femenino', value: 'female'),
    const ItemDropdown(label: 'Masculino', value: 'male'),
  ];
  final List<ItemDropdown> listStatus = [
    const ItemDropdown(label: 'Activo', value: 'active'),
    const ItemDropdown(label: 'Inactivo', value: 'inactive'),
  ];

  ItemDropdown? _selectSex, _selectStatus;

  @override
  void dispose() {
    _nameTextEditingController.dispose();
    _emailTextEditingController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nuevo usuario'),
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(Icons.arrow_back_ios_rounded),
        ),
        actions: [
          Container(
            padding: const EdgeInsets.only(right: 10.0),
            child: Center(
              child: GestureDetector(
                onTap: () => {},
                child: const Text(
                  'Guardar',
                  style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextFieldWidget(
              label: 'Nombre',
              controller: _nameTextEditingController,
              icon: Icons.person,
              error: _errorName,
            ),
            const SizedBox(height: 10.0),
            TextFieldWidget(
              label: 'Correo',
              controller: _emailTextEditingController,
              icon: Icons.email,
              keyboardType: TextInputType.emailAddress,
              error: _errorEmail,
            ),
            const SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DropdownWidget(
                  label: 'Género',
                  list: listSex,
                  error: _errorSex,
                  onSelect: (select) {
                    _selectSex = select;
                  },
                ),
                DropdownWidget(
                  label: 'Estado',
                  list: listStatus,
                  error: _errorStatus,
                  onSelect: (select) {
                    _selectStatus = select;
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:first_flutter_bloc/blocs/blocs.dart';
import 'package:first_flutter_bloc/models/models.dart';
import 'package:first_flutter_bloc/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

  void _save() {
    var band = false;

    if (_validName(_nameTextEditingController.text)) {
      band = true;
    }

    if (_validEmail(_emailTextEditingController.text)) {
      band = true;
    }

    // Validar genero
    if (_selectSex == null) {
      setState(() {
        _errorSex = true;
      });
      band = true;
    } else {
      setState(() {
        _errorSex = false;
      });
    }

    if (_selectStatus == null) {
      setState(() {
        _errorStatus = true;
      });
      band = true;
    } else {
      setState(() {
        _errorStatus = false;
      });
    }

    if (band) return;

    final user = UserModel(
        name: _nameTextEditingController.text.trim(),
        email: _emailTextEditingController.text.trim(),
        gender: _selectSex!.value,
        status: _selectStatus!.value);
    context.read<UsersBloc>().add(SaveUser(user: user));
  }

  @override
  void dispose() {
    _nameTextEditingController.dispose();
    _emailTextEditingController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UsersBloc, UsersState>(
      builder: (context, state) {
        if(state.error != '') {
          Future.delayed(Duration.zero, () {
            context.read<UsersBloc>().add(UsersInit());
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.error),
              backgroundColor: Theme.of(context).primaryColor,));
          });
        }
        if (state.add) {
          Future.delayed(Duration.zero, () {
            context.read<UsersBloc>()
              ..add(UsersInit())
              ..add(GetAllUsers());
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Added User'),
              backgroundColor: Colors.green,
            ));
            Navigator.pop(context);
          });
        }
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
                  child: state.loading
                    ? const Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.green,
                      ),
                    )
                    : GestureDetector(
                    onTap: () => _save(),
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
      },
    );
  }

  bool _validName(String value) {
    if (value.isEmpty || value == null) {
      setState(() {
        _errorName = true;
      });
      return true;
    }
    setState(() {
      _errorName = false;
    });
    return false;
  }

  bool _validEmail(String value) {
    var band = false;
    var reg = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (value.isEmpty || value == null) {
      band = true;
    } else if (!reg.hasMatch(value)) {
      band = true;
    }

    if (band) {
      setState(() {
        _errorEmail = true;
      });
      return true;
    }
    setState(() {
      _errorEmail = false;
    });
    return false;
  }
}

import 'package:boaty/src/globals/boaty/boaty.dart';
import 'package:boaty/src/models/user.dart';
import 'package:boaty/src/services/auth_service.dart';
import 'package:boaty/src/services/services.dart';
import 'package:flutter/material.dart';
import 'package:boaty/src/globals/logo/boaty_logo.dart';
import 'package:boaty/src/globals/widgets/regular_button.dart';
import 'package:boaty/src/globals/widgets/widgets.dart';
import 'package:boaty/src/pages/auth/register/dropdowns/register_dropdowns.dart';
import 'package:boaty/src/providers/auth_form_provider.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class EditPerfilPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Boaty.backAppBar,
      body: ChangeNotifierProvider(
        create: (_) => RegisterFormProvider(),
        child: EditPerfilForm(),
      ),
    );
  }
}

class EditPerfilForm extends StatefulWidget {
  @override
  _EditPerfilFormState createState() => _EditPerfilFormState();
}

class _EditPerfilFormState extends State<EditPerfilForm> {
  String paisSeleccionado =  RegisterDropdowns.getCountries().first;

  @override
  Widget build(BuildContext context) {
    final authService = new AuthService();
    final editPerfilForm = Provider.of<RegisterFormProvider>(context);
    BoatyUser user = authService.readUser();

    return Container(
      child: Form(
        key: editPerfilForm.formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: BoatyLogo.fullBig,
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: ListView(
                      physics: BouncingScrollPhysics(),
                      shrinkWrap: true,
                      children: [
                        InputContainerWidget(
                          input: DropdownButton<String>(
                            icon: Icon(Icons.keyboard_arrow_down_outlined),
                            isExpanded: true,
                            underline: SizedBox(),
                            onChanged: (select) {
                              paisSeleccionado = select!;
                              editPerfilForm.address = paisSeleccionado;
                              setState(() {});
                            },
                            value: paisSeleccionado,
                            items: RegisterDropdowns.paisesToItems,
                          ),
                          validator:
                            paisSeleccionado != 'País' ?
                              editPerfilForm.paisValidator(paisSeleccionado) :
                              null,
                        ),
                        InputContainerWidget(
                          input: TextFormField(
                            initialValue: user.phone,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'CEL/TEL',
                              border: InputBorder.none,
                            ),
                            onChanged: (value) {
                              editPerfilForm.phone = value;
                              setState(() {});
                            },
                          ),
                          validator:
                            editPerfilForm.phone.length > 0 ?
                              editPerfilForm.phoneValidator(editPerfilForm.phone) :
                              null,
                        ),
                        InputContainerWidget(
                          input: TextFormField(
                            initialValue: user.firstName,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              labelText: 'Nombre',
                              border: InputBorder.none,
                            ),
                            onChanged: (value) {
                              editPerfilForm.firstName = value;
                              setState(() {});
                            },
                          ),
                          validator:
                            editPerfilForm.firstName.length > 0 ? 
                              editPerfilForm.firstNameValidator(editPerfilForm.firstName) :
                              null,
                        ),
                        InputContainerWidget(
                          input: TextFormField(
                            initialValue: user.lastName,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              labelText: 'Apellido',
                              border: InputBorder.none,
                            ),
                            onChanged: (value) {
                              editPerfilForm.lastName = value;
                              setState(() {});
                            },
                          ),
                          validator:
                            editPerfilForm.lastName.length > 0 ?
                              editPerfilForm.lastNameValidator(editPerfilForm.lastName) :
                              null,
                        ),
                        InputContainerWidget(
                          input: TextFormField(
                            initialValue: user.email,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              labelText: 'Email',
                              border: InputBorder.none,
                            ),
                            onChanged: (value) {
                              editPerfilForm.email = value;
                              setState(() {});
                            },
                          ),
                          validator:
                            editPerfilForm.email.length > 0 ?
                              editPerfilForm.emailValidator(editPerfilForm.email) :
                              null,
                        ),
                        InputContainerWidget(
                          input: GestureDetector(
                            onTap: () {
                              showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.utc(1990, 1, 1),
                                lastDate: DateTime.utc(2100, 1, 1),
                                // locale: Locale('es'),
                              ).then((value) {
                                if(value != null) {
                                  setState(() {
                                      editPerfilForm.birthday = value;
                                  });
                                }
                              });
                            },
                            child: AbsorbPointer(
                              child: TextFormField(
                                decoration: InputDecoration(
                                  labelText: editPerfilForm.birthday != ''
                                      ? DateFormat('dd-MM-yyyy')
                                          .format(
                                            editPerfilForm.birthday is DateTime ?
                                            editPerfilForm.birthday :
                                            DateTime.parse(editPerfilForm.birthday)
                                          )
                                          .toString()
                                      : 'Fecha de nacimiento',
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                          validator:    
                            editPerfilForm.birthday != '' ?
                              editPerfilForm.birthdayValidator(editPerfilForm.birthday) :
                              null,
                        ),
                        RegularButton(
                          onPressed: editPerfilForm.isLoading
                              ? null
                              : () async {
                                  FocusScope.of(context).unfocus();

                                  editPerfilForm.isLoading = true;

                                  final authService = Provider.of<AuthService>(
                                      context,
                                      listen: false);

                                  editPerfilForm.firstName = editPerfilForm.firstName != '' ? editPerfilForm.firstName : user.firstName.toString();
                                  editPerfilForm.lastName = editPerfilForm.lastName != '' ? editPerfilForm.lastName : user.lastName.toString();
                                  editPerfilForm.phone = editPerfilForm.phone != '' ? editPerfilForm.phone : user.phone.toString();
                                  editPerfilForm.address = editPerfilForm.address != '' ? editPerfilForm.address : user.address.toString();
                                  editPerfilForm.birthday = editPerfilForm.birthday != '' ? editPerfilForm.birthday : user.birthday.toString();
                                  editPerfilForm.email = editPerfilForm.email != '' ? editPerfilForm.email : user.email.toString();

                                  final String? errorMessage = await authService.updateAccount(
                                    editPerfilForm.firstName, 
                                    editPerfilForm.lastName, 
                                    editPerfilForm.phone, 
                                    editPerfilForm.address, 
                                    editPerfilForm.birthday, 
                                    editPerfilForm.email
                                  );

                                  if (errorMessage == null) {
                                    Navigator.pop(context);
                                  } else {
                                    NotificationsService.showSnacbar(
                                        errorMessage);
                                    editPerfilForm.isLoading = false;
                                  }
                                },
                          title: editPerfilForm.isLoading
                              ? 'Guardando...'
                              : 'Guardar',
                          padding: EdgeInsets.only(top: 24.0),
                          innerPadding: EdgeInsets.all(16.0),
                        ),
                        SizedBox(
                          height: 36.0,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
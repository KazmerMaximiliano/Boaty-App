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

class FinishRegisterForm extends StatefulWidget {
  @override
  _FinishRegisterFormState createState() => _FinishRegisterFormState();
}

class _FinishRegisterFormState extends State<FinishRegisterForm> {
  String paisSeleccionado = RegisterDropdowns.getCountries().first;

  @override
  Widget build(BuildContext context) {
    final registerForm = Provider.of<RegisterFormProvider>(context);

    return Container(
      child: Form(
        key: registerForm.formKey,
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
                              registerForm.address = paisSeleccionado;
                              setState(() {});
                            },
                            value: paisSeleccionado,
                            items: RegisterDropdowns.paisesToItems,
                          ),
                          validator:
                            paisSeleccionado != 'País' ?
                              registerForm.paisValidator(paisSeleccionado) :
                              null,
                        ),
                        InputContainerWidget(
                          input: TextFormField(
                            keyboardType: TextInputType.numberWithOptions(signed: true),
                            decoration: InputDecoration(
                              labelText: 'CEL/TEL',
                              border: InputBorder.none,
                            ),
                            onChanged: (value) {
                              registerForm.phone = value;
                              setState(() {});
                            },
                          ),
                          validator:
                            registerForm.phone.length > 0 ?
                              registerForm.phoneValidator(registerForm.phone) :
                              null,
                        ),
                        InputContainerWidget(
                          input: TextFormField(
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              labelText: 'Nombre',
                              border: InputBorder.none,
                            ),
                            onChanged: (value) {
                              registerForm.firstName = value;
                              setState(() {});
                            },
                          ),
                          validator:
                            registerForm.firstName.length > 0 ? 
                              registerForm.firstNameValidator(registerForm.firstName) :
                              null,
                        ),
                        InputContainerWidget(
                          input: TextFormField(
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              labelText: 'Apellido',
                              border: InputBorder.none,
                            ),
                            onChanged: (value) {
                              registerForm.lastName = value;
                              setState(() {});
                            },
                          ),
                          validator:
                            registerForm.lastName.length > 0 ?
                              registerForm.lastNameValidator(registerForm.lastName) :
                              null,
                        ),
                        InputContainerWidget(
                          input: TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              labelText: 'Email',
                              border: InputBorder.none,
                            ),
                            onChanged: (value) {
                              registerForm.email = value;
                              setState(() {});
                            },
                          ),
                          validator:
                            registerForm.email.length > 0 ?
                              registerForm.emailValidator(registerForm.email) :
                              null,
                        ),
                        InputContainerWidget(
                          input: TextFormField(
                            obscureText: true,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              labelText: 'Contraseña',
                              border: InputBorder.none,
                            ),
                            onChanged: (value) {
                              registerForm.password = value;
                              setState(() {});
                            },
                          ),
                          validator:
                            registerForm.password.length > 0 ? 
                              registerForm.passwordValidator(registerForm.password) :
                              null,
                        ),
                        InputContainerWidget(
                          input: TextFormField(
                            obscureText: true,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              labelText: 'Confirmar contraseña',
                              border: InputBorder.none,
                            ),
                            onChanged: (value) {
                              setState(() {
                                registerForm.passwordConfirm = value;
                              });
                            },
                          ),
                          validator:
                            registerForm.passwordConfirm.length > 0 ? 
                              registerForm.passwordConfirmValidator(
                                registerForm.password,
                                registerForm.passwordConfirm,
                              ) : 
                              null,
                        ),
                        InputContainerWidget(
                          input: GestureDetector(
                            onTap: () {
                              showDatePicker(
                                context: context,
                                locale : const Locale("es", "ES"),
                                initialDate: DateTime.now(),
                                firstDate: DateTime.utc(1910, 1, 1),
                                lastDate: DateTime.utc(2100, 1, 1),
                              ).then((value) {
                                if(value != null) {
                                  setState(() {
                                      registerForm.birthday = value;
                                  });
                                }
                              });
                            },
                            child: AbsorbPointer(
                              child: TextFormField(
                                decoration: InputDecoration(
                                  labelText: registerForm.birthday != ''
                                      ? DateFormat('dd-MM-yyyy')
                                          .format(registerForm.birthday)
                                          .toString()
                                      : 'Fecha de nacimiento',
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                          validator:    
                            registerForm.birthday != '' ?
                              registerForm.birthdayValidator(registerForm.birthday) :
                              null,
                        ),
                        RegularButton(
                          onPressed: registerForm.isLoading || !registerForm.isValidForm()
                              ? null
                              : () async {
                                  registerForm.isValidForm();
                                  
                                  FocusScope.of(context).unfocus();

                                  if (!registerForm.isValidForm()) return;
                                  registerForm.isLoading = true;

                                  final authService = Provider.of<AuthService>(
                                      context,
                                      listen: false);

                                  final String? errorMessage = await authService.register(
                                    registerForm.firstName, 
                                    registerForm.lastName, 
                                    registerForm.phone, 
                                    registerForm.address, 
                                    registerForm.birthday, 
                                    registerForm.email, 
                                    registerForm.password, 
                                    registerForm.passwordConfirm
                                  );

                                  if (errorMessage == null) {
                                    Navigator.pushReplacementNamed(
                                        context, '/Welcome');
                                  } else {
                                    NotificationsService.showSnacbar(
                                        errorMessage);
                                    registerForm.isLoading = false;
                                  }
                                },
                          title: registerForm.isLoading
                              ? 'Creando cuenta...'
                              : 'Registrarse',
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
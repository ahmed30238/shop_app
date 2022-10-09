import 'package:flutter/material.dart';
import 'package:flutter_application_1/shared/component/components/shared.dart';
import 'package:flutter_application_1/general_cubit/cubit.dart';
import 'package:flutter_application_1/general_cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingScreen extends StatelessWidget {
  SettingScreen({Key? key}) : super(key: key);

  TextEditingController? nameController = TextEditingController();
  TextEditingController? phoneController = TextEditingController();
  TextEditingController? emailControler = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GeneralCubit, GeneralShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = GeneralCubit.get(context);
        nameController!.text = GeneralCubit.get(context).userModel!.data!.name!;
        phoneController!.text =
            GeneralCubit.get(context).userModel!.data!.phone!;
        emailControler!.text =
            GeneralCubit.get(context).userModel!.data!.email!;

        return GeneralCubit.get(context).userModel != null
            ? Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      if (state is ShopGetProfileLoadingState)
                        const LinearProgressIndicator(),
                      const SizedBox(
                        height: 20.0,
                      ),
                      defaultTextFormField(
                        controller: nameController,
                        text: 'Name',
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return 'Must not be empty';
                          }
                        },
                        prefix: Icons.person,
                        // suffix: Icons.abc,
                        isPass: false,
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      defaultTextFormField(
                        controller: phoneController,
                        text: 'Phone',
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return 'Phone not be empty';
                          }
                        },
                        prefix: Icons.phone,
                        // suffix: Icons.abc,
                        isPass: false,
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      defaultTextFormField(
                        controller: emailControler,
                        text: 'Email',
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return 'Must not be empty';
                          }
                        },
                        prefix: Icons.email,
                        // suffix: Icons.abc,
                        isPass: false,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: double.infinity,
                        height: 40.0,
                        color: Colors.blue,
                        child: TextButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                content: const Text(
                                    'Are You sure you want to logOut'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      signOut(context);
                                    },
                                    child: const Text('Yes'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Cancel'),
                                  ),
                                ],
                              ),
                            );
                          },
                          child: const Text(
                            'LOGOUT',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: double.infinity,
                        height: 40.0,
                        color: Colors.blue,
                        child: TextButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                content: const Text(
                                    'Are You Sure You Want to Update Your Profile'),
                                actions: [
                                  TextButton(
                                    child: const Text('Yes'),
                                    onPressed: () {
                                      cubit.updateData(
                                        name: nameController!.text,
                                        phone: phoneController!.text,
                                        email: emailControler!.text,
                                      );
                                      Navigator.pop(context);
                                    },
                                  ),
                                  TextButton(
                                    child: const Text('Cancel'),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                          child: const Text(
                            'Update',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: double.infinity,
                        height: 40.0,
                        color: Colors.blue,
                        child: TextButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                content: const Text(
                                    'Are You Sure You Want to Clear Cach Memory'),
                                actions: [
                                  TextButton(
                                    child: const Text('Yes'),
                                    onPressed: () {
                                      clearCahch(context);
                                    },
                                  ),
                                  TextButton(
                                    child: const Text('Cancel'),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                          child: const Text(
                            'Clear Cach Memory',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : const Center(child: CircularProgressIndicator());
      },
    );
  }
}

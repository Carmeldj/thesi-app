import 'package:flutter/material.dart';
import 'package:thesis_app/components/form_input.dart';
import 'package:thesis_app/constants/colors.dart';
import 'package:thesis_app/constants/fonts.dart';

class CreateShop extends StatelessWidget {
  CreateShop({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController shopNameController = TextEditingController();
  final TextEditingController otherInfosController = TextEditingController();
  final TextEditingController categorieNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(color: Colors.black),
                  ),
                  child: GestureDetector(onTap: () {}),
                ),
                const SizedBox(height: 20),
                FormInput(
                  controller: shopNameController,
                  hintText: "Nom de la boutique",
                ),
                const SizedBox(height: 20),
                FormInput(
                  controller: categorieNameController,
                  hintText: "Catégorie",
                ),
                const SizedBox(height: 20),
                FormInput(
                  controller: categorieNameController,
                  hintText: "Autres informations",
                ),
                const SizedBox(height: 100),
                TextButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {}
                  },
                  child: Container(
                    height: 50,
                    width: 300,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(10),
                      color: primaryColor,
                    ),
                    child: Center(
                      child: Text(
                        "Créer une boutique",
                        style: TextStyle(fontSize: textNormal),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

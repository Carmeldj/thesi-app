import 'package:flutter/material.dart';
import 'package:thesis_app/components/form_input.dart';
import 'package:thesis_app/constants/colors.dart';
import 'package:thesis_app/constants/fonts.dart';

class CreateProduct extends StatelessWidget {
  CreateProduct({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final productNameController = TextEditingController();
  final specifityNameController = TextEditingController();
  final priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.black),
                  ),
                  child: GestureDetector(
                    onTap: () {},
                    child: Center(child: Text("Ajouter une photo")),
                  ),
                ),
                const SizedBox(height: 20),
                FormInput(
                  controller: productNameController,
                  hintText: "Nom du produit",
                ),
                const SizedBox(height: 20),
                FormInput(
                  controller: specifityNameController,
                  hintText: "Spécifité",
                ),
                const SizedBox(height: 20),
                FormInput(controller: priceController, hintText: "Prix"),
                const SizedBox(height: 100),
                TextButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {}
                  },
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(10),
                      color: primaryColor,
                    ),
                    child: Center(
                      child: Text(
                        "Créer un produit",
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

import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController _identifiantController;
  late TextEditingController _pseudoController;
  late TextEditingController _mdpController;

  @override
  void initState() {
    super.initState();
    _identifiantController = TextEditingController();
    _pseudoController = TextEditingController();
    _mdpController = TextEditingController();
  }

  @override
  void dispose() {
    _identifiantController.dispose();
    _pseudoController.dispose();
    _mdpController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      String identifiant = _identifiantController.text.trim();
      String pseudo = _pseudoController.text.trim();
      String mdp = _mdpController.text.trim();
      print('Identifiant: $identifiant, Pseudo: $pseudo, Mdp: $mdp');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Uber Efrei'),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TextFormField(
                  controller: _identifiantController,
                  decoration: InputDecoration(
                    labelText: 'Identifiant (Ub / Us)',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez entrer votre identifiant';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _pseudoController,
                  decoration: InputDecoration(
                    labelText: 'Pseudo',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez entrer votre pseudo';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _mdpController,
                  decoration: InputDecoration(
                    labelText: 'Mot de passe',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez entrer votre mot de passe';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _submitForm,
                  child: Text('Connexion'),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.greenAccent), // Couleur de fond du bouton
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

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class signUp extends StatefulWidget {
  const signUp({Key? key}) : super(key: key);

  @override
  State<signUp> createState() => _signUpState();
}

class _signUpState extends State<signUp> {
  late String email, sifre;
  final formKey = GlobalKey<FormState>();
  final firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xff4cc1f8),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      baslikText(),
                      input_bosluk(),
                      emailTextField(),
                      input_bosluk(),
                      sifreTextField(),
                      input_bosluk(),
                      kayit_ol(),
                      geri_don(),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Center kayit_ol() {
    return Center(
      child: TextButton(
        onPressed: kayitOl,
        child: Text(
          "Kayıt Ol",
          style: TextStyle(
            color: Colors.white,
            fontSize: 21,
          ),
        ),
      ),
    );
  }

  void kayitOl() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      try {
        var kullanici = await firebaseAuth.createUserWithEmailAndPassword(
            email: email, password: sifre);
        formKey.currentState!.reset();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "Kayıt Oluşturuldu.Giriş Sayfasına Yönlendiriliyorsunuz.",
            ),
          ),
        );
        Navigator.pushReplacementNamed(context, "/loginPage");
      } catch (e) {
        print(e.toString());
      }
    } else {}
  }

  TextButton geri_don() {
    return TextButton(
      onPressed: () => Navigator.pushNamed(context, "/loginPage"),
      child: Text(
        "Geri Dön",
        style: TextStyle(color: Colors.white, fontSize: 20),
      ),
    );
  }

  Padding baslikText() {
    return Padding(
      padding: const EdgeInsets.all(19.0),
      child: Text(
        "Kayıt ol ",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 100,
          fontFamily: 'Satisfy',
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  TextFormField emailTextField() {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return "Lütfen E-mail bilgisi giriniz.!";
        } else {}
      },
      onSaved: (value) {
        email = value!;
      },
      style: TextStyle(color: Colors.white),
      decoration: input_dekor("E-mail"),
    );
  }

  TextFormField sifreTextField() {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return "Lütfen Şifre bilgisi giriniz.!";
        }
      },
      onSaved: (value) {
        sifre = value!;
      },
      style: TextStyle(color: Colors.white),
      decoration: input_dekor("Şifre"),
      obscureText: true,
    );
  }

  Widget input_bosluk() => SizedBox(
        height: 30,
      );

  InputDecoration input_dekor(String hintText) {
    return InputDecoration(
      hintText: hintText,
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.grey),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: Colors.grey,
        ),
      ),
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lesson6/controller/auth_controller.dart';
import 'package:lesson6/view/createaccount_screen.dart';
import 'package:lesson6/view/show_snackbar.dart';
import 'package:lesson6/view/signin_screen.dart';

class SigninscreenController {
  SignInState state;
  SigninscreenController(this.state);

  Future<void> signIn() async {
    FormState? currentState = state.formKey.currentState;
    if (currentState == null) return;
    if (!currentState.validate()) return;
    currentState.save();

    state.callsSetState(() {
      state.model.inProgress = true;
    });

    state.model.inProgress = true;

    try {
      await firebaseSignIn(
        email: state.model.email!,
        password: state.model.password!,
      );
      // authStateChanged() => stream
    } on FirebaseAuthException catch (e) {
      state.callsSetState(() => state.model.inProgress = false);
      var error = 'Sign in error! Reason ${e.code} ${e.message}';
      print('========= $error');
      if (state.mounted) {
        showSnackbar(
          context: state.context,
          message: error,
          seconds: 10,
        );
      }
    } catch (e) {
      state.callsSetState(() => state.model.inProgress = false);
      print('=========== sign in error: $e');
      if (state.mounted) {
        showSnackbar(
          context: state.context,
          message: 'sign in error $e',
          seconds: 10,
        );
      }
    }
  }

  void gotoCreateAccount() {
    Navigator.pushNamed(state.context, CreateAccountScreen.routeName);
  }

  }


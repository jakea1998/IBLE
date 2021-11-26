import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/cupertino.dart';

import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:http/http.dart' as http;

import 'package:flutter/services.dart';
import 'package:ible/blocs/utils/paths.dart';

import 'package:ible/models/user.model.dart';

// enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class AuthenticationRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<void> signInWithEmailAddressAndPassword(
      String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw PlatformException(
        code: e.code,
        message: e.message,
      );
    }
  }

  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw PlatformException(
        code: e.code,
        message: e.message,
      );
    }
  }

  Future<void> signUpWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw PlatformException(
        code: e.code,
        message: e.message,
      );
    }
  }
  Future<void> signOut() async{
     try {
      await _firebaseAuth.signOut();
    } on FirebaseAuthException catch (e) {
      throw PlatformException(
        code: e.code,
        message: e.message,
      );
    }
  }
  Future<void> createUserInFirestore({required AppUser user}) async{
    try {
     await _firebaseFirestore
          .collection(Paths.users_collection)
          .doc(user.id)
          .set(user.toJson());
    } on FirebaseException catch (e) {
      throw PlatformException(code: e.code, message: e.message);
    }
  }

  Future<void> deleteUserFromFirestore({AppUser? user}) async {
    try {
      _firebaseFirestore
          .collection(Paths.users_collection)
          .doc(user?.id)
          .delete();
    } on FirebaseException catch (e) {
      throw PlatformException(code: e.code, message: e.message);
    }
  }

  Future<void> deleteUserFromFirebaseAuth({AppUser? user}) async {
    try {
      await _firebaseAuth.currentUser?.delete();
    } on FirebaseException catch (e) {
      throw PlatformException(code: e.code, message: e.message);
    }
  }

  Future<bool> isSignedIn() async {
    final currentUser = _firebaseAuth.currentUser;
    return currentUser != null;
  }

  Future<void> getCurrentUser(String actionCode) async {}
}

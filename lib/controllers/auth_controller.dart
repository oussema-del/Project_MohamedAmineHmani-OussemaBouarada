import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ihm/constants/app_constants.dart';
import 'package:ihm/constants/fire_base_constants.dart';
import 'package:ihm/models/user.dart';
import 'package:ihm/screens/home/home_shop.dart';

import 'package:ihm/screens/authentification/signup.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();

  late Rx<User?> firebaseUser;
  Rx<UserModel> userModel = UserModel().obs;
  late Rx<GoogleSignInAccount?> googleSignInAccount;

  String usersCollection = "users";

  updateUserData(Map<String, dynamic> data) {
    logger.i("UPDATED");
    firebaseFirestore
        .collection("users")
        .doc(firebaseUser.value!.uid)
        .update(data);
  }

  @override
  void onReady() {
    super.onReady();
    // auth is comning from the constants.dart file but it is basically FirebaseAuth.instance.
    // Since we have to use that many times I just made a constant file and declared there

    firebaseUser = Rx<User?>(auth.currentUser);
    googleSignInAccount = Rx<GoogleSignInAccount?>(googleSign.currentUser);

    firebaseUser.bindStream(auth.userChanges());
    ever(firebaseUser, _setInitialScreen);

    googleSignInAccount.bindStream(googleSign.onCurrentUserChanged);
    ever(googleSignInAccount, _setInitialScreenGoogle);
  }

  _setInitialScreen(User? user) {
    if (user == null) {
      // if the user is not found then the user is navigated to the Register Screen
      Get.offAll(() => const SignUp());
    } else {
      userModel.bindStream(listenToUser());
      // if the user exists and logged in the the user is navigated to the Home Screen
      Get.offAll(() => const HomeScreen());
    }
  }

  _setInitialScreenGoogle(GoogleSignInAccount? googleSignInAccount) {
    print(googleSignInAccount);
    if (googleSignInAccount == null) {
      // if the user is not found then the user is navigated to the Register Screen
      Get.offAll(() => const SignUp());
    } else {
      Get.snackbar("title", "logging");
      // if the user exists and logged in the the user is navigated to the Home Screen
      //Get.offAll(() => MainScreen());
    }
  }

  void signInWithGoogle() async {
    try {
      GoogleSignInAccount? googleSignInAccount = await googleSign.signIn();

      if (googleSignInAccount != null) {
        GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        await auth
            .signInWithCredential(credential)
            .then((value) => FirebaseFirestore.instance
                    .collection("users")
                    .doc(auth.currentUser!.uid)
                    .set({
                  "id": auth.currentUser!.uid,
                  "name": auth.currentUser!.email,
                  "email": auth.currentUser!.email,
                  "cart": [],
                }))
            .catchError((onErr) => print(onErr));
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
      print(e.toString());
    }
  }

  void register(String name, email, password) async {
    try {
      await auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => FirebaseFirestore.instance
                  .collection("users")
                  .doc(auth.currentUser!.uid)
                  .set({
                "id": auth.currentUser!.uid,
                "name": name,
                "email": auth.currentUser!.email,
                "cart": [],
              }));
    } catch (firebaseAuthException) {
      print(firebaseAuthException.toString());
    }
  }

  void login(String email, password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (firebaseAuthException) {
      print("signinwith email error");
    }
  }

  void signOut() async {
    await auth.signOut();
  }

  Stream<UserModel> listenToUser() => firebaseFirestore
      .collection(usersCollection)
      .doc(firebaseUser.value!.uid)
      .snapshots()
      .map((snapshot) => UserModel.fromDocumentSnapshot(snapshot: snapshot));
}

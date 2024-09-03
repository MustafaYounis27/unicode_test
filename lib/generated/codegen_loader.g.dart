// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes, avoid_renaming_method_parameters

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader{
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>?> load(String path, Locale locale) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String,dynamic> ar_AR = {
  "topic": "موضوع",
  "topics": "مواضيع",
  "addTopic": "أضف موضوع",
  "register": "تسجيل",
  "login": "تسجيل الدخول",
  "pressToAdd": "اضغط (+) لإضافة ملاحظات",
  "fillData": "املأ بياناتك للوصول إلى ملاحظاتك المحفوظة",
  "email": "البريد الإلكتروني",
  "emailAddress": "عنوان البريد الإلكتروني",
  "firstTime": "في المرة الأولى معنا، يرجى ",
  "password": "كلمة المرور",
  "fillRegisterData": "يرجى ملء جميع الحقول المطلوبة لتصبح عضواً في عائلتنا",
  "fullName": "الاسم الكامل",
  "allNoteSynced": "تمت مزامنة جميع الملاحظات الآن",
  "wrongTryAgain": "حدث خطأ ما.\nيرجى المحاولة مرة أخرى لمزامنة الملاحظات",
  "welcomeBack": "مرحباً بعودتك",
  "addNote": "أضف ملاحظة",
  "editNote": "تحرير الملاحظة",
  "updatedSuccess": "تم تحديث الملاحظة بنجاح",
  "AddedSuccess": "تمت إضافة الملاحظة بنجاح",
  "sureToRemoveTopic": "هل أنت متأكد أنك بحاجة لإزالة هذا الموضوع؟",
  "title": "العنوان",
  "body": "المحتوى",
  "yes": "نعم",
  "ok": "حسنًا",
  "cancel": "إلغاء",
  "no": "لا",
  "alert": "تنبيه..."
};
static const Map<String,dynamic> en_EN = {
  "topic": "Topic",
  "topics": "Topics",
  "addTopic": "Add Topic",
  "register": "Register",
  "login": "Login",
  "pressToAdd": "Press (+) to add notes",
  "fillData": "Fill your data to access your saved notes",
  "email": "Email",
  "emailAddress": "email address",
  "firstTime": "In your first time with us please, ",
  "password": "Password",
  "fillRegisterData": "Please, fill all required fields to be a member of our family",
  "fullName": "Full name",
  "allNoteSynced": "All notes now synced",
  "wrongTryAgain": "Something went wrong.\nPlease, try sync again",
  "welcomeBack": "Welcome back",
  "addNote": "Add Note",
  "editNote": "Edit Note",
  "updatedSuccess": "Note updated successfully",
  "AddedSuccess": "Note added successfully",
  "sureToRemoveTopic": "Are you sure you need to remove this topic ?",
  "title": "Title",
  "body": "Body",
  "yes": "Yes",
  "ok": "Ok",
  "cancel": "Cancel",
  "no": "No",
  "alert": "Alert..."
};
static const Map<String, Map<String,dynamic>> mapLocales = {"ar_AR": ar_AR, "en_EN": en_EN};
}

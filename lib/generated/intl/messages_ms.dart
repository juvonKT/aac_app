// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ms locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'ms';

  static String m0(category) => "Kategori \'${category}\' telah dipadamkan";

  static String m1(category) =>
      "Adakah anda pasti mahu memadamkan kategori \'${category}\' dan semua frasanya?";

  static String m2(phrase) => "Adakah anda pasti mahu memadam \'${phrase}\'?";

  static String m3(user) => "Adakah anda pasti mahu memadamkan \'${user}\'?";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "addCategory": MessageLookupByLibrary.simpleMessage("Tambah Kategori"),
        "addNewUser":
            MessageLookupByLibrary.simpleMessage("Tambah Pengguna Baharu"),
        "addPhrase": MessageLookupByLibrary.simpleMessage("Tambah Frasa"),
        "addPhraseContent": MessageLookupByLibrary.simpleMessage(
            "1. Pergi ke halaman Tetapan.\n2. Tekan \'Tambah Frasa\' atau \'Tambah Kategori\'.\n3. Masukkan butiran dan simpan."),
        "addPhraseTitle": MessageLookupByLibrary.simpleMessage(
            "Cara Menambah Frasa atau Kategori Baharu"),
        "addUserButton":
            MessageLookupByLibrary.simpleMessage("Tambah Pengguna"),
        "addUserContent": MessageLookupByLibrary.simpleMessage(
            "1. Pergi ke halaman Tetapan.\n2. Tekan butang \'Tambah Pengguna\'.\n3. Masukkan nama pengguna dan simpan."),
        "addUserTitle":
            MessageLookupByLibrary.simpleMessage("Cara Menambah Pengguna"),
        "cancel": MessageLookupByLibrary.simpleMessage("Batal"),
        "categoryDeleted": m0,
        "changeLanguageContent": MessageLookupByLibrary.simpleMessage(
            "1. Pergi ke halaman Tetapan.\n2. Di bawah \'Pilihan Bahasa\', pilih bahasa pilihan anda daripada senarai.\n3. Aplikasi akan secara automatik menukar ke bahasa yang dipilih."),
        "changeLanguageTitle":
            MessageLookupByLibrary.simpleMessage("Cara Menukar Bahasa"),
        "changeThemeContent": MessageLookupByLibrary.simpleMessage(
            "1. Pergi ke halaman Tetapan.\n2. Di bawah \'Skema Warna\', pilih antara mod terang atau gelap."),
        "changeThemeTitle":
            MessageLookupByLibrary.simpleMessage("Cara Menukar Skema Warna"),
        "colourScheme": MessageLookupByLibrary.simpleMessage("Skema Warna"),
        "dark": MessageLookupByLibrary.simpleMessage("Gelap"),
        "delete": MessageLookupByLibrary.simpleMessage("Padam"),
        "deleteCategory":
            MessageLookupByLibrary.simpleMessage("Padamkan Kategori"),
        "deleteCategoryConfirmation": m1,
        "deletePhrase": MessageLookupByLibrary.simpleMessage("Padam Frasa"),
        "deletePhraseConfirmation": m2,
        "deletePhraseContent": MessageLookupByLibrary.simpleMessage(
            "1. Pergi ke skrin utama frasa.\n2. Tekan dan tahan kategori atau frasa yang ingin dipadam.\n3. Mesej pop-up akan meminta pengesahan. Pilih \'Padam\' untuk memadamnya."),
        "deletePhraseTitle": MessageLookupByLibrary.simpleMessage(
            "Cara Memadam Frasa atau Kategori"),
        "deleteUser": MessageLookupByLibrary.simpleMessage("Padam Pengguna"),
        "deleteUserConfirmation": m3,
        "deleteUserContent": MessageLookupByLibrary.simpleMessage(
            "1. Pergi ke halaman Tetapan.\n2. Pilih pengguna yang ingin dipadam daripada senarai.\n3. Tekan butang \'Padam\'."),
        "deleteUserTitle":
            MessageLookupByLibrary.simpleMessage("Cara Memadam Pengguna"),
        "enterYourName":
            MessageLookupByLibrary.simpleMessage("Masukkan nama anda"),
        "home": MessageLookupByLibrary.simpleMessage("Laman Utama"),
        "language": MessageLookupByLibrary.simpleMessage("Bahasa"),
        "light": MessageLookupByLibrary.simpleMessage("Terang"),
        "newCategory":
            MessageLookupByLibrary.simpleMessage("Cipta Kategori Baharu"),
        "newPhrase": MessageLookupByLibrary.simpleMessage("Cipta Frasa Baharu"),
        "past": MessageLookupByLibrary.simpleMessage("Lampau"),
        "progressive": MessageLookupByLibrary.simpleMessage("Progresif"),
        "purposeContent": MessageLookupByLibrary.simpleMessage(
            "Aplikasi ini direka untuk membantu pengguna, terutamanya mereka yang mempunyai cabaran komunikasi, membina ayat menggunakan frasa yang telah ditetapkan. Ia juga menawarkan ciri seperti cadangan frasa, pelbagai bahasa, dan teks-ke-pidato untuk membantu pengguna dalam komunikasi yang berkesan."),
        "purposeTitle":
            MessageLookupByLibrary.simpleMessage("Apa fungsi aplikasi ini?"),
        "removeMessage": MessageLookupByLibrary.simpleMessage(
            "Tekan dan tahan untuk membuang semua"),
        "selectUser": MessageLookupByLibrary.simpleMessage("Pilih Pengguna"),
        "setting": MessageLookupByLibrary.simpleMessage("Tetapan"),
        "system": MessageLookupByLibrary.simpleMessage("Sistem"),
        "usePhrasesContent": MessageLookupByLibrary.simpleMessage(
            "1. Pergi ke skrin utama frasa.\n2. Pilih kategori atau mula menaip frasa.\n3. Aplikasi akan mencadangkan frasa berdasarkan apa yang anda pilih."),
        "usePhrasesTitle":
            MessageLookupByLibrary.simpleMessage("Cara Menggunakan Frasa"),
        "useTTSContent": MessageLookupByLibrary.simpleMessage(
            "1. Di skrin frasa, pilih frasa atau ayat.\n2. Tekan ikon pembesar suara untuk mendengar frasa tersebut dibacakan."),
        "useTTSTitle": MessageLookupByLibrary.simpleMessage(
            "Cara Menggunakan Teks-ke-Ucapan"),
        "userA": MessageLookupByLibrary.simpleMessage("Pengguna A"),
        "userB": MessageLookupByLibrary.simpleMessage("Pengguna B"),
        "userC": MessageLookupByLibrary.simpleMessage("Pengguna C"),
        "userGuide": MessageLookupByLibrary.simpleMessage("Panduan Pengguna"),
        "userGuideContent": MessageLookupByLibrary.simpleMessage(
            "Kandungan Panduan Pengguna Di Sini"),
        "welcome": MessageLookupByLibrary.simpleMessage("Selamat Datang!")
      };
}

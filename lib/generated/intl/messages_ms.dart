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

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "addCategory": MessageLookupByLibrary.simpleMessage("Tambah Kategori"),
        "addPhrase": MessageLookupByLibrary.simpleMessage("Tambah Frasa"),
        "cancel": MessageLookupByLibrary.simpleMessage("Batal"),
        "categoryDeleted": m0,
        "colourScheme": MessageLookupByLibrary.simpleMessage("Skema Warna"),
        "dark": MessageLookupByLibrary.simpleMessage("Gelap"),
        "delete": MessageLookupByLibrary.simpleMessage("Padam"),
        "deleteCategory":
            MessageLookupByLibrary.simpleMessage("Padamkan Kategori"),
        "deleteCategoryConfirmation": m1,
        "home": MessageLookupByLibrary.simpleMessage("Laman Utama"),
        "language": MessageLookupByLibrary.simpleMessage("Bahasa"),
        "light": MessageLookupByLibrary.simpleMessage("Terang"),
        "newCategory":
            MessageLookupByLibrary.simpleMessage("Cipta Kategori Baharu"),
        "newPhrase": MessageLookupByLibrary.simpleMessage("Cipta Frasa Baharu"),
        "removeMessage": MessageLookupByLibrary.simpleMessage(
            "Tekan dan tahan untuk membuang semua"),
        "setting": MessageLookupByLibrary.simpleMessage("Tetapan"),
        "system": MessageLookupByLibrary.simpleMessage("Sistem"),
        "userA": MessageLookupByLibrary.simpleMessage("Pengguna A"),
        "userB": MessageLookupByLibrary.simpleMessage("Pengguna B"),
        "userC": MessageLookupByLibrary.simpleMessage("Pengguna C"),
        "userGuide": MessageLookupByLibrary.simpleMessage("Panduan Pengguna"),
        "userGuideContent": MessageLookupByLibrary.simpleMessage(
            "Kandungan Panduan Pengguna Di Sini")
      };
}

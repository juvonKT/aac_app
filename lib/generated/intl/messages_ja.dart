// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ja locale. All the
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
  String get localeName => 'ja';

  static String m0(category) => "カテゴリ\'${category}\'が削除されました";

  static String m1(category) =>
      "カテゴリ \'${category}\' とそのすべてのフレーズを削除してもよろしいですか？";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "addCategory": MessageLookupByLibrary.simpleMessage("カテゴリを追加"),
        "addPhrase": MessageLookupByLibrary.simpleMessage("フレーズを追加"),
        "cancel": MessageLookupByLibrary.simpleMessage("キャンセル"),
        "categoryDeleted": m0,
        "colourScheme": MessageLookupByLibrary.simpleMessage("テーマ"),
        "dark": MessageLookupByLibrary.simpleMessage("ダーク"),
        "delete": MessageLookupByLibrary.simpleMessage("削除"),
        "deleteCategory": MessageLookupByLibrary.simpleMessage("カテゴリを削除"),
        "deleteCategoryConfirmation": m1,
        "home": MessageLookupByLibrary.simpleMessage("ホーム"),
        "language": MessageLookupByLibrary.simpleMessage("言語"),
        "light": MessageLookupByLibrary.simpleMessage("ライト"),
        "newCategory": MessageLookupByLibrary.simpleMessage("新しいカテゴリ"),
        "newPhrase": MessageLookupByLibrary.simpleMessage("新しいフレーズ"),
        "removeMessage": MessageLookupByLibrary.simpleMessage("長押ししてすべて削除"),
        "setting": MessageLookupByLibrary.simpleMessage("設定"),
        "system": MessageLookupByLibrary.simpleMessage("システム"),
        "userA": MessageLookupByLibrary.simpleMessage("ユーザーA"),
        "userB": MessageLookupByLibrary.simpleMessage("ユーザーB"),
        "userC": MessageLookupByLibrary.simpleMessage("ユーザーC"),
        "userGuide": MessageLookupByLibrary.simpleMessage("ユーザーガイド"),
        "userGuideContent":
            MessageLookupByLibrary.simpleMessage("ユーザーガイドの内容がここに表示されます")
      };
}

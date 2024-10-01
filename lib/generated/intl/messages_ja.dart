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
        "addPhraseContent": MessageLookupByLibrary.simpleMessage(
            "1. 設定ページに移動します。\n2. 「フレーズを追加」または「カテゴリを追加」を押します。\n3. 詳細を入力して保存します。"),
        "addPhraseTitle":
            MessageLookupByLibrary.simpleMessage("新しいフレーズまたはカテゴリを追加する方法"),
        "addUserContent": MessageLookupByLibrary.simpleMessage(
            "1. 設定ページに移動します。\n2. 「ユーザーを追加」ボタンを押します。\n3. ユーザーの名前を入力して保存します。"),
        "addUserTitle": MessageLookupByLibrary.simpleMessage("ユーザーを追加する方法"),
        "cancel": MessageLookupByLibrary.simpleMessage("キャンセル"),
        "categoryDeleted": m0,
        "changeLanguageContent": MessageLookupByLibrary.simpleMessage(
            "1. 設定ページに移動します。\n2. 「言語の設定」で、ドロップダウンから希望の言語を選択します。\n3. アプリが自動的に選択した言語に切り替わります。"),
        "changeLanguageTitle":
            MessageLookupByLibrary.simpleMessage("言語を変更する方法"),
        "changeThemeContent": MessageLookupByLibrary.simpleMessage(
            "1. 設定ページに移動します。\n2. 「テーマ」から、ライトモードかダークモードを選択します。"),
        "changeThemeTitle": MessageLookupByLibrary.simpleMessage("テーマを変更する方法"),
        "colourScheme": MessageLookupByLibrary.simpleMessage("テーマ"),
        "dark": MessageLookupByLibrary.simpleMessage("ダーク"),
        "delete": MessageLookupByLibrary.simpleMessage("削除"),
        "deleteCategory": MessageLookupByLibrary.simpleMessage("カテゴリを削除"),
        "deleteCategoryConfirmation": m1,
        "deletePhraseContent": MessageLookupByLibrary.simpleMessage(
            "1. フレーズのメイン画面に移動します。\n2. 削除したいカテゴリまたはフレーズを長押しします。\n3. 確認を求めるポップアップメッセージが表示されます。「削除」を選択して削除します。"),
        "deletePhraseTitle":
            MessageLookupByLibrary.simpleMessage("フレーズまたはカテゴリを削除する方法"),
        "deleteUserContent": MessageLookupByLibrary.simpleMessage(
            "1. 設定ページに移動します。\n2. リストから削除するユーザーを選択します。\n3. 「削除」ボタンを押します。"),
        "deleteUserTitle": MessageLookupByLibrary.simpleMessage("ユーザーを削除する方法"),
        "home": MessageLookupByLibrary.simpleMessage("ホーム"),
        "language": MessageLookupByLibrary.simpleMessage("言語"),
        "light": MessageLookupByLibrary.simpleMessage("ライト"),
        "newCategory": MessageLookupByLibrary.simpleMessage("新しいカテゴリ"),
        "newPhrase": MessageLookupByLibrary.simpleMessage("新しいフレーズ"),
        "removeMessage": MessageLookupByLibrary.simpleMessage("長押ししてすべて削除"),
        "setting": MessageLookupByLibrary.simpleMessage("設定"),
        "system": MessageLookupByLibrary.simpleMessage("システム"),
        "usePhrasesContent": MessageLookupByLibrary.simpleMessage(
            "1. フレーズのメイン画面に移動します。\n2. カテゴリを選択するか、フレーズを入力し始めます。\n3. アプリは選択に基づいてフレーズを提案します。"),
        "usePhrasesTitle": MessageLookupByLibrary.simpleMessage("フレーズを使用する方法"),
        "useTTSContent": MessageLookupByLibrary.simpleMessage(
            "1. フレーズ画面で、フレーズまたは文を選択します。\n2. スピーカーアイコンを押して、フレーズを読み上げます。"),
        "useTTSTitle": MessageLookupByLibrary.simpleMessage("テキスト読み上げを使用する方法"),
        "userA": MessageLookupByLibrary.simpleMessage("ユーザーA"),
        "userB": MessageLookupByLibrary.simpleMessage("ユーザーB"),
        "userC": MessageLookupByLibrary.simpleMessage("ユーザーC"),
        "userGuide": MessageLookupByLibrary.simpleMessage("ユーザーガイド"),
        "userGuideContent":
            MessageLookupByLibrary.simpleMessage("ユーザーガイドの内容がここに表示されます")
      };
}

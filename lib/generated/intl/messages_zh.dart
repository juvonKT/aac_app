// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a zh locale. All the
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
  String get localeName => 'zh';

  static String m0(category) => "类别 \'${category}\' 已被删除";

  static String m1(category) => "您确定要删除类别 \'${category}\' 及其所有短语吗？";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "addCategory": MessageLookupByLibrary.simpleMessage("添加类别"),
        "addPhrase": MessageLookupByLibrary.simpleMessage("添加短语"),
        "cancel": MessageLookupByLibrary.simpleMessage("取消"),
        "categoryDeleted": m0,
        "colourScheme": MessageLookupByLibrary.simpleMessage("配色方案"),
        "dark": MessageLookupByLibrary.simpleMessage("深色"),
        "delete": MessageLookupByLibrary.simpleMessage("删除"),
        "deleteCategory": MessageLookupByLibrary.simpleMessage("删除类别"),
        "deleteCategoryConfirmation": m1,
        "home": MessageLookupByLibrary.simpleMessage("首页"),
        "language": MessageLookupByLibrary.simpleMessage("语言"),
        "light": MessageLookupByLibrary.simpleMessage("浅色"),
        "newCategory": MessageLookupByLibrary.simpleMessage("新类别"),
        "newPhrase": MessageLookupByLibrary.simpleMessage("新短语"),
        "removeMessage": MessageLookupByLibrary.simpleMessage("按住以删除全部"),
        "setting": MessageLookupByLibrary.simpleMessage("设置"),
        "system": MessageLookupByLibrary.simpleMessage("系统"),
        "userA": MessageLookupByLibrary.simpleMessage("用户A"),
        "userB": MessageLookupByLibrary.simpleMessage("用户B"),
        "userC": MessageLookupByLibrary.simpleMessage("用户C"),
        "userGuide": MessageLookupByLibrary.simpleMessage("用户指南"),
        "userGuideContent": MessageLookupByLibrary.simpleMessage("用户指南内容在这里")
      };
}

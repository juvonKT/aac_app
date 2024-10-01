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

  static String m2(phrase) => "您确定要删除 \'${phrase}\' 吗？";

  static String m3(user) => "您确定要删除\'${user}\'吗？";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "addCategory": MessageLookupByLibrary.simpleMessage("添加类别"),
        "addNewUser": MessageLookupByLibrary.simpleMessage("添加新用户"),
        "addPhrase": MessageLookupByLibrary.simpleMessage("添加短语"),
        "addPhraseContent": MessageLookupByLibrary.simpleMessage(
            "1. 转到设置页面。\n2. 点击“添加短语”或“添加类别”。\n3. 输入详细信息并保存。"),
        "addPhraseTitle": MessageLookupByLibrary.simpleMessage("如何添加新短语或类别"),
        "addUserButton": MessageLookupByLibrary.simpleMessage("添加用户"),
        "addUserContent": MessageLookupByLibrary.simpleMessage(
            "1. 转到设置页面。\n2. 点击“添加用户”按钮。\n3. 输入用户的名字并保存。"),
        "addUserTitle": MessageLookupByLibrary.simpleMessage("如何添加用户"),
        "cancel": MessageLookupByLibrary.simpleMessage("取消"),
        "categoryDeleted": m0,
        "changeLanguageContent": MessageLookupByLibrary.simpleMessage(
            "1. 转到设置页面。\n2. 在“语言首选项”下，从下拉菜单中选择你喜欢的语言。\n3. 应用程序将自动切换到所选语言。"),
        "changeLanguageTitle": MessageLookupByLibrary.simpleMessage("如何更改语言"),
        "changeThemeContent": MessageLookupByLibrary.simpleMessage(
            "1. 转到设置页面。\n2. 在“主题”下，选择浅色或深色模式。"),
        "changeThemeTitle": MessageLookupByLibrary.simpleMessage("如何更改主题"),
        "colourScheme": MessageLookupByLibrary.simpleMessage("配色方案"),
        "dark": MessageLookupByLibrary.simpleMessage("深色"),
        "delete": MessageLookupByLibrary.simpleMessage("删除"),
        "deleteCategory": MessageLookupByLibrary.simpleMessage("删除类别"),
        "deleteCategoryConfirmation": m1,
        "deletePhrase": MessageLookupByLibrary.simpleMessage("删除短语"),
        "deletePhraseConfirmation": m2,
        "deletePhraseContent": MessageLookupByLibrary.simpleMessage(
            "1. 转到短语主屏幕。\n2. 长按要删除的类别或短语。\n3. 弹出消息将询问确认。选择“删除”以删除它。"),
        "deletePhraseTitle": MessageLookupByLibrary.simpleMessage("如何删除短语或类别"),
        "deleteUser": MessageLookupByLibrary.simpleMessage("删除用户"),
        "deleteUserConfirmation": m3,
        "deleteUserContent": MessageLookupByLibrary.simpleMessage(
            "1. 转到设置页面。\n2. 从列表中选择要删除的用户。\n3. 点击“删除”按钮。"),
        "deleteUserTitle": MessageLookupByLibrary.simpleMessage("如何删除用户"),
        "enterYourName": MessageLookupByLibrary.simpleMessage("输入你的名字"),
        "home": MessageLookupByLibrary.simpleMessage("首页"),
        "language": MessageLookupByLibrary.simpleMessage("语言"),
        "light": MessageLookupByLibrary.simpleMessage("浅色"),
        "newCategory": MessageLookupByLibrary.simpleMessage("新类别"),
        "newPhrase": MessageLookupByLibrary.simpleMessage("新短语"),
        "noStartingWords": MessageLookupByLibrary.simpleMessage("没有可用的起始词。"),
        "past": MessageLookupByLibrary.simpleMessage("过去"),
        "progressive": MessageLookupByLibrary.simpleMessage("进行时"),
        "purposeContent": MessageLookupByLibrary.simpleMessage(
            "这个应用程序旨在帮助用户，尤其是那些有沟通障碍的用户，使用预定义短语构建句子。它还提供短语建议、多语言和文本转语音等功能，以帮助用户进行有效的沟通。"),
        "purposeTitle": MessageLookupByLibrary.simpleMessage("这个应用程序的目的是什么？"),
        "removeMessage": MessageLookupByLibrary.simpleMessage("按住以删除全部"),
        "selectUser": MessageLookupByLibrary.simpleMessage("选择用户"),
        "setting": MessageLookupByLibrary.simpleMessage("设置"),
        "system": MessageLookupByLibrary.simpleMessage("系统"),
        "usePhrasesContent": MessageLookupByLibrary.simpleMessage(
            "1. 转到短语主屏幕。\n2. 选择一个类别或开始输入短语。\n3. 应用程序会根据您的选择建议短语。"),
        "usePhrasesTitle": MessageLookupByLibrary.simpleMessage("如何使用短语"),
        "useTTSContent": MessageLookupByLibrary.simpleMessage(
            "1. 在短语屏幕上，选择一个短语或句子。\n2. 点击扬声器图标以听到该短语的语音输出。"),
        "useTTSTitle": MessageLookupByLibrary.simpleMessage("如何使用文本转语音"),
        "userA": MessageLookupByLibrary.simpleMessage("用户A"),
        "userB": MessageLookupByLibrary.simpleMessage("用户B"),
        "userC": MessageLookupByLibrary.simpleMessage("用户C"),
        "userGuide": MessageLookupByLibrary.simpleMessage("用户指南"),
        "userGuideContent": MessageLookupByLibrary.simpleMessage("用户指南内容在这里"),
        "welcome": MessageLookupByLibrary.simpleMessage("欢迎!")
      };
}

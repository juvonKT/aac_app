// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a e locale. All the
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
  String get localeName => 'e';

  static String m0(category) => "Category \'${category}\' has been deleted";

  static String m1(category) =>
      "Are you sure you want to delete the category \'${category}\' and all its phrases?";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "addCategory": MessageLookupByLibrary.simpleMessage("Add Category"),
        "addPhrase": MessageLookupByLibrary.simpleMessage("Add Phrase"),
        "cancel": MessageLookupByLibrary.simpleMessage("Cancel"),
        "categoryDeleted": m0,
        "colourScheme": MessageLookupByLibrary.simpleMessage("Colour Scheme"),
        "dark": MessageLookupByLibrary.simpleMessage("Dark"),
        "delete": MessageLookupByLibrary.simpleMessage("Delete"),
        "deleteCategory":
            MessageLookupByLibrary.simpleMessage("Delete Category"),
        "deleteCategoryConfirmation": m1,
        "home": MessageLookupByLibrary.simpleMessage("Home"),
        "language": MessageLookupByLibrary.simpleMessage("Language"),
        "light": MessageLookupByLibrary.simpleMessage("Light"),
        "newCategory": MessageLookupByLibrary.simpleMessage("New Category"),
        "newPhrase": MessageLookupByLibrary.simpleMessage("New Phrase"),
        "removeMessage":
            MessageLookupByLibrary.simpleMessage("Hold to remove all"),
        "setting": MessageLookupByLibrary.simpleMessage("Settings"),
        "system": MessageLookupByLibrary.simpleMessage("System"),
        "userA": MessageLookupByLibrary.simpleMessage("User A"),
        "userB": MessageLookupByLibrary.simpleMessage("User B"),
        "userC": MessageLookupByLibrary.simpleMessage("User C"),
        "userGuide": MessageLookupByLibrary.simpleMessage("User Guide"),
        "userGuideContent":
            MessageLookupByLibrary.simpleMessage("User Guide Content Goes Here")
      };
}

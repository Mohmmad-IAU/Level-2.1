import 'dart:io';
import '../models/note_model.dart';

/// Manages the operations of the note-taking program (create, edit, delete, search, display).
class NoteApp {
  List<Note> notes = [];

  static const int boxWidth = 50;
  final String horizontalLine = '═' * (boxWidth - 2);
  final String header = "╔${'═' * (boxWidth - 2)}╗";
  final String footer = "╚${'═' * (boxWidth - 2)}╝";

  /// Creates a new note and adds it to the list of notes.
  void createNote() {
    _printHeader("Create a New Note");

    final title = _getInput("Enter the note title: ");
    if (title.isEmpty) {
      print("Note title cannot be empty. Please provide a title.\n");
      return;
    }

    if (_noteExists(title)) {
      print(
          "A note with the title '$title' already exists. Please choose a different title.\n");
      return;
    }

    final content = _getInput("Enter the note content: ");
    final newNote = Note(
      title: title,
      content: content.isEmpty ? "None" : content,
    );

    notes.add(newNote);
    print("The note is successfully created!\n");
  }

  /// Displays all notes in the list.
  void displayNotes() {
    _printHeader("All Notes");

    if (notes.isEmpty) {
      print("No notes to display.");
    } else {
      for (var note in notes) {
        _printNoteContent(note.title, note.content);
      }
    }
  }

  /// Edits the title and content of a note.
  void editNote() {
    _printHeader("Edit Note");

    if (notes.isEmpty) {
      print("No notes to edit.");
      return;
    }

    final title = _getInput("Enter the title of the note to edit: ");
    final note = _findNoteByTitle(title);
    if (note == null) {
      print("Note with title '$title' not found.\n");
      return;
    }

    final newTitle = _getInput("Enter a new title: ");
    final newContent = _getInput("Enter new content: ");
    note.title = newTitle.isEmpty ? note.title : newTitle;
    note.content = newContent.isEmpty ? note.content : newContent;

    print("The note is successfully edited!");
  }

  /// Deletes a specific note from the list.
  void deleteNote() {
    _printHeader("Delete Note");

    if (notes.isEmpty) {
      print("No notes to delete.");
      return;
    }

    final title = _getInput("Enter the title of the note to delete: ");
    final note = _findNoteByTitle(title);

    if (note == null) {
      print("Note with title '$title' not found.");
      return;
    }

    notes.remove(note);
    print("Note deleted: ${note.title}");
  }

  /// Searches for a specific note by title or content.
  void searchNotes() {
    _printHeader("Search Notes");

    if (notes.isEmpty) {
      print("No notes to search.");
      return;
    }

    final query = _getInput("Enter the title or content of the note to search: ");
    final matchingNotes = notes.where((note) =>
        note.title.contains(query) || note.content.contains(query)).toList();

    if (matchingNotes.isEmpty) {
      print("No matching notes found.");
    } else {
      print("Matching notes:");
      for (var note in matchingNotes) {
        _printNoteContent(note.title, note.content);
      }
    }
  }

  /// Helper method to get input from the user.
  String _getInput(String prompt) {
    stdout.write(prompt);
    return stdin.readLineSync()?.trim() ?? "";
  }

  /// Helper method to check if a note with the given title already exists.
  bool _noteExists(String title) {
    return notes.any((note) => note.title == title);
  }

  /// Helper method to find a note by its title.
  Note? _findNoteByTitle(String title) {
    try {
      return notes.firstWhere((note) => note.title == title);
    } catch (e) {
      return null;
    }
  }

  /// Helper method to print header with a title.
  void _printHeader(String title) {
    print(header);
    print("║ ${_centerText(title, boxWidth - 4)} ║");
    print(footer);
  }

  /// Helper method to print note content within a box.
  void _printNoteContent(String title, String content) {
    print("╔${'═' * (boxWidth - 2)}╗");
    print("║ ${_centerText(title, boxWidth - 4)} ║");
    print("╠${'═' * (boxWidth - 2)}╣");
    print("║ Content:".padRight(boxWidth - 1) + "║");
    _printWrappedContent(content);
    print("╚${'═' * (boxWidth - 2)}╝");
  }

  /// Helper method to wrap and print content within the box width.
  void _printWrappedContent(String content) {
    final int contentWidth = boxWidth - 4;
    final lines = _wrapText(content, contentWidth);
    for (var line in lines) {
      print("║ ${line.padRight(contentWidth)} ║");
    }
  }

  /// Helper method to wrap text within a specific width.
  List<String> _wrapText(String text, int width) {
    final List<String> lines = [];
    while (text.isNotEmpty) {
      if (text.length <= width) {
        lines.add(text);
        break;
      } else {
        int spaceIndex = text.lastIndexOf(' ', width);
        if (spaceIndex == -1) {
          spaceIndex = width;
        }
        lines.add(text.substring(0, spaceIndex));
        text = text.substring(spaceIndex).trimLeft();
      }
    }
    return lines;
  }

  /// Helper method to center text within a given width.
  String _centerText(String text, int width) {
    final int padding = (width - text.length) ~/ 2;
    final String paddingStr = ' ' * padding;
    return paddingStr + text + paddingStr.padRight(width - text.length - padding);
  }
}

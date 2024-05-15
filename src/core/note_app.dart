import 'dart:io';
import '../models/note_model.dart';

/// Manages the operations of the note-taking program (create, edit, delete, search, display).
class NoteApp {
  List<Note> notes = [];

  /// Creates a new note and adds it to the list of notes.
  void createNote() {
    print("╔══════════════════════════════════════════════╗");
    print("║               Create a New Note              ║");
    print("╚══════════════════════════════════════════════╝");

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
    print("╔══════════════════════════════════════════════╗");
    print("║                All Notes                     ║");
    print("╚══════════════════════════════════════════════╝");

    if (notes.isEmpty) {
      print("No notes to display.");
    } else {
      for (var note in notes) {
        print("Title: ${note.title}\nContents: ${note.content}\n");
      }
    }
  }

  /// Edits the title and content of a note.
  void editNote() {
    print("╔══════════════════════════════════════════════╗");
    print("║                 Edit Note                    ║");
    print("╚══════════════════════════════════════════════╝");

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
    print("╔══════════════════════════════════════════════╗");
    print("║               Delete Note                    ║");
    print("╚══════════════════════════════════════════════╝");

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
    print("╔══════════════════════════════════════════════╗");
    print("║              Search Notes                    ║");
    print("╚══════════════════════════════════════════════╝");

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
        print("Title: ${note.title}\nContents: ${note.content}\n");
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
}

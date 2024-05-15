import 'dart:io';
import 'core/note_app.dart';

/// Entry point for the note-taking application.
void main() {
  final note_app = note_app();

  while (true) {
    try {
      print("************** Welcome to NoteApp **************");
      print("1. Create a note");
      print("2. Edit a note");
      print("3. Delete a note");
      print("4. Search for a note");
      print("5. Display all notes");
      print("6. Exit");
      stdout.write("Enter your choice: ");

      final choice = int.tryParse(stdin.readLineSync() ?? "") ?? -1;

      switch (choice) {
        case 1:
          note_app.createNote();
          break;
        case 2:
          note_app.editNote();
          break;
        case 3:
          note_app.deleteNote();
          break;
        case 4:
          note_app.searchNotes();
          break;
        case 5:
          note_app.displayNotes();
          break;
        case 6:
          print("Exiting the program.");
          exit(0);
        default:
          print("Invalid choice. Please choose a number between 1 and 6.");
      }
    } on FormatException {
      print("Invalid input. Please enter a valid number.");
    } catch (e) {
      print("An unexpected error occurred: $e");
    }
  }
}

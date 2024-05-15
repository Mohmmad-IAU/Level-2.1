import 'dart:io';
import 'core/note_app.dart';

/// Entry point for the note-taking application.
void main() {
  final noteApp = NoteApp();

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
          noteApp.createNote();
          break;
        case 2:
          noteApp.editNote();
          break;
        case 3:
          noteApp.deleteNote();
          break;
        case 4:
          noteApp.searchNotes();
          break;
        case 5:
          noteApp.displayNotes();
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

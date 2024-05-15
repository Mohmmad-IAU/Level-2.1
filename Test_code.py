import 'dart:io';

class Note {
  String title;
  String content;

  Note({
    required this.title,
    required this.content,
  });
}

class NoteApp {
  List<Note> notes = [];

  void createNote() {
    print("Enter title:");
    String title = stdin.readLineSync()!;
    print("Enter content:");
    String content = stdin.readLineSync()!;
    notes.add(Note(
      title: title,
      content: content,
    ));
    print("Note created successfully!");
  }

  void editNote() {
    print("Enter title of the note to edit:");
    String title = stdin.readLineSync()!;
    Note? note = notes.firstWhere((note) => note.title == title, orElse: () => Note(
      title: '',
      content: '',
    ));
    if (note.title.isEmpty) {
      print("Note not found!");
    } else {
      print("Enter new content:");
      note.content = stdin.readLineSync()!;
      print("Note updated successfully!");
    }
  }

  void deleteNote() {
    print("Enter title of the note to delete:");
    String title = stdin.readLineSync()!;
    notes.removeWhere((note) => note.title == title);
    print("Note deleted successfully!");
  }

  void searchNotes() {
    print("Enter search keyword:");
    String keyword = stdin.readLineSync()!;
    List<Note> results = notes.where((note) =>
        note.title.contains(keyword) || note.content.contains(keyword)).toList();
    if (results.isEmpty) {
      print("No notes found!");
    } else {
      print("Search results:");
      for (var note in results) {
        print("Title: ${note.title}");
        print("Content: ${note.content}");
      }
    }
  }

  void displayMenu() {
    while (true) {
      print("\nNote Taking App");
      print("1. Create a note");
      print("2. Edit a note");
      print("3. Delete a note");
      print("4. Search for a note");
      print("5. Exit");
      print("Enter your choice:");

      String choice = stdin.readLineSync()!;
      switch (choice) {
        case '1':
          createNote();
          break;
        case '2':
          editNote();
          break;
        case '3':
          deleteNote();
          break;
        case '4':
          searchNotes();
          break;
        case '5':
          exit(0);
        default:
          print("Invalid choice!");
      }
    }
  }
}

void main() {
  NoteApp app = NoteApp();
  app.displayMenu();
}

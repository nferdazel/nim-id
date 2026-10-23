import std/[unittest, os]
import a02_store

proc testPath(): string =
  getTempDir() / "nim_id_notes_test.json"

suite "store":
  setup:
    removeFile(testPath())

  teardown:
    removeFile(testPath())

  test "starts empty":
    check loadNotes(testPath()).len == 0

  test "adds notes in order":
    addNote(testPath(), "first")
    addNote(testPath(), "second")
    let notes = loadNotes(testPath())
    check notes.len == 2
    check notes[0].text == "first"
    check notes[1].text == "second"

  test "removes a note by index":
    addNote(testPath(), "keep")
    addNote(testPath(), "drop")
    check removeNote(testPath(), 1)
    check loadNotes(testPath()).len == 1

  test "rejects an index that is out of range":
    check not removeNote(testPath(), 0)

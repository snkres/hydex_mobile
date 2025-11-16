import 'package:fast_contacts/fast_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'contact_repository.g.dart';

@riverpod
Future<List<Contact>> getContacts(Ref ref) async {
  List<Contact> contacts = await FastContacts.getAllContacts();
  return contacts;
}

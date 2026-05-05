import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:go_router/go_router.dart';
import 'package:hydex/core/ui/colors.dart';
import 'package:hydex/core/ui/type.dart';
import 'package:hydex/src/features/contact/domain/contact_repository.dart';
import 'package:hydex/src/widgets/backbtn.dart';

final contactsSearchProvider = StateProvider.autoDispose<String>((ref) => "");

class ContactsScreen extends ConsumerWidget {
  const ContactsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final contacts = ref.watch(getContactsProvider);

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: .start,
          children: [
            Row(
              children: [
                CustomBackButton(),
                Text(
                  "Your Contacts",
                  style: AppTextStyles(
                    context,
                  ).secondaryRegular.copyWith(fontWeight: .w700),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "Select a contact to add it's phone number",
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: AppTextStyles(context).accumulator * 14,
                ),
              ),
            ),
            SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                decoration: InputDecoration(labelText: "Search..."),
                onChanged: (value) {
                  ref.read(contactsSearchProvider.notifier).state = value
                      .trim();
                },
              ),
            ),
            SizedBox(height: 12),

            contacts.when(
              data: (data) {
                final contactsWithPhones = data
                    .where((c) => c.phones.isNotEmpty)
                    .toList();
                if (contactsWithPhones.isEmpty) {
                  return Center(child: Text("No Contact"));
                }
                final search = ref.watch(contactsSearchProvider).toLowerCase();

                final filtered = search.isEmpty
                    ? contactsWithPhones
                    : contactsWithPhones.where((c) {
                        final nameMatch = c.displayName
                            .toLowerCase()
                            .startsWith(search);
                        final phoneMatch = c.phones.any(
                          (p) => p.number.toLowerCase().contains(search),
                        );
                        return nameMatch || phoneMatch;
                      }).toList();
                return Expanded(
                  child: ListView.separated(
                    itemCount: filtered.length,
                    separatorBuilder: (context, index) => SizedBox(height: 16),
                    itemBuilder: (context, index) => ListTile(
                      leading: Icon(Icons.person_outline),
                      title: Text(filtered[index].displayName),
                      onTap: () async {
                        final selectedPhone = await showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return ListView(
                              shrinkWrap: true,
                              children: filtered[index].phones.map((e) {
                                return ListTile(
                                  title: Text(e.number),
                                  subtitle: Text(e.label),
                                  onTap: () {
                                    context.pop(e.number);
                                  },
                                );
                              }).toList(),
                            );
                          },
                        );

                        if (selectedPhone != null && context.mounted) {
                          context.pop(selectedPhone);
                        }
                      },
                    ),
                  ),
                );
              },
              error: (e, s) => Expanded(
                child: Center(child: Text("Couldn't read contacts")),
              ),
              loading: () => Expanded(
                child: Center(child: CircularProgressIndicator.adaptive()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

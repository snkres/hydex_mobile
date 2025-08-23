import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hydex/src/features/auth/data/country.dart';
import 'package:hydex/src/features/auth/provider/country_picker_provider.dart';
import 'package:hydex/src/widgets/custom_radio.dart';

class CountryPickerBottomSheet extends StatefulWidget {
  const CountryPickerBottomSheet({super.key});

  @override
  State<CountryPickerBottomSheet> createState() =>
      _CountryPickerBottomSheetState();
}

class _CountryPickerBottomSheetState extends State<CountryPickerBottomSheet> {
  List<Country> filteredCountries = [];
  List<Country> allCountries = [];
  final TextEditingController searchController = TextEditingController();
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    searchController.addListener(_filterCountries);
    _loadCountries();
  }

  Future<void> _loadCountries() async {
    try {
      final countries = await CountryService.getCountriesSorted();
      setState(() {
        allCountries = countries;
        filteredCountries = countries;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  void _filterCountries() {
    final query = searchController.text.toLowerCase();
    setState(() {
      filteredCountries = allCountries
          .where((country) => country.name.toLowerCase().contains(query))
          .toList();
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Title
          const Text(
            'Select a country',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 16),

          // Search field
          TextField(
            controller: searchController,
            decoration: InputDecoration(
              hint: Text(
                "Search",
                style: TextStyle(color: Color(0xff7A7F99), fontSize: 15),
              ),
              prefixIcon: Padding(
                padding: const EdgeInsets.only(left: 16, right: 8),
                child: SvgPicture.asset(
                  "img/svg/search.svg",
                  package: "assets",
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Countries list
          Expanded(
            child: Consumer(
              builder: (context, ref, child) {
                final selectedCountry = ref.watch(
                  countryPickerNotifierProvider,
                );
                return ListView.builder(
                  itemCount: filteredCountries.length,
                  itemBuilder: (context, index) {
                    final country = filteredCountries[index];
                    return ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Text(
                        country.emoji,
                        style: const TextStyle(fontSize: 26),
                      ),
                      title: Text(country.name, style: TextStyle(fontSize: 15)),
                      trailing: CustomRadio(
                        isSelected:
                            selectedCountry.requireValue.code == country.code,
                      ),
                      onTap: () {
                        ref
                            .read(countryPickerNotifierProvider.notifier)
                            .change(country);
                        context.pop();
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

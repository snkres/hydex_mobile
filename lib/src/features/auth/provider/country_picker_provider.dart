import 'package:hydex/src/features/auth/data/country.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'country_picker_provider.g.dart';

@Riverpod(keepAlive: true)
class CountryPickerNotifier extends _$CountryPickerNotifier {
  @override
  FutureOr<Country> build() async {
    return await CountryService.getDefaultCountry();
  }

  void change(Country country) => state = AsyncData(country);
}

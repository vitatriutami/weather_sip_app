import 'package:flutter_test/flutter_test.dart';
import 'package:weather_sip_app/domain/entity/user_preference_entity.dart';

void main() {
  group('UserPreferenceEntity', () {
    test('should store name and favoriteDrink correctly', () {
      final user = UserPreferenceEntity(
        name: 'Budi',
        favoriteDrink: 'Teh Tarik',
      );

      expect(user.name, 'Budi');
      expect(user.favoriteDrink, 'Teh Tarik');
    });
  });
}

import 'dart:convert';
import 'package:http/http.dart' as http;

class CurrencyConverter {
  static const String apiUrl =
      "https://openexchangerates.org/api/currencies.json?app_id=3d1b195bbeef4381bc3ac8a88a8b257d";
  Future<Map<String, dynamic>> fetchExchangeRates() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load exchange rates');
    }
  }

  double convertCurrency(double amount, double rate) {
    return amount * rate;
  }
}

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product.dart';

/// مسؤول عن جميع طلبات الشبكة (API Calls)
class ApiService {

  /// جلب قائمة المنتجات من Fake Store API
  /// يرمي [Exception] في حال فشل الطلب أو كان الرد غير صحيح
  Future<List<Product>> fetchProducts({String? category}) async {
    final String url;
    if (category != null && category.isNotEmpty) {
      // FakeStoreAPI uses lowercase for categories
      url = 'https://fakestoreapi.com/products/category/${category.toLowerCase()}';
    } else {
      url = 'https://fakestoreapi.com/products';
    }

    final response = await http
        .get(Uri.parse(url))
        .timeout(const Duration(seconds: 10));

    if (response.statusCode != 200) {
      throw Exception('فشل جلب البيانات. رمز الحالة: ${response.statusCode}');
    }

    final List<dynamic> items = jsonDecode(response.body);

    return items.map((item) => Product.fromJson(item)).toList();
  }
}

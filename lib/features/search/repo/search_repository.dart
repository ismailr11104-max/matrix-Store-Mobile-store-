import 'package:matrix_app/features/home/model_prodect/product_model.dart';
import 'package:matrix_app/features/search/date/remote_date/search_api_serves.dart';

abstract class BaseSearchRepository {
  Future<dynamic> getSearchItem({String? q});
}

class SearchRepository extends BaseSearchRepository {
  SearchRepository(this.searchApiServes);

  final SearchApiServes searchApiServes;

  @override
  Future<dynamic> getSearchItem({String? q}) async {
    try {

      final result = await searchApiServes.getSearchItem(q: q);
      if(result is List) {
        final search = result
            .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
            .toList();
        return search;
      } else {
        throw Exception('Failed to get search items');
      }
    } catch (e) {
      throw Exception('Failed to get search items: $e');
    }
  }
}

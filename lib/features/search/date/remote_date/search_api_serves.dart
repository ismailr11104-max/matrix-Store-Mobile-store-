import 'package:matrix_app/core/dete_surce/remote_dete/api_serves_config.dart';
import 'package:matrix_app/features/search/date/remote_date/search_dio_config.dart';

abstract class BaseSearchApiService {
  Future<dynamic> getSearchItem({String? q});
}

class SearchApiServes extends BaseSearchApiService {
  final dio = SearchDioConfig.createSearchDio();
  @override
  Future<dynamic> getSearchItem({String? q}) async {
    try {
      final response = await dio.get(
        ApiServesConfig.search,
        queryParameters: {'q': q},
      );
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        return response.data;
      } else {
        throw Exception("Failed To Load Search Data");
      }
    } catch (e) {
      throw Exception("Failed To Load Search Data");
    }
  }
}

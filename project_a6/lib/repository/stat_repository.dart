import 'package:dio/dio.dart';
import 'package:project_a6/model/stat_model.dart';

class StatRepository {
  static Future<List<StatModel>> fetchData({
    required ItemCode itemCode,
  }) async {
    final itemCodeStr = itemCode == ItemCode.PM25 ? 'PM2.5' : itemCode.name;

    final response = await Dio().get(
      'http://apis.data.go.kr/B552584/ArpltnStatsSvc/getCtprvnMesureLIst',
      queryParameters: {
        'serviceKey':
            'VO3QMxvy7tkxR8Bau7iIZjlFOygnzVimIElZfDZvtjtP8EraTCtikLdfK8ut0MJvvIDu/WqPou52izTS4Dd7Jg==',
        'returnType': 'json',
        'numOfRows': 100,
        'pageNo': 1,
        'itemCode': itemCodeStr,
        'dataGubun': 'HOUR',
        'searchCondition': 'WEEK',
      },
    );

    final rawItemsList = response.data['response']['body']['items']
        as List<Map<String, dynamic>>;

    List<StatModel> stats = [];

    final List<String> skipKeys = [
      'dataGubun',
      'dataTime',
      'itemCode',
    ];

    for (Map<String, dynamic> item in rawItemsList) {
      final dateTime = item['dataTime'];

      for (String key in item.keys) {
        if(skipKeys.contains((key))){
          continue;
        }

        final regionStr = key;
        final stat = item[key];

        stats = [
          ...stats,
          StatModel(
            region: Region.values.firstWhere((e) => e.name == regionStr),
            stat: double.parse(stat),
            dateTime: DateTime.parse(dateTime),
            itemCode: itemCode,
          ),
        ];
      }
    }

    return [];
  }
}

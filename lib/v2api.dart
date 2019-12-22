import 'package:dio/dio.dart';

class DioManager {
  String baseUrl = 'https://api.douban.com/v2';
  Dio dio = new Dio();
  static DioManager _instance;
  static DioManager getInstance(){
    if (_instance == null)
      _instance = DioManager();
    return _instance;
  }
  DioManager(){
    dio.options.baseUrl = baseUrl;
  }
  get(String url, MovieParams params) {
    return dio.get(url, queryParameters: params.toMap());
  }
}

class V2Api {
  static getMovieByTag(String tag, {int count, int start, String city}) {
    switch (tag) {
      case '影院热映':
        return getInTheaters(count: count, start: start, city: city);
        break;
      case '即将上映':
        return getComingSoon(start: start, count: count, city: city);
        break;
      default: return getInTheaters(count: count, start: start, city: city);
    }
  }
  static getInTheaters({int count, int start, String city}){
    MovieParams params = MovieParams(start: start, count: count, city: city);
    return DioManager.getInstance().get('/movie/in_theaters', params);
  }
  static getComingSoon({int count, int start, String city}){
    MovieParams params = MovieParams(start: start, count: count, city: city);
    return DioManager.getInstance().get('/movie/coming_soon', params);
  }
  static test(){
    Dio d = Dio();
    return d.get('https://api.douban.com/v2/movie/in_theaters?count=6&apikey=0df993c66c0c636e29ecbb5344252a4a');
  }
}

class MovieParams {
  int start; // 开始页
  int count; // 请求总数
  String q; // 搜索电影时的关键字
  String tag; // 搜索时电影的标签
  String city; // 查询上映电影时的城市（可选，或调用GPS）
  String apikey = '0df993c66c0c636e29ecbb5344252a4a';

  MovieParams({count, start, this.city, this.q, this.tag}) 
    : count = (count == null?6:count),
      start = (start == null?0:start){
        if (city != null) assert(city.isNotEmpty);
        if (q != null) assert(q.isNotEmpty);
        if (tag != null) assert(tag.isNotEmpty);
      }


  Map<String, dynamic> toMap() => <String, dynamic>{
    'start' : start,
    'count' : count,
    'q' : q,
    'tag' : tag,
    'city': city,
    'apikey': apikey
  };

}
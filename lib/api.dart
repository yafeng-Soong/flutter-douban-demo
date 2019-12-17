import 'package:dio/dio.dart';

class DioManager {
  String url = 'https://movie.douban.com/j/search_subjects';
  Map<String, dynamic> headers ={
    'Accept': '*/*',
    'Accept-Encoding': 'gzip, deflate',
    'Accept-Language': 'zh-CN,zh;q=0.9,en;q=0.8,ja;q=0.7',
    'Connection': 'keep-alive',
    'Cookie': 'bid=8VSQrnMZf2w; douban-fav-remind=1; ll="108310"; _vwo_uuid_v2=D14F40DBC90C43A35528A54C34552A826|4d8c269832bd9585d357bf16c18a0bfb; gr_user_id=0e66c455-268a-46b1-8a37-e61f59a443bc; __yadk_uid=P2Ni4mUPtbuT4A13DqRIRxv7oD29WTH0; __gads=ID=93c2e5387f328ac7:T=1564369085:S=ALNI_MaRqAwpBfpJlAVpu083Y8c4-SGbWw; trc_cookie_storage=taboola%2520global%253Auser-id%3Dd7718ddc-9251-45c4-8f00-e58c465be872-tuct44d58c2; viewed="1231910"; __utma=30149280.1946450518.1564133234.1574948122.1576226898.13; __utmc=30149280; __utmz=30149280.1576226898.13.12.utmcsr=baidu|utmccn=(organic)|utmcmd=organic; __utmb=30149280.3.10.1576226898; _pk_ref.100001.4cf6=%5B%22%22%2C%22%22%2C1576226928%2C%22https%3A%2F%2Fwww.douban.com%2F%22%5D; _pk_ses.100001.4cf6=*; __utmc=223695111; ap_v=0,6.0; __utma=223695111.1542422501.1564385769.1576226928.1576228351.3; __utmb=223695111.0.10.1576228351; __utmz=223695111.1576228351.3.3.utmcsr=baidu|utmccn=(organic)|utmcmd=organic; _pk_id.100001.4cf6=2239c76a00301a4a.1564385769.4.1576228370.1567136316.',
    'Host': 'movie.douban.com',
    'Referer': 'https://movie.douban.com/',
    'Sec-Fetch-Mode': 'cors',
    'Sec-Fetch-Site': 'same-origin',
    'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36',
    'X-Requested-With': 'XMLHttpRequest'
  };
  Dio dio = new Dio();
  static DioManager _instance;
  static DioManager getInstance(){
    if (_instance == null)
      _instance = DioManager();
    return _instance;
  }
  DioManager(){
    dio.options.baseUrl = url;
    dio.options.headers = headers;
  }
  get(Params params) {
    return dio.get('/', queryParameters: params.toMap());
  }
}

class DouBanApi {
  static getHotMovie({int limit, int start}){
    Params params = Params('movie', '热门');
    return DioManager.getInstance().get(params);
  }
  static getLatestMovie({int limit, int start}){
    Params params = Params('movie', '最新');
    return DioManager.getInstance().get(params);
  }
  static getMovieByTags(String tags, {int limit, int start}){
    Params params = Params('movie', tags);
    return DioManager.getInstance().get(params);
  }
}

class Params {
  String type;
  String tag;
  int pageLimit;
  int pageStart;

  Params(this.type,
      this.tag,
      {this.pageLimit = 6,
        this.pageStart = 0})
      : assert(type != null), assert(tag != null);


  Map<String, dynamic> toMap() => <String, dynamic>{
    'type' : type,
    'tag' : tag,
    'page_limit' : pageLimit,
    'page_start' : pageStart
  };

}
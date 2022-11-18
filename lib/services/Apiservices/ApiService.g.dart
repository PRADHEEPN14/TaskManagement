// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ApiService.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _ApiService implements ApiService {
  _ApiService(this._dio, {this.baseUrl}) {
    baseUrl ??= 'http://demo.emeetify.com:8080/daytodaytask/';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<GoogleLogin_Res> googlelogin(body) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<GoogleLogin_Res>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, 'app/register',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = GoogleLogin_Res.fromJson(_result.data!);
    return value;
  }

  @override
  Future<Task_Res> createtask(body) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<Task_Res>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, 'timeEntry/createTimeentry',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = Task_Res.fromJson(_result.data!);
    return value;
  }

  @override
  Future<GetallTask_Res> alltask() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<GetallTask_Res>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, 'timeEntry/getAlltimeentries',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = GetallTask_Res.fromJson(_result.data!);
    return value;
  }

  @override
  Future<Update_Res> updateuser(userId, body) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<Update_Res>(
            Options(method: 'PUT', headers: _headers, extra: _extra)
                .compose(_dio.options, 'app/updateUser/${userId}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = Update_Res.fromJson(_result.data!);
    return value;
  }

  @override
  Future<Task_Res> updatetask(dailyTimeId, body) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<Task_Res>(
            Options(method: 'PUT', headers: _headers, extra: _extra)
                .compose(_dio.options,
                    'timeEntry/updateTimeentries?daily_entry_id=${dailyTimeId}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = Task_Res.fromJson(_result.data!);
    return value;
  }

  @override
  Future<Task_Res> deletetask(dailyTimeId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<Task_Res>(
            Options(method: 'DELETE', headers: _headers, extra: _extra)
                .compose(_dio.options,
                    'timeEntry/deleteTimeentries?daily_entry_id=${dailyTimeId}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = Task_Res.fromJson(_result.data!);
    return value;
  }

  @override
  Future<Userupdate_Res> updatedetail(userId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<Userupdate_Res>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, 'app/getUserUpdate/${userId}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = Userupdate_Res.fromJson(_result.data!);
    return value;
  }

  @override
  Future<Datefilter_res> datfilter(firstDate, lastDate, userId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<Datefilter_res>(Options(
                method: 'GET', headers: _headers, extra: _extra)
            .compose(_dio.options,
                'app/dateFilterUser/${userId}?from=${firstDate}&to=${lastDate}',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = Datefilter_res.fromJson(_result.data!);
    return value;
  }

  @override
  Future<userList_res> userlistdetail() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<userList_res>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, 'app/userNames',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = userList_res.fromJson(_result.data!);
    return value;
  }

  @override
  Future<UsertaskList_Res> usertasklist(usernameId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<UsertaskList_Res>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(
                    _dio.options, 'timeEntry/getTimeentryUser/${usernameId}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = UsertaskList_Res.fromJson(_result.data!);
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}

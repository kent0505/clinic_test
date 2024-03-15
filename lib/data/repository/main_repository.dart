import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:sadykova_app/core/error/failures.dart';
import 'package:sadykova_app/data/api/main_api_clent.dart';
import 'package:sadykova_app/features/main/domain/models/action_model.dart';
import 'package:sadykova_app/features/main/domain/models/article_model.dart';
import 'package:sadykova_app/features/main/domain/models/complex_service_model.dart';
import 'package:sadykova_app/features/main/domain/models/contact_model.dart';
import 'package:sadykova_app/features/main/domain/models/equipment_model.dart';
import 'package:sadykova_app/features/main/domain/models/event_model.dart';
import 'package:sadykova_app/features/main/domain/models/news_model.dart';
import 'package:sadykova_app/features/main/domain/models/page_model.dart';

class HomeRepositry {
  HomeRepositry({this.token = ''}) {
    _client = MainApiClient(
      dio: Dio(
        BaseOptions(
          contentType: "application/json",
           headers: {
            if (token.isNotEmpty) 'Authorization': 'Bearer $token',
          },
        ),
      ),
    );
  }
    String token;


  late MainApiClient _client;

  Future<Either<List<NewsModel>, Failure>> getNews() async {
    final result = _client.getNews();
    return result;
  }

  Future<Either<List<ActionsModel>, Failure>> getActions() async {
    final result = _client.getActions();
    return result;
  }

  Future<Either<List<EventModel>, Failure>> getEvents() async {
    final result = _client.getEvents();
    return result;
  }

  Future<Either<List<ArticleModel>, Failure>> getArticles() async {
    final result = _client.getArticles();
    return result;
  }

  Future<Either<NewsModel, Failure>> getNewsDetai({required int id}) async {
    final result = _client.getNewsDetai(id: id);
    return result;
  }

  Future<Either<ArticleModel, Failure>> getArticleDetail(
      {required int id}) async {
    final result = _client.getArticleDetail(id: id);
    return result;
  }

  Future<Either<ActionsModel, Failure>> getActionDetail(
      {required int id}) async {
    final result = _client.getActionDetail(id: id);
    return result;
  }

  Future<Either<EventModel, Failure>> getEventDetail({required int id}) async {
    final result = _client.getEventDetail(id: id);
    return result;
  }

  Future<Either<List<EquipmentModel>, Failure>> getEquipment() async {
    final result = _client.getEquipment();
    return result;
  }

  Future<Either<EquipmentModel, Failure>> getEquipmentDetail(
      {required int id}) async {
    final result = _client.getEquipmentDetail(id: id);
    return result;
  }

  Future<Either<List<ContactMdel>, Failure>> getContacts() async {
    final result = _client.getContacts();
    return result;
  }

  Future<Either<List<PageModel>, Failure>> getPages() async {
    final result = _client.getPages();
    return result;
  }

  Future<Either<List<Object>, Failure>> getTopEvents() async {
    final result = _client.getTopEvents();
    return result;
  }

  Future<Either<List<ComplexServiceModel>, Failure>> getComplexService() async {
    final result = _client.getComplexService();
    return result;
  }
   Future<Either<ComplexServiceModel, Failure>> getComplexDetail(
      {required int id}) async {
    final result = _client.getComplexDetail(id: id);
    return result;
  }
}

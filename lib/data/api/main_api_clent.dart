import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:sadykova_app/core/error/failures.dart';
import 'package:sadykova_app/core/logger/logger_impl.dart';
import 'package:sadykova_app/core/network_check/network_info.dart';
import 'package:sadykova_app/features/main/domain/models/action_model.dart';
import 'package:sadykova_app/features/main/domain/models/article_model.dart';
import 'package:sadykova_app/features/main/domain/models/complex_service_model.dart';
import 'package:sadykova_app/features/main/domain/models/contact_model.dart';
import 'package:sadykova_app/features/main/domain/models/equipment_model.dart';
import 'package:sadykova_app/features/main/domain/models/event_model.dart';
import 'package:sadykova_app/features/main/domain/models/news_model.dart';
import 'package:sadykova_app/features/main/domain/models/page_model.dart';

class MainApiClient {
  final Dio dio;
  String? baseUrl;

  MainApiClient({required this.dio}) {
    baseUrl = dotenv.env['API_URL'];
  }

  Future<Either<List<NewsModel>, Failure>> getNews() async {
    List<NewsModel> newsModels = [];
    try {
      bool hasConnection = await NetworkInfo.isConnected();
      if (!hasConnection) {
        return const Right(
          ConnectionFailure(
            message: 'Нет подключения к интернету',
          ),
        );
      } else {
        var response = await dio.get(baseUrl! + '/api/activities/news');
        if (response.data != null) {
          var list = response.data as List;
          for (var item in list) {
            newsModels.add(NewsModel.fromJson(item));
          }
        }
        return Left(
          newsModels,
        );
      }
    } catch (error) {
      logger.e('$error');
      return const Right(
        ServerFailuer(
          message: 'Ошибка загрузки списка новостей',
        ),
      );
    }
  }

  Future<Either<List<ActionsModel>, Failure>> getActions() async {
    List<ActionsModel> actionsModels = [];
    try {
      bool hasConnection = await NetworkInfo.isConnected();
      if (!hasConnection) {
        return const Right(
          ConnectionFailure(
            message: 'Нет подключения к интернету',
          ),
        );
      } else {
        var response = await dio.get(baseUrl! + '/api/activities/actions');
        if (response.data != null) {
          var list = response.data as List;
          for (var item in list) {
            actionsModels.add(ActionsModel.fromJson(item));
          }
        }
        return Left(
          actionsModels,
        );
      }
    } catch (error) {
      logger.e('$error');
      return const Right(
        ServerFailuer(
          message: 'Ошибка загрузки списка акций',
        ),
      );
    }
  }

  Future<Either<List<EventModel>, Failure>> getEvents() async {
    List<EventModel> eventModels = [];
    try {
      bool hasConnection = await NetworkInfo.isConnected();
      if (!hasConnection) {
        return const Right(
          ConnectionFailure(
            message: 'Нет подключения к интернету',
          ),
        );
      } else {
        var response = await dio.get(baseUrl! + '/api/activities/events');
        if (response.data != null) {
          var list = response.data as List;
          for (var item in list) {
            eventModels.add(EventModel.fromJson(item));
          }
        }
        return Left(
          eventModels,
        );
      }
    } catch (error) {
      logger.e('$error');
      return const Right(
        ServerFailuer(
          message: 'Ошибка загрузки списка собыитий',
        ),
      );
    }
  }

  Future<Either<List<PageModel>, Failure>> getPages() async {
    List<PageModel> articleModels = [];
    try {
      bool hasConnection = await NetworkInfo.isConnected();
      if (!hasConnection) {
        return const Right(
          ConnectionFailure(
            message: 'Нет подключения к интернету',
          ),
        );
      } else {
        var response = await dio.get(baseUrl! + '/api/content/pages');
        if (response.data != null) {
          var list = response.data as List;
          for (var item in list) {
            articleModels.add(PageModel.fromJson(item));
          }
        }
        return Left(
          articleModels,
        );
      }
    } catch (error) {
      logger.e('$error');
      return const Right(
        ServerFailuer(
          message: 'Ошибка загрузки списка статьей',
        ),
      );
    }
  }

  Future<Either<List<ArticleModel>, Failure>> getArticles() async {
    List<ArticleModel> articleModels = [];
    try {
      bool hasConnection = await NetworkInfo.isConnected();
      if (!hasConnection) {
        return const Right(
          ConnectionFailure(
            message: 'Нет подключения к интернету',
          ),
        );
      } else {
        var response = await dio.get(baseUrl! + '/api/activities/articles');
        if (response.data != null) {
          var list = response.data as List;
          for (var item in list) {
            articleModels.add(ArticleModel.fromJson(item));
          }
        }
        return Left(
          articleModels,
        );
      }
    } catch (error) {
      logger.e('$error');
      return const Right(
        ServerFailuer(
          message: 'Ошибка загрузки списка статьей',
        ),
      );
    }
  }

  Future<Either<NewsModel, Failure>> getNewsDetai({required int id}) async {
    try {
      bool hasConnection = await NetworkInfo.isConnected();
      if (!hasConnection) {
        return const Right(
          ConnectionFailure(
            message: 'Нет подключения к интернету',
          ),
        );
      } else {
        var response = await dio.get(baseUrl! + '/api/activites/news/$id');
        if (response.data != null) {
          return Left(
            NewsModel.fromJson(response.data),
          );
        }
        return const Right(
          ServerFailuer(
            message: 'Ошибка подключению к серверу',
          ),
        );
      }
    } catch (error) {
      logger.e('$error');
      return const Right(
        ServerFailuer(
          message: 'Ошибка подключению к серверу',
        ),
      );
    }
  }

  Future<Either<ArticleModel, Failure>> getArticleDetail(
      {required int id}) async {
    try {
      bool hasConnection = await NetworkInfo.isConnected();
      if (!hasConnection) {
        return const Right(
          ConnectionFailure(
            message: 'Нет подключения к интернету',
          ),
        );
      } else {
        var response = await dio.get(baseUrl! + '/api/activites/articles/$id');
        if (response.data != null) {
          return Left(
            ArticleModel.fromJson(response.data),
          );
        }
        return const Right(
          ServerFailuer(
            message: 'Ошибка подключению к серверу',
          ),
        );
      }
    } catch (error) {
      logger.e('$error');
      return const Right(
        ServerFailuer(
          message: 'Ошибка подключению к серверу',
        ),
      );
    }
  }

  Future<Either<ActionsModel, Failure>> getActionDetail(
      {required int id}) async {
    try {
      bool hasConnection = await NetworkInfo.isConnected();
      if (!hasConnection) {
        return const Right(
          ConnectionFailure(
            message: 'Нет подключения к интернету',
          ),
        );
      } else {
        var response = await dio.get(baseUrl! + '/api/activites/actions/$id');
        if (response.data != null) {
          return Left(
            ActionsModel.fromJson(response.data),
          );
        }
        return const Right(
          ServerFailuer(
            message: 'Ошибка подключению к серверу',
          ),
        );
      }
    } catch (error) {
      logger.e('$error');
      return const Right(
        ServerFailuer(
          message: 'Ошибка подключению к серверу',
        ),
      );
    }
  }

  Future<Either<EventModel, Failure>> getEventDetail({required int id}) async {
    try {
      bool hasConnection = await NetworkInfo.isConnected();
      if (!hasConnection) {
        return const Right(
          ConnectionFailure(
            message: 'Нет подключения к интернету',
          ),
        );
      } else {
        var response = await dio.get(baseUrl! + '/api/activities/events/$id');
        if (response.data != null) {
          return Left(
            EventModel.fromJson(response.data),
          );
        }
        return const Right(
          ServerFailuer(
            message: 'Ошибка подключению к серверу',
          ),
        );
      }
    } catch (error) {
      logger.e('$error');
      return const Right(
        ServerFailuer(
          message: 'Ошибка подключению к серверу',
        ),
      );
    }
  }

  Future<Either<List<EquipmentModel>, Failure>> getEquipment() async {
    List<EquipmentModel> equipment = [];
    try {
      bool hasConnection = await NetworkInfo.isConnected();
      if (!hasConnection) {
        return const Right(
          ConnectionFailure(
            message: 'Нет подключения к интернету',
          ),
        );
      } else {
        var response = await dio.get(baseUrl! + '/api/equipments');
        log("getEquipment ${response.data}");
        if (response.data != null) {
          var list = response.data as List;
          for (var item in list) {
            equipment.add(EquipmentModel.fromJson(item));
          }
        }
        return Left(
          equipment,
        );
      }
    } catch (error) {
      logger.e('$error');
      return const Right(
        ServerFailuer(
          message: 'Ошибка загрузки списка новостей',
        ),
      );
    }
  }

  Future<Either<List<ComplexServiceModel>, Failure>> getComplexService() async {
    List<ComplexServiceModel> equipment = [];
    try {
      bool hasConnection = await NetworkInfo.isConnected();
      if (!hasConnection) {
        return const Right(
          ConnectionFailure(
            message: 'Нет подключения к интернету',
          ),
        );
      } else {
        var response = await dio.get(baseUrl! + '/api/complex');

        if (response.data != null) {
          var list = response.data as List;
          for (var item in list) {
            equipment.add(ComplexServiceModel.fromJson(item));
          }
        }
        return Left(
          equipment,
        );
      }
    } catch (error) {
      logger.e('$error');
      return const Right(
        ServerFailuer(
          message: 'Ошибка загрузки списка новостей',
        ),
      );
    }
  }

  Future<Either<List<Object>, Failure>> getTopEvents() async {
    List<Object> topList = [];
    try {
      bool hasConnection = await NetworkInfo.isConnected();
      if (!hasConnection) {
        return const Right(
          ConnectionFailure(
            message: 'Нет подключения к интернету',
          ),
        );
      } else {
        var response = await dio.get(baseUrl! + '/api/activities/top');

        if (response.data != null) {
          var list = response.data as List;
          for (var item in list) {
            if (item['type'] == "Новости") {
              topList.add(NewsModel.fromJson(item));
            } else if (item['type'] == "Акция") {
              topList.add(ActionsModel.fromJson(item));
            } else {
              topList.add(EventModel.fromJson(item));
            }
          }
        }
        return Left(
          topList,
        );
      }
    } catch (error) {
      logger.e('$error');
      return const Right(
        ServerFailuer(
          message: 'Ошибка загрузки списка новостей',
        ),
      );
    }
  }

  Future<Either<EquipmentModel, Failure>> getEquipmentDetail(
      {required int id}) async {
    try {
      bool hasConnection = await NetworkInfo.isConnected();
      if (!hasConnection) {
        return const Right(
          ConnectionFailure(
            message: 'Нет подключения к интернету',
          ),
        );
      } else {
        var response = await dio.get(baseUrl! + '/api/equipments/$id');
        if (response.data != null) {
          return Left(
            EquipmentModel.fromJson(response.data),
          );
        }
        return const Right(
          ServerFailuer(
            message: 'Ошибка подключению к серверу',
          ),
        );
      }
    } catch (error) {
      logger.e('$error');
      return const Right(
        ServerFailuer(
          message: 'Ошибка подключению к серверу',
        ),
      );
    }
  }

  Future<Either<ComplexServiceModel, Failure>> getComplexDetail(
      {required int id}) async {
    try {
      bool hasConnection = await NetworkInfo.isConnected();
      if (!hasConnection) {
        return const Right(
          ConnectionFailure(
            message: 'Нет подключения к интернету',
          ),
        );
      } else {
        var response = await dio.get(baseUrl! + '/api/complex/$id');
        if (response.data != null) {
          return Left(
            ComplexServiceModel.fromJson(response.data),
          );
        }
        return const Right(
          ServerFailuer(
            message: 'Ошибка подключению к серверу',
          ),
        );
      }
    } catch (error) {
      logger.e('$error');
      return const Right(
        ServerFailuer(
          message: 'Ошибка подключению к серверу',
        ),
      );
    }
  }

  Future<Either<List<ContactMdel>, Failure>> getContacts() async {
    List<ContactMdel> equipment = [];
    try {
      bool hasConnection = await NetworkInfo.isConnected();
      if (!hasConnection) {
        return const Right(
          ConnectionFailure(
            message: 'Нет подключения к интернету',
          ),
        );
      } else {
        var response = await dio.get(baseUrl! + '/api/content/contacts');

        if (response.data != null) {
          var list = response.data as List;
          for (var item in list) {
            equipment.add(ContactMdel.fromJson(item));
          }
        }
        return Left(
          equipment,
        );
      }
    } catch (error) {
      logger.e('$error');
      return const Right(
        ServerFailuer(
          message: 'Ошибка загрузки списка новостей',
        ),
      );
    }
  }
}

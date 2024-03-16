import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sadykova_app/core/error/failures.dart';
import 'package:sadykova_app/data/repository/main_repository.dart';
import 'package:sadykova_app/features/main/domain/models/action_model.dart';
import 'package:sadykova_app/features/main/domain/models/article_model.dart';
import 'package:sadykova_app/features/main/domain/models/complex_service_model.dart';
import 'package:sadykova_app/features/main/domain/models/contact_model.dart';
import 'package:sadykova_app/features/main/domain/models/equipment_model.dart';
import 'package:sadykova_app/features/main/domain/models/event_enum.dart';
import 'package:sadykova_app/features/main/domain/models/event_model.dart';
import 'package:sadykova_app/features/main/domain/models/news_model.dart';
import 'package:sadykova_app/features/main/domain/models/notifications_model.dart';
import 'package:sadykova_app/features/main/domain/models/page_model.dart';

class HomeProvider extends ChangeNotifier {
  HomeProvider() {
    // _userProvider = userProvider;
    // if (userProvider.user != null && userProvider.user!.token != null) {
    //   repository = HomeRepositry(token: userProvider.user!.token ?? '');
    // }
    // createNotifications();
  }

  bool notificationVisible = true;

  void closeNotification() {
    notificationVisible = false;
    notifyListeners();
  }

  EventType eventType = EventType.actions;
  HomeRepositry repository = HomeRepositry();

  List<Object> topEventList = [];
  List<NewsModel> newsList = [];
  NewsModel? selectNews;
  List<ArticleModel> articleList = [];
  List<PageModel> pageList = [];
  ArticleModel? selectArticle;
  List<EventModel> eventList = [];
  EventModel? selectEvent;
  List<ActionsModel> actionList = [];
  ActionsModel? selectActions;
  List<EquipmentModel> equipmentModelList = [];
  EquipmentModel? selectEquiment;
  List<ComplexServiceModel> complexServiceModel = [];
  ComplexServiceModel? serviceComplexServiceModel;
  List<NotificationsModels> notificationModels = [
    NotificationsModels(
      date: "12.10.2021",
      photo:
          'https://img.freepik.com/free-photo/happy-male-doctor-making-selfie-photo-with-smartphone-on-white-background_230311-7374.jpg?w=2000',
      message: 'Дерматолог, Диляра Ильдусовна',
      notificationType: 'doctor',
      title: '19 окт, четверг 14:30',
      isNew: true,
    ),
    NotificationsModels(
      date: "14.10.2021",
      message: 'Посмотреть результаты можно в личном кабинете',
      notificationType: 'result',
      title: 'Готовы результаты анализов',
      isNew: false,
    ),
    NotificationsModels(
      date: "12.10.2021",
      photo:
          'https://img.freepik.com/free-photo/happy-male-doctor-making-selfie-photo-with-smartphone-on-white-background_230311-7374.jpg?w=2000',
      message: 'Дерматолог, Диляра Ильдусовна',
      notificationType: 'doctor',
      title: '19 окт, четверг 14:30',
      isNew: true,
    ),
    NotificationsModels(
      date: "14.10.2021",
      message: 'Посмотреть результаты можно в личном кабинете',
      notificationType: 'result',
      title: 'Готовы результаты анализов',
      isNew: false,
    ),
    NotificationsModels(
      date: "12.10.2021",
      photo:
          'https://img.freepik.com/free-photo/happy-male-doctor-making-selfie-photo-with-smartphone-on-white-background_230311-7374.jpg?w=2000',
      message: 'Дерматолог, Диляра Ильдусовна',
      notificationType: 'doctor',
      title: '19 окт, четверг 14:30',
      isNew: true,
    ),
    NotificationsModels(
      date: "14.10.2021",
      message: 'Посмотреть результаты можно в личном кабинете',
      notificationType: 'result',
      title: 'Готовы результаты анализов',
      isNew: false,
    ),
  ];
  List<ContactMdel> contactsList = [];

  Failure? error;

  ///[loading]
  bool _loading = false;
  bool get loading => _loading;
  set loading(bool flag) {
    _loading = flag;
    notifyListeners();
  }

  ///[pageLoading]
  bool _pageLoading = false;
  bool get pageLoading => _pageLoading;
  set pageLoading(bool flag) {
    _pageLoading = flag;
    notifyListeners();
  }

  ///[equipmentLoader]
  bool _equipmentLoader = false;
  bool get equipmentLoader => _equipmentLoader;
  set equipmentLoader(bool flag) {
    _equipmentLoader = flag;
    notifyListeners();
  }

  ///[complexLoader]
  bool complexLoader = false;

  ///[loading]
  bool _eventLoader = false;
  bool get eventLoader => _eventLoader;
  set eventLoader(bool flag) {
    _eventLoader = flag;
    notifyListeners();
  }

  Future<void> getContacts() async {
    try {
      clearError();
      loading = true;
      var result = await repository.getContacts();
      result.fold((left) {
        contactsList = left;
      }, (right) {
        error = right;
      });
    } catch (error) {
      log("Erorr $error");
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  Future<void> getNews() async {
    try {
      clearError();
      loading = true;
      var result = await repository.getNews();
      result.fold((left) {
        newsList = left;
      }, (right) {
        error = right;
      });
    } catch (error) {
      log("Erorr $error");
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  Future<void> getTopEvents() async {
    try {
      clearError();
      loading = true;
      var result = await repository.getTopEvents();
      result.fold((left) {
        topEventList = left;
      }, (right) {
        error = right;
      });
    } catch (error) {
      log("Erorr $error");
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  Future<void> getEquipments() async {
    try {
      clearError();
      loading = true;
      var result = await repository.getEquipment();
      result.fold((left) {
        equipmentModelList = left;
      }, (right) {
        error = right;
      });
    } catch (error) {
      log("Erorr $error");
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  Future<void> getComplexService() async {
    try {
      clearError();
      loading = true;
      var result = await repository.getComplexService();
      result.fold((left) {
        complexServiceModel = left;
      }, (right) {
        error = right;
      });
    } catch (error) {
      log("Erorr $error");
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  Future<ComplexServiceModel?> getComplexDetail({required int id}) async {
    try {
      serviceComplexServiceModel = null;
      clearError();
      complexLoader = true;
      var result = await repository.getComplexDetail(id: id);
      result.fold((left) {
        serviceComplexServiceModel = left;
      }, (right) {
        error = right;
      });
    } catch (error) {
      log("Erorr $error");
    } finally {
      complexLoader = false;
      notifyListeners();
    }
    return serviceComplexServiceModel;
  }

  Future<EquipmentModel?> getEquipmentDetail({required int id}) async {
    try {
      selectEquiment = null;
      clearError();
      equipmentLoader = true;
      var result = await repository.getEquipmentDetail(id: id);
      result.fold((left) {
        selectEquiment = left;
      }, (right) {
        error = right;
      });
    } catch (error) {
      log("Erorr $error");
    } finally {
      equipmentLoader = false;
      notifyListeners();
    }
    return selectEquiment;
  }

  Future<void> getActions() async {
    try {
      clearError();
      loading = true;
      var result = await repository.getActions();
      result.fold((left) {
        actionList = left;
      }, (right) {
        error = right;
      });
    } catch (error) {
      log("Erorr $error");
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  Future<void> getEvents() async {
    try {
      clearError();
      loading = true;
      var result = await repository.getEvents();
      result.fold((left) {
        eventList = left;
      }, (right) {
        error = right;
      });
    } catch (error) {
      log("Erorr $error");
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  Future<void> getArticles() async {
    try {
      clearError();
      loading = true;
      var result = await repository.getArticles();
      result.fold((left) {
        articleList = left;
      }, (right) {
        error = right;
      });
    } catch (error) {
      log("Erorr $error");
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  Future<bool> getPages() async {
    bool isSucees = false;
    try {
      clearError();
      pageLoading = true;
      var result = await repository.getPages();
      result.fold((left) {
        isSucees = true;
        pageList = left;
      }, (right) {
        error = right;
      });
    } catch (error) {
      log("Erorr $error");
    } finally {
      pageLoading = false;
      notifyListeners();
    }
    return isSucees;
  }

  Future<void> getNewsDetail({required int id}) async {
    try {
      clearError();
      loading = true;
      var result = await repository.getNewsDetai(id: id);
      result.fold((left) {
        selectNews = left;
      }, (right) {
        error = right;
      });
    } catch (error) {
      log("Erorr $error");
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  Future<void> getActionDetail({required int id}) async {
    try {
      clearError();
      loading = true;
      var result = await repository.getActionDetail(id: id);
      result.fold((left) {
        selectActions = left;
      }, (right) {
        error = right;
      });
    } catch (error) {
      log("Erorr $error");
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  Future<bool> getEventDetail({required int id}) async {
    bool isSucces = false;

    try {
      clearError();
      eventLoader = true;
      var result = await repository.getEventDetail(id: id);
      result.fold((left) {
        selectEvent = left;
        isSucces = true;
      }, (right) {
        error = right;
      });
    } catch (error) {
      log("Erorr $error");
    } finally {
      eventLoader = false;
      notifyListeners();
    }
    return isSucces;
  }

  Future<void> getArticleDetail({required int id}) async {
    try {
      clearError();
      loading = true;
      var result = await repository.getArticleDetail(id: id);
      result.fold((left) {
        selectArticle = left;
      }, (right) {
        error = right;
      });
    } catch (error) {
      log("Erorr $error");
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  void clearError({bool isNeedNotifilistenres = false}) {
    error = null;
    if (isNeedNotifilistenres) {
      notifyListeners();
    }
  }

  ///requests

  void changeEventType(int index) {
    switch (index) {
      case 0:
        eventType = EventType.actions;
        getActions();
        break;
      case 1:
        eventType = EventType.news;
        getNews();
        break;
      case 2:
        eventType = EventType.events;
        getEvents();
        break;
    }
    notifyListeners();
  }

  void createNotifications() {
    notificationModels.addAll([
      NotificationsModels(
        date: "12.10.2021",
        photo:
            'https://img.freepik.com/free-photo/happy-male-doctor-making-selfie-photo-with-smartphone-on-white-background_230311-7374.jpg?w=2000',
        message: 'Дерматолог, Диляра Ильдусовна',
        notificationType: 'doctor',
        title: '19 окт, четверг 14:30',
        isNew: true,
      ),
      NotificationsModels(
        date: "14.10.2021",
        message: 'Посмотреть результаты можно в личном кабинете',
        notificationType: 'result',
        title: 'Готовы результаты анализов',
        isNew: false,
      ),
    ]);
  }
}

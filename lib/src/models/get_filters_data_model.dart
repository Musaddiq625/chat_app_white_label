/// code : 200
/// status : true
/// message : "Data retrieved successfully"
/// description : ""
/// data : {"categoryData":[{"_id":"66503af6c4284c0af8bed567","title":"Music","slug":"music"},{"_id":"66503b42c4284c0af8bed568","title":"Art","slug":"art"},{"_id":"66503b4dc4284c0af8bed569","title":"Health","slug":"Health"},{"_id":"66503b6ac4284c0af8bed56a","title":"Food & Drink","slug":"food_&_drink"},{"_id":"66503b7ec4284c0af8bed56b","title":"Community","slug":"community"},{"_id":"66503b8dc4284c0af8bed56c","title":"Business","slug":"business"},{"_id":"66503b98c4284c0af8bed56d","title":"Tech","slug":"tech"},{"_id":"66503ba7c4284c0af8bed56e","title":"Seasonal","slug":"seasonal"},{"_id":"66503bb1c4284c0af8bed56f","title":"Fasion","slug":"fasion"},{"_id":"66503bc9c4284c0af8bed570","title":"Travel & Outdoor","slug":"travel_&_outdoor"}],"dateFilterData":[{"_id":"66503db8e9339e27106c005a","title":"Today","slug":"today"},{"_id":"66503dd1e9339e27106c005b","title":"Tomorrow","slug":"tomorrow"},{"_id":"66503de6e9339e27106c005c","title":"This Week","slug":"this_week"},{"_id":"66503df8e9339e27106c005d","title":"This weekend","slug":"this_weekend"}]}
/// meta : {"totalCount":12,"defaultPageLimit":10,"pages":1,"pageSizes":10,"remainingCount":2}

class GetFiltersDataModel {
  GetFiltersDataModel({
      this.code, 
      this.status, 
      this.message, 
      this.description, 
      this.filterListModel,
      this.meta,});

  GetFiltersDataModel.fromJson(dynamic json) {
    code = json['code'];
    status = json['status'];
    message = json['message'];
    description = json['description'];
    filterListModel = json['data'] != null ? FiltersListModel.fromJson(json['data']) : null;
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
  }
  num? code;
  bool? status;
  String? message;
  String? description;
  FiltersListModel? filterListModel;
  Meta? meta;
GetFiltersDataModel copyWith({  num? code,
  bool? status,
  String? message,
  String? description,
  FiltersListModel? filterListModel,
  Meta? meta,
}) => GetFiltersDataModel(  code: code ?? this.code,
  status: status ?? this.status,
  message: message ?? this.message,
  description: description ?? this.description,
  filterListModel: filterListModel ?? this.filterListModel,
  meta: meta ?? this.meta,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = code;
    map['status'] = status;
    map['message'] = message;
    map['description'] = description;
    if (filterListModel != null) {
      map['data'] = filterListModel?.toJson();
    }
    if (meta != null) {
      map['meta'] = meta?.toJson();
    }
    return map;
  }

}

/// totalCount : 12
/// defaultPageLimit : 10
/// pages : 1
/// pageSizes : 10
/// remainingCount : 2

class Meta {
  Meta({
      this.totalCount, 
      this.defaultPageLimit, 
      this.pages, 
      this.pageSizes, 
      this.remainingCount,});

  Meta.fromJson(dynamic json) {
    totalCount = json['totalCount'];
    defaultPageLimit = json['defaultPageLimit'];
    pages = json['pages'];
    pageSizes = json['pageSizes'];
    remainingCount = json['remainingCount'];
  }
  num? totalCount;
  num? defaultPageLimit;
  num? pages;
  num? pageSizes;
  num? remainingCount;
Meta copyWith({  num? totalCount,
  num? defaultPageLimit,
  num? pages,
  num? pageSizes,
  num? remainingCount,
}) => Meta(  totalCount: totalCount ?? this.totalCount,
  defaultPageLimit: defaultPageLimit ?? this.defaultPageLimit,
  pages: pages ?? this.pages,
  pageSizes: pageSizes ?? this.pageSizes,
  remainingCount: remainingCount ?? this.remainingCount,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['totalCount'] = totalCount;
    map['defaultPageLimit'] = defaultPageLimit;
    map['pages'] = pages;
    map['pageSizes'] = pageSizes;
    map['remainingCount'] = remainingCount;
    return map;
  }

}

/// categoryData : [{"_id":"66503af6c4284c0af8bed567","title":"Music","slug":"music"},{"_id":"66503b42c4284c0af8bed568","title":"Art","slug":"art"},{"_id":"66503b4dc4284c0af8bed569","title":"Health","slug":"Health"},{"_id":"66503b6ac4284c0af8bed56a","title":"Food & Drink","slug":"food_&_drink"},{"_id":"66503b7ec4284c0af8bed56b","title":"Community","slug":"community"},{"_id":"66503b8dc4284c0af8bed56c","title":"Business","slug":"business"},{"_id":"66503b98c4284c0af8bed56d","title":"Tech","slug":"tech"},{"_id":"66503ba7c4284c0af8bed56e","title":"Seasonal","slug":"seasonal"},{"_id":"66503bb1c4284c0af8bed56f","title":"Fasion","slug":"fasion"},{"_id":"66503bc9c4284c0af8bed570","title":"Travel & Outdoor","slug":"travel_&_outdoor"}]
/// dateFilterData : [{"_id":"66503db8e9339e27106c005a","title":"Today","slug":"today"},{"_id":"66503dd1e9339e27106c005b","title":"Tomorrow","slug":"tomorrow"},{"_id":"66503de6e9339e27106c005c","title":"This Week","slug":"this_week"},{"_id":"66503df8e9339e27106c005d","title":"This weekend","slug":"this_weekend"}]

class FiltersListModel {
  FiltersListModel({
      this.categoryData, 
      this.dateFilterData,});

  FiltersListModel.fromJson(dynamic json) {
    if (json['categoryData'] != null) {
      categoryData = [];
      json['categoryData'].forEach((v) {
        categoryData?.add(CategoryData.fromJson(v));
      });
    }
    if (json['dateFilterData'] != null) {
      dateFilterData = [];
      json['dateFilterData'].forEach((v) {
        dateFilterData?.add(DateFilterData.fromJson(v));
      });
    }
  }
  List<CategoryData>? categoryData;
  List<DateFilterData>? dateFilterData;
FiltersListModel copyWith({  List<CategoryData>? categoryData,
  List<DateFilterData>? dateFilterData,
}) => FiltersListModel(  categoryData: categoryData ?? this.categoryData,
  dateFilterData: dateFilterData ?? this.dateFilterData,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (categoryData != null) {
      map['categoryData'] = categoryData?.map((v) => v.toJson()).toList();
    }
    if (dateFilterData != null) {
      map['dateFilterData'] = dateFilterData?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// _id : "66503db8e9339e27106c005a"
/// title : "Today"
/// slug : "today"

class DateFilterData {
  DateFilterData({
      this.id, 
      this.title, 
      this.slug,});

  DateFilterData.fromJson(dynamic json) {
    id = json['_id'];
    title = json['title'];
    slug = json['slug'];
  }
  String? id;
  String? title;
  String? slug;
DateFilterData copyWith({  String? id,
  String? title,
  String? slug,
}) => DateFilterData(  id: id ?? this.id,
  title: title ?? this.title,
  slug: slug ?? this.slug,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['title'] = title;
    map['slug'] = slug;
    return map;
  }

}

/// _id : "66503af6c4284c0af8bed567"
/// title : "Music"
/// slug : "music"

class CategoryData {
  CategoryData({
      this.id, 
      this.title, 
      this.slug,});

  CategoryData.fromJson(dynamic json) {
    id = json['_id'];
    title = json['title'];
    slug = json['slug'];
  }
  String? id;
  String? title;
  String? slug;
CategoryData copyWith({  String? id,
  String? title,
  String? slug,
}) => CategoryData(  id: id ?? this.id,
  title: title ?? this.title,
  slug: slug ?? this.slug,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['title'] = title;
    map['slug'] = slug;
    return map;
  }

}
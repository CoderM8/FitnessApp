class FitnessModel {
  final String id;
  final String catId;
  final int totalCat;
  final List<Category> catList;
  final String featured;
  final String title;
  final String img;
  final String time;
  final String kcal;
  final String fileType;
  final String fileUrl;
  final String levelType;
  final String exerciseType;
  final String totalRate;
  final String rateAvg;
  final String views;
  final String desc;
  final List<RelateModel> relatedList;

  FitnessModel({
    required this.id,
    required this.catId,
    required this.totalCat,
    required this.catList,
    required this.featured,
    required this.title,
    required this.img,
    required this.time,
    required this.kcal,
    required this.fileType,
    required this.fileUrl,
    required this.levelType,
    required this.exerciseType,
    required this.totalRate,
    required this.rateAvg,
    required this.views,
    required this.desc,
    required this.relatedList,
  });

  factory FitnessModel.fromJson(Map<String, dynamic> json) => FitnessModel(
        id: json["id"] ?? "",
        catId: json["cat_id"] ?? "",
        totalCat: json["total_category"] ?? 0,
        catList: List<Category>.from(json["category_list"].map((x) => Category.fromJson(x))),
        featured: json["featured"] ?? "",
        title: json["exercise_title"] ?? "",
        img: json["exercise_cover_img"] ?? "",
        time: json["exercise_time"] ?? "",
        kcal: json["exercise_kcal"] ?? "",
        fileType: json["exercise_file_type"] ?? "",
        fileUrl: json["exercise_file_url"] ?? "",
        levelType: json["exercise_level_type"] ?? "",
        exerciseType: json["exercise_type"] ?? "",
        totalRate: json["total_rate"] ?? "",
        rateAvg: json["rate_avg"] ?? "",
        views: json["exercise_views"] ?? "",
        desc: json["exercise_desc"] ?? "",
        relatedList: List<RelateModel>.from(json["related_exercises"].map((x) => RelateModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "cat_id": catId,
        "total_category": totalCat,
        "category_list": List<dynamic>.from(catList.map((x) => x.toJson())),
        "featured": featured,
        "exercise_title": title,
        "exercise_cover_img": img,
        "exercise_time": time,
        "exercise_kcal": kcal,
        "exercise_file_type": fileType,
        "exercise_file_url": fileUrl,
        "exercise_level_type": levelType,
        "exercise_type": exerciseType,
        "total_rate": totalRate,
        "rate_avg": rateAvg,
        "exercise_views": views,
        "exercise_desc": desc,
        "related_exercises": List<dynamic>.from(relatedList.map((x) => x.toJson())),
      };
}

class RelateModel {
  final String id;
  final String catId;
  final int totalCat;
  final List<Category> catList;
  final String featured;
  final String title;
  final String img;
  final String time;
  final String kcal;
  final String fileType;
  final String fileUrl;
  final String levelType;
  final String exerciseType;
  final String totalRate;
  final String rateAvg;
  final String views;
  final String desc;

  RelateModel({
    required this.id,
    required this.catId,
    required this.totalCat,
    required this.catList,
    required this.featured,
    required this.title,
    required this.img,
    required this.time,
    required this.kcal,
    required this.fileType,
    required this.fileUrl,
    required this.levelType,
    required this.exerciseType,
    required this.totalRate,
    required this.rateAvg,
    required this.views,
    required this.desc,
  });

  factory RelateModel.fromJson(Map<String, dynamic> json) => RelateModel(
        id: json["id"] ?? "",
        catId: json["cat_id"] ?? "",
        totalCat: json["total_category"] ?? 0,
        catList: List<Category>.from(json["category_list"].map((x) => Category.fromJson(x))),
        featured: json["featured"] ?? "",
        title: json["exercise_title"] ?? "",
        img: json["exercise_cover_img"] ?? "",
        time: json["exercise_time"] ?? "",
        kcal: json["exercise_kcal"] ?? "",
        fileType: json["exercise_file_type"] ?? "",
        fileUrl: json["exercise_file_url"] ?? "",
        levelType: json["exercise_level_type"] ?? "",
        exerciseType: json["exercise_type"] ?? "",
        totalRate: json["total_rate"] ?? "",
        rateAvg: json["rate_avg"] ?? "",
        views: json["exercise_views"] ?? "",
        desc: json["exercise_desc"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "cat_id": catId,
        "total_category": totalCat,
        "category_list": List<dynamic>.from(catList.map((x) => x.toJson())),
        "featured": featured,
        "exercise_title": title,
        "exercise_cover_img": img,
        "exercise_time": time,
        "exercise_kcal": kcal,
        "exercise_file_type": fileType,
        "exercise_file_url": fileUrl,
        "exercise_level_type": levelType,
        "exercise_type": exerciseType,
        "total_rate": totalRate,
        "rate_avg": rateAvg,
        "exercise_views": views,
        "exercise_desc": desc,
      };
}

class Category {
  final String cid;
  final String title;
  final String img;
  final String thumb;

  const Category({required this.cid, required this.title, required this.img, required this.thumb});

  factory Category.fromJson(Map<String, dynamic> json) =>
      Category(cid: json["cid"] ?? "", title: json["category_name"] ?? "", img: json["category_image"] ?? "", thumb: json["category_image_thumb"] ?? "");

  Map<String, dynamic> toJson() => {"cid": cid, "category_name": title, "category_image": img, "category_image_thumb": thumb};
}

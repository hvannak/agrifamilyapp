class PageOptModel {
  int page;
  int itemsPerPage;
  List<String> sortBy;
  List<String> sortDesc;
  PageOptModel({this.page,this.itemsPerPage,this.sortBy,this.sortDesc});
  Map<String, dynamic> toJson() => _$PageOptDataToJson(this);
}

Map<String, dynamic> _$PageOptDataToJson(PageOptModel instance) => <String, dynamic>{
    'page': instance.page,
    'itemsPerPage':instance.itemsPerPage,
    'sortBy': instance.sortBy,
    'sortDesc': instance.sortDesc
    };
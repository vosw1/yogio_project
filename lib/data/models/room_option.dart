class RoomOption {
  int id;
  String imageName;
  String imagePath;
  String tier;
  int price;
  int salePrice;
  String saleState;
  Information information;
  List<RoomDetailOption> options;
  String notice;

  RoomOption({
    required this.id,
    required this.imageName,
    required this.imagePath,
    required this.tier,
    required this.price,
    required this.salePrice,
    required this.saleState,
    required this.information,
    required this.options,
    required this.notice,
  });

  @override
  String toString() {
    return 'RoomOption'
        '{id: $id, imageName: $imageName, imagePath: $imagePath, tier: $tier, price: $price, salePrice: $salePrice, saleState: $saleState, information: $information, options: $options, notice: $notice}\n';
  }

  factory RoomOption.fromJson(Map<String, dynamic> json) => RoomOption(
        id: json["id"],
        imageName: json["imageName"] ?? 'room1.jpg',
        imagePath: json["imagePath"] ?? '',
        tier: json["tier"],
        price: json["price"] ?? '',
        salePrice: json["salePrice"] ?? '',
        saleState: json["saleState"] ?? '',
        information: Information.fromJson(json["information"]),
        options: List<RoomDetailOption>.from(
            json["options"].map((x) => RoomDetailOption.fromJson(x))),
        notice: json["notice"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "imageName": imageName,
        "imagePath": imagePath,
        "tier": tier,
        "price": price,
        "salePrice": salePrice,
        "saleState": saleState,
        "information": information.toJson(),
        "options": List<dynamic>.from(options.map((x) => x.toJson())),
        "notice": notice,
      };
}

class RoomDetailOption {
  String name;
  String iconName;

  RoomDetailOption({
    required this.name,
    required this.iconName,
  });

  @override
  String toString() {
    return '$name, $iconName';
  }

  factory RoomDetailOption.fromJson(Map<String, dynamic> json) =>
      RoomDetailOption(
        name: json["name"] ?? "",
        iconName: json["iconName"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "name": name ?? "",
        "iconName": iconName ?? "",
      };
}

class Information {
  int minPerson;
  int maxPerson;
  String? announcement;
  String? basicInformation;
  String moreinfo;

  Information({
    required this.minPerson,
    required this.maxPerson,
    required this.announcement,
    required this.basicInformation,
    required this.moreinfo,
  });

  @override
  String toString() {
    return '최소인원: $minPerson,\n최대인원: $maxPerson,\n조식제공: $moreinfo,\n기본정보: $basicInformation,\n공지: $announcement';
  }

  factory Information.fromJson(Map<String, dynamic> json) => Information(
        minPerson: json["minPerson"] ?? "",
        maxPerson: json["maxPerson"] ?? "",
        announcement: json["announcement"] ?? "",
        basicInformation: json["basicInformation"] ?? "",
        moreinfo: json["moreinfo"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "minPerson": minPerson,
        "maxPerson": maxPerson,
        "announcement": announcement,
        "basicInformation": basicInformation,
        "moreinfo": moreinfo,
      };
}

///Fetch Session And Chat Prices

class SessionPrice {
  bool? status;
  String? message;
  Results? results;

  SessionPrice({this.status, this.message, this.results});

  SessionPrice.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    results =
    json['results'] != null ? new Results.fromJson(json['results']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.results != null) {
      data['results'] = this.results!.toJson();
    }
    return data;
  }
}

class Results {
  List<SessionPrices>? sessionPrices;
  List<ChatPrices>? chatPrices;

  Results({this.sessionPrices, this.chatPrices});

  Results.fromJson(Map<String, dynamic> json) {
    if (json['session_prices'] != null) {
      sessionPrices = <SessionPrices>[];
      json['session_prices'].forEach((v) {
        sessionPrices!.add(new SessionPrices.fromJson(v));
      });
    }
    if (json['chat_prices'] != null) {
      chatPrices = <ChatPrices>[];
      json['chat_prices'].forEach((v) {
        chatPrices!.add(new ChatPrices.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.sessionPrices != null) {
      data['session_prices'] =
          this.sessionPrices!.map((v) => v.toJson()).toList();
    }
    if (this.chatPrices != null) {
      data['chat_prices'] = this.chatPrices!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SessionPrices {
  int? id;
  int? sessionPrice;
  String? type;

  SessionPrices({this.id, this.sessionPrice, this.type});

  SessionPrices.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sessionPrice = json['session_price'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['session_price'] = this.sessionPrice;
    data['type'] = this.type;
    return data;
  }
}

class ChatPrices {
  int? id;
  Null? chatSessionPrice;
  String? type;

  ChatPrices({this.id, this.chatSessionPrice, this.type});

  ChatPrices.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    chatSessionPrice = json['chat_session_price'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['chat_session_price'] = this.chatSessionPrice;
    data['type'] = this.type;
    return data;
  }
}

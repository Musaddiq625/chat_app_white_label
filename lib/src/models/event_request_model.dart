/// id : 111
/// event_name : "abc-event"
/// user_id : 123123
/// event_id : 12312312
/// request_status : "accept/rejected/true/false"
/// event_questions : {"question_1":{"question":"abc question","answer":"answer of the question"},"question_2":{"question":"abc question","answer":"answer of the question"}}
/// query : {"question":"abc query","answer":"abc answer of the query"}

class EventRequestModel {
  EventRequestModel({
      this.id, 
      this.eventName, 
      this.userId, 
      this.eventId, 
      this.requestStatus, 
      this.eventQuestions, 
      this.query,});

  EventRequestModel.fromJson(dynamic json) {
    id = json['id'];
    eventName = json['event_name'];
    userId = json['user_id'];
    eventId = json['event_id'];
    requestStatus = json['request_status'];
    eventQuestions = json['event_questions'] != null ? EventQuestions.fromJson(json['event_questions']) : null;
    query = json['query'] != null ? Query.fromJson(json['query']) : null;
  }
  num? id;
  String? eventName;
  num? userId;
  num? eventId;
  String? requestStatus;
  EventQuestions? eventQuestions;
  Query? query;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['event_name'] = eventName;
    map['user_id'] = userId;
    map['event_id'] = eventId;
    map['request_status'] = requestStatus;
    if (eventQuestions != null) {
      map['event_questions'] = eventQuestions?.toJson();
    }
    if (query != null) {
      map['query'] = query?.toJson();
    }
    return map;
  }

}

/// question : "abc query"
/// answer : "abc answer of the query"

class Query {
  Query({
      this.question, 
      this.answer,});

  Query.fromJson(dynamic json) {
    question = json['question'];
    answer = json['answer'];
  }
  String? question;
  String? answer;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['question'] = question;
    map['answer'] = answer;
    return map;
  }

}

/// question_1 : {"question":"abc question","answer":"answer of the question"}
/// question_2 : {"question":"abc question","answer":"answer of the question"}

class EventQuestions {
  EventQuestions({
      this.question1, 
      this.question2,});

  EventQuestions.fromJson(dynamic json) {
    question1 = json['question_1'] != null ? Question1.fromJson(json['question_1']) : null;
    question2 = json['question_2'] != null ? Question2.fromJson(json['question_2']) : null;
  }
  Question1? question1;
  Question2? question2;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (question1 != null) {
      map['question_1'] = question1?.toJson();
    }
    if (question2 != null) {
      map['question_2'] = question2?.toJson();
    }
    return map;
  }

}

/// question : "abc question"
/// answer : "answer of the question"

class Question2 {
  Question2({
      this.question, 
      this.answer,});

  Question2.fromJson(dynamic json) {
    question = json['question'];
    answer = json['answer'];
  }
  String? question;
  String? answer;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['question'] = question;
    map['answer'] = answer;
    return map;
  }

}

/// question : "abc question"
/// answer : "answer of the question"

class Question1 {
  Question1({
      this.question, 
      this.answer,});

  Question1.fromJson(dynamic json) {
    question = json['question'];
    answer = json['answer'];
  }
  String? question;
  String? answer;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['question'] = question;
    map['answer'] = answer;
    return map;
  }

}
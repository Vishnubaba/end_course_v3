import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Geo {
  final String lat;
  final String lng;

  const Geo({
    required this.lat,
    required this.lng,
  });
}

class Address {
  final String street;
  final String suite;
  final String city;
  final String zipcode;
  final Geo geo;

  const Address ({
    required this.street,
    required this.suite,
    required this.city,
    required this.zipcode,
    required this.geo,
  });
}

class Company {
  final String name;
  final String catchPhrase;
  final String bs;

  const Company ({
    required this.name,
    required this.catchPhrase,
    required this.bs,
  });
}

class User {
  final int id;
  final String name;
  final String username;
  final String email;
  final Address address;
  final String phone;
  final String website;
  final Company company;

  const User ({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.address,
    required this.phone,
    required this.website,
    required this.company,
  });

  Widget userWidget(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Theme.of(context).primaryColor.withOpacity(0.25),
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              Expanded(flex: 6, child: Text(name, style: Theme.of(context).textTheme.headline6, textAlign: TextAlign.left)),
              Expanded(flex: 1, child: Text("ID:", style: Theme.of(context).textTheme.headline5, textAlign: TextAlign.right)),
              Expanded(flex: 1, child: Text('$id', style: Theme.of(context).textTheme.headline5, textAlign: TextAlign.right)),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Column( //Left Column
                  children: [
                    SizedBox(
                      height: 15,
                      child: Container(alignment: Alignment.topRight, child: Text("Логин:", style: Theme.of(context).textTheme.bodyText2, ))
                    ),
                    SizedBox(
                        height: 15,
                        child: Container(alignment: Alignment.topRight, child: Text("Email:", style: Theme.of(context).textTheme.bodyText2, ))
                    ),
                    SizedBox(
                        height: 15,
                        child: Container(alignment: Alignment.topRight, child: Text("Телефон:", style: Theme.of(context).textTheme.bodyText2, ))
                    ),
                    SizedBox(
                        height: 25,
                        child: Container(alignment: Alignment.topRight, child: Text("www:", style: Theme.of(context).textTheme.bodyText2, ))
                    ),
                    SizedBox(
                        height: 55,
                        child: Container(alignment: Alignment.topRight, child: Text("Компания:", style: Theme.of(context).textTheme.bodyText2, ))
                    ),
                    SizedBox(
                        height: 40,
                        child: Container(alignment: Alignment.topRight, child: Text("Адрес:", style: Theme.of(context).textTheme.bodyText2, ))
                    ),
                    SizedBox(
                        height: 15,
                        child: Container(alignment: Alignment.topRight, child: Text("Геометка:", style: Theme.of(context).textTheme.bodyText2, ))
                    ),

                  ],
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                flex: 6,
                child: Column( //Right Column
                  children: [
                    SizedBox(
                        height: 15,
                        child: Container(alignment: Alignment.topLeft, child: Text(username, style: Theme.of(context).textTheme.bodyText2,))
                    ),
                    SizedBox(
                        height: 15,
                        child: Container(alignment: Alignment.topLeft, child: Text(email, style: Theme.of(context).textTheme.bodyText2,  ))
                    ),
                    SizedBox(
                        height: 15,
                        child: Container(alignment: Alignment.topLeft, child: Text(phone, style: Theme.of(context).textTheme.bodyText2,  ))
                    ),
                    SizedBox(
                        height: 25,
                        child: Container(alignment: Alignment.topLeft, child: Text(website, style: Theme.of(context).textTheme.bodyText2, ))
                    ),
                    SizedBox(
                        height: 55,
                        child: Container(alignment: Alignment.topLeft, child: Text('${company.name}\n"${company.catchPhrase}"\n${company.bs}', style: Theme.of(context).textTheme.bodyText2, ))
                    ),
                    SizedBox(
                        height: 40,
                        child: Container(
                            alignment: Alignment.topLeft,
                            child: Text('${address.street}, ${address.suite}\n${address.zipcode} ${address.city}\n',
                              style: Theme.of(context).textTheme.bodyText2, )
                        )
                    ),
                    SizedBox(
                        height: 15,
                        child: Container(alignment: Alignment.topLeft, child: Text('${address.geo.lat}, ${address.geo.lng}', style: Theme.of(context).textTheme.bodyText2,  ))
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      username: json['username'],
      email: json['email'],
      address: Address(
        street: json['address']['street'],
        suite: json['address']['suite'],
        city: json['address']['city'],
        zipcode: json['address']['zipcode'],
        geo: Geo(
          lat: json['address']['geo']['lat'],
          lng: json['address']['geo']['lng'],
        ),
      ),
      phone: json['phone'],
      website: json['website'],
      company: Company(
          name: json['company']['name'],
          catchPhrase: json['company']['catchPhrase'],
          bs: json['company']['bs'],
        ),
    );
  }
}

class UserList {
  List<User> items = [];
}

Future<UserList> fetchUserList() async{
  final response =await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));

  if (response.statusCode == 200) {
    UserList userList = UserList();
    List<dynamic> json = jsonDecode(response.body);
    for (int i=0; i<json.length;i++){
      userList.items.add(User.fromJson(json[i]));
    }
    return userList;
  } else {
    throw Exception('опасный realloc');
  }
}

Future<User> fetchSingleUser(int index) async{
  final response =await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users/$index'));

  if (response.statusCode == 200) {
    return User.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('опасный realloc');
  }
}

class Task {
  final int id;
  final int userId;
  final String title;
  final bool completed;

  const Task ({
    required this.id,
    required this.userId,
    required this.title,
    required this.completed,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      userId: json['userId'],
      title: json['title'],
      completed: json['completed'],
    );
  }
}

class TaskList {
  List<Task> items = [];
}

Future<TaskList> fetchTaskList(int index) async{
  final response =await http.get(Uri.parse('https://jsonplaceholder.typicode.com/todos?userId=$index'));

  if (response.statusCode == 200) {
    TaskList taskList = TaskList();
    List<dynamic> json = jsonDecode(response.body);
    for (int i=0; i<json.length;i++){
      taskList.items.add(Task.fromJson(json[i]));
    }
    return taskList;
  } else {
    throw Exception('опасный realloc');
  }
}
class PersonModel {
  final Name name;
  final Location location;
  final String email;
  final DateOfBirth dob;
  final Registered registered;
  final Picture picture;

  PersonModel(
    this.name,
    this.location,
    this.email,
    this.dob,
    this.registered,
    this.picture,
  );

  factory PersonModel.fromJson(Map<String, dynamic> json) {
    final name = Name.fromJson(json['name']);
    final location = Location.fromJson(json['location']);
    final email = json['email'] as String;
    final dob = DateOfBirth.fromJson(json['dob']);
    final registered = Registered.fromJson(json['registered']);
    final picture = Picture.fromJson(json['picture']);

    return PersonModel(name, location, email, dob, registered, picture);
  }
}

class Name {
  final String title;
  final String first;
  final String last;

  Name(this.title, this.first, this.last);

  factory Name.fromJson(Map<String, dynamic> json) {
    final title = json['title'] as String;
    final first = json['first'] as String;
    final last = json['last'] as String;

    return Name(title, first, last);
  }
}

class Location {
  final String city;
  final String state;
  final String country;

  Location(this.city, this.state, this.country);

  factory Location.fromJson(Map<String, dynamic> json) {
    final city = json['city'] as String;
    final state = json['state'] as String;
    final country = json['country'] as String;

    return Location(city, state, country);
  }
}

class DateOfBirth {
  final String date;

  DateOfBirth(this.date);

  factory DateOfBirth.fromJson(Map<String, dynamic> json) {
    final date = json['date'] as String;

    return DateOfBirth(date);
  }
}

class Registered {
  final String date;

  Registered(this.date);

  factory Registered.fromJson(Map<String, dynamic> json) {
    final date = json['date'] as String;

    return Registered(date);
  }
}

class Picture {
  final String large;

  Picture(this.large);

  factory Picture.fromJson(Map<String, dynamic> json) {
    final large = json['large'] as String;

    return Picture(large);
  }
}

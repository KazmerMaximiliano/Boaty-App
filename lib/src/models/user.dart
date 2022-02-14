class BoatyUser {
  int? id;
  List<dynamic>? roles;
  dynamic preferences;
  dynamic pmType;
  dynamic pmLastFour;
  dynamic trialEndsAt;
  dynamic emailVerifiedAt;
  String? email;
  String? firstName;
  String? lastName;
  String? phone;
  String? address;
  String? birthday;
  String? photo;
  String? createdAt;
  String? updatedAt;
  String? stripeId;

  BoatyUser({
    this.id,
    this.roles,
    this.preferences,
    this.pmType,
    this.pmLastFour,
    this.trialEndsAt,
    this.emailVerifiedAt,
    this.email,
    this.firstName,
    this.lastName,
    this.phone,
    this.address,
    this.birthday,
    this.photo,
    this.createdAt,
    this.updatedAt,
    this.stripeId
  });

  BoatyUser.fromJson(json) {
    this.id = json['id'];
    this.roles = json['roles'];
    this.preferences = json['preferences'];
    this.pmType = json['pm_type'];
    this.pmLastFour = json['pm_last_four'];
    this.trialEndsAt = json['trial_ends_at'];
    this.emailVerifiedAt = json['email_verified_at'];
    this.email = json['email'];
    this.firstName = json['first_name'];
    this.lastName = json['last_name'];
    this.phone = json['phone'];
    this.address = json['address'];
    this.birthday = json['birthday'];
    this.photo = json['photo'];
    this.createdAt = json['created_at'];
    this.updatedAt = json['updated_at'];
    this.stripeId = json['stripe_id'];
  }
}

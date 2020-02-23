class API{
  static const String COMMON_API="https://relateapp.io/api/v1/";
  static const String LOGIN_API=COMMON_API+"auth/login";
  static const String REGISTER_API=COMMON_API+"/auth/register";

  static const String ADD_NEW_PERSON_API=COMMON_API+"/person";
  static const String UPDATE_PERSON_API=COMMON_API+"/person";
  static const String DELETE_PERSON_API=COMMON_API+"/person";

  static const String CONTACT_LIST_API=COMMON_API+"/person/list";
  static const String LAST_CONTACT_API=COMMON_API+"/person/urgent-contacts";
  static const String UPCOMING_BIRTHDAY_API=COMMON_API+"/person/upcoming-birthdays";

  static const String GET_SINGLE_PERSON_API=COMMON_API+"/person";
  static const String GET_LIST_NOTE_API=COMMON_API+"note/list";
  static const String GET_PHONE_API=COMMON_API+"phone-number/list";
  static const String GET_EMAIL_API=COMMON_API+"email/list";

  static const String ADD_EMAIL_API=COMMON_API+"email";
  static const String UPDATE_EMAIL_API=COMMON_API+"email";
  static const String DELETE_EMAIL_API=COMMON_API+"email";

  static const String ADD_PHONE_API=COMMON_API+"phone-number";
  static const String UPDATE_PHONE_API=COMMON_API+"phone-number";
  static const String DELETE_PHONE_API=COMMON_API+"phone-number";

  static const String ADD_NOTE_API=COMMON_API+"note";
  static const String UPDATE_NOTE_API=COMMON_API+"note";
  static const String DELETE_NOTE_API=COMMON_API+"note";

}
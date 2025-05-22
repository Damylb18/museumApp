class AppSettings {
  /// The base URL for the api connection. Change this to the server the admin panel is deployed on.
  /// Format: "https://\<SERVER\>/cmm/api"
  static const String apiBaseUrl = 'https://2326780.win.studentwebserver.co.uk/cmm/api';
}

/// Links to locations on the CMM website, to be opened from within the app.
class WebsiteLinks {
  /// The URL of the CMM website's 'Contact Us' page
  static const String contactUs = 'https://cheshiremilitarymuseum.org.uk/contact/';
  /// The URL of the CMM website's 'Privacy Policy' page
  static const String privacyPolicy = 'https://cheshiremilitarymuseum.org.uk/privacy-policy/';
}

/// Toggleable options to disable either the entire sidebar or sidebar modules.
class SideBarsSettings {
  /// Set this to enable or disable the sidebar
  static const bool sideBarOn = true;

  /// Set to enable or disable the 'Contact Us' link
  static const bool contactUsOn = true;
  /// Set this to enable or disable the 'Privacy Policy' link
  static const bool privacyPolicyOn = true;

  /// Set this to enable or disable the Facebook link
  static const bool facebookOn = true;
  /// Set this to enable or disable the Instagram link
  static const bool instagramOn = true;
  /// Set this to enable or disable the TripAdvisor link
  static const bool tripadvisorOn = true;
}

/// Links to the CMM social medias.
class SocialMediaLinks {
  /// The URL of the CMM facebook page
  static const String facebook = 'https://www.facebook.com/cheshiremilitarymuseum';
  /// The URL of the CMM instagram page
  static const String instagram = 'https://www.instagram.com/cheshiremilitarymuseum';
  /// The URL of the CMM TripAdvisor page
  static const String tripadvisor = 'https://www.tripadvisor.co.uk/Attraction_Review-g186233-d3589569-Reviews-Cheshire_Military_Museum-Chester_Cheshire_England.html';
}
// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  /// Agree
  internal static let agree = L10n.tr("Localizable", "Agree", fallback: "Agree")
  /// Error
  internal static let error = L10n.tr("Localizable", "Error", fallback: "Error")
  /// 
  ///     Privacy Policy
  /// 
  ///     Information We Gather and Use
  ///     When you engage with our app, the following data practices apply: • Our service does not store or track user data. We provide traffic encryption features without retaining any personal information. No user activity logs are maintained. • We do not collect details you may provide directly, such as names, email addresses, or contact numbers. Emails are used solely to respond to inquiries submitted via our official channels and cannot identify users individually. • Aggregate data, such as total traffic usage by all users in a specific country, is recorded to improve service quality. This information is generalized and does not link to individual users. • No device-specific data, such as IP addresses, device models, operating systems, or timestamps, is captured. Browsing histories, traffic contents, and DNS queries are also not tracked. • Third-party services integrated into our app may collect data for their purposes. Their respective privacy policies are available at: • The app employs third-party services that may collect data used to identify you. Privacy policies for these third-party services can be found here: Google Analytics for Firebase (https://firebase.google.com/policies/analytics), Appsflyer (https://www.appsflyer.com/legal/privacy-policy/).
  /// 
  ///     Links to External Sites
  ///     Our service may contain links to third-party sites. By clicking such links, you will leave our platform. Please review the privacy policies of these external websites, as we are not responsible for their content, data practices, or policies.
  /// 
  ///     Children’s Privacy
  ///     Our service is not intended for individuals under the age of 13. We do not knowingly collect personal data from children. If we discover such data has been provided, it will be deleted promptly. Parents or guardians who are aware of their child sharing personal information should contact us to address the issue immediately.
  /// 
  ///     Changes to This Privacy Policy
  ///     We may update this Privacy Policy periodically. Users are encouraged to review this page regularly to stay informed about changes. Notifications of updates will be posted here.
  /// 
  ///     Contact Us:
  ///     If you have any questions regarding our privacy practices or anything about our services, please contact us via email at samtandyrspzoo@proton.me
  /// 
  internal static let privacyPolicy = L10n.tr("Localizable", "PrivacyPolicy", fallback: "\n    Privacy Policy\n\n    Information We Gather and Use\n    When you engage with our app, the following data practices apply: • Our service does not store or track user data. We provide traffic encryption features without retaining any personal information. No user activity logs are maintained. • We do not collect details you may provide directly, such as names, email addresses, or contact numbers. Emails are used solely to respond to inquiries submitted via our official channels and cannot identify users individually. • Aggregate data, such as total traffic usage by all users in a specific country, is recorded to improve service quality. This information is generalized and does not link to individual users. • No device-specific data, such as IP addresses, device models, operating systems, or timestamps, is captured. Browsing histories, traffic contents, and DNS queries are also not tracked. • Third-party services integrated into our app may collect data for their purposes. Their respective privacy policies are available at: • The app employs third-party services that may collect data used to identify you. Privacy policies for these third-party services can be found here: Google Analytics for Firebase (https://firebase.google.com/policies/analytics), Appsflyer (https://www.appsflyer.com/legal/privacy-policy/).\n\n    Links to External Sites\n    Our service may contain links to third-party sites. By clicking such links, you will leave our platform. Please review the privacy policies of these external websites, as we are not responsible for their content, data practices, or policies.\n\n    Children’s Privacy\n    Our service is not intended for individuals under the age of 13. We do not knowingly collect personal data from children. If we discover such data has been provided, it will be deleted promptly. Parents or guardians who are aware of their child sharing personal information should contact us to address the issue immediately.\n\n    Changes to This Privacy Policy\n    We may update this Privacy Policy periodically. Users are encouraged to review this page regularly to stay informed about changes. Notifications of updates will be posted here.\n\n    Contact Us:\n    If you have any questions regarding our privacy practices or anything about our services, please contact us via email at samtandyrspzoo@proton.me\n")
  /// Settings
  internal static let settings = L10n.tr("Localizable", "Settings", fallback: "Settings")
  internal enum CheckNetwork {
    /// Download
    internal static let download = L10n.tr("Localizable", "CheckNetwork.Download", fallback: "Download")
    /// Upload
    internal static let upload = L10n.tr("Localizable", "CheckNetwork.Upload", fallback: "Upload")
  }
  internal enum Data {
    /// Check IP Data
    internal static let checkIPData = L10n.tr("Localizable", "Data.CheckIPData", fallback: "Check IP Data")
    /// Country Code
    internal static let countryCode = L10n.tr("Localizable", "Data.CountryCode", fallback: "Country Code")
    /// IP Address
    internal static let ipAddress = L10n.tr("Localizable", "Data.IPAddress", fallback: "IP Address")
    /// IP Data
    internal static let ipData = L10n.tr("Localizable", "Data.IPData", fallback: "IP Data")
    /// Location
    internal static let location = L10n.tr("Localizable", "Data.Location", fallback: "Location")
    /// Postal Code
    internal static let postalCode = L10n.tr("Localizable", "Data.PostalCode", fallback: "Postal Code")
  }
  internal enum Onboard {
    /// Next
    internal static let next = L10n.tr("Localizable", "Onboard.Next", fallback: "Next")
    internal enum Ip {
      /// View IP details and ensure the connection is secure in one easy action
      internal static let description = L10n.tr("Localizable", "Onboard.IP.Description", fallback: "View IP details and ensure the connection is secure in one easy action")
      /// Check Your IP Data
      internal static let title = L10n.tr("Localizable", "Onboard.IP.Title", fallback: "Check Your IP Data")
    }
    internal enum Location {
      /// Select a country to connect to the VPN and start enjoying secure streaming
      internal static let description = L10n.tr("Localizable", "Onboard.Location.Description", fallback: "Select a country to connect to the VPN and start enjoying secure streaming")
      /// Choose Your Location
      internal static let title = L10n.tr("Localizable", "Onboard.Location.Title", fallback: "Choose Your Location")
    }
    internal enum Protect {
      /// Tap to activate VPN and instantly protect your data with just one simple step
      internal static let description = L10n.tr("Localizable", "Onboard.Protect.Description", fallback: "Tap to activate VPN and instantly protect your data with just one simple step")
      /// Protect Your Connection
      internal static let title = L10n.tr("Localizable", "Onboard.Protect.Title", fallback: "Protect Your Connection")
    }
  }
  internal enum Settings {
    /// Help & Support
    internal static let helpSupport = L10n.tr("Localizable", "Settings.HelpSupport", fallback: "Help & Support")
    /// Manage Subscription
    internal static let manageSubscription = L10n.tr("Localizable", "Settings.ManageSubscription", fallback: "Manage Subscription")
    /// Privacy Policy
    internal static let privacyPolicy = L10n.tr("Localizable", "Settings.PrivacyPolicy", fallback: "Privacy Policy")
    /// Restore Purchases
    internal static let restorePurchases = L10n.tr("Localizable", "Settings.RestorePurchases", fallback: "Restore Purchases")
    /// Restore successfull
    internal static let restoreSuccessfull = L10n.tr("Localizable", "Settings.RestoreSuccessfull", fallback: "Restore successfull")
    /// Terms of Service
    internal static let termsOfService = L10n.tr("Localizable", "Settings.TermsOfService", fallback: "Terms of Service")
  }
  internal enum Splash {
    /// FAST, UNLIMITED & SAFE
    internal static let description = L10n.tr("Localizable", "Splash.Description", fallback: "FAST, UNLIMITED & SAFE")
  }
  internal enum Vpn {
    /// Close
    internal static let close = L10n.tr("Localizable", "VPN.Close", fallback: "Close")
    /// Connected
    internal static let connected = L10n.tr("Localizable", "VPN.Connected", fallback: "Connected")
    /// Connecting...
    internal static let connecting = L10n.tr("Localizable", "VPN.Connecting", fallback: "Connecting...")
    /// Fail
    internal static let fail = L10n.tr("Localizable", "VPN.Fail", fallback: "Fail")
    /// Locations
    internal static let locations = L10n.tr("Localizable", "VPN.Locations", fallback: "Locations")
    ///  MB/S
    internal static let mbs = L10n.tr("Localizable", "VPN.MBS", fallback: " MB/S")
    /// Not connected
    internal static let notConnected = L10n.tr("Localizable", "VPN.NotConnected", fallback: "Not connected")
    /// Start
    internal static let start = L10n.tr("Localizable", "VPN.Start", fallback: "Start")
    /// Status
    internal static let status = L10n.tr("Localizable", "VPN.Status", fallback: "Status")
    /// Stop
    internal static let stop = L10n.tr("Localizable", "VPN.Stop", fallback: "Stop")
    /// Time
    internal static let time = L10n.tr("Localizable", "VPN.Time", fallback: "Time")
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type

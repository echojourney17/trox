import Foundation

typealias Completion = (() -> Void)

struct Constants {
    
    struct BaseURL {
        static let developURL: String = "https://samtandyrspzoo.com/api/trox"
        static let productionURL: String = "https://samtandyrspzoo.com/api/trox"
    }
    
    enum HttpHeaderField: String {
        case authentication = "Authorization"
        case contentType = "Content-Type"
        case acceptType = "Accept"
        case acceptEncoding = "Accept-Encoding"
        case acceptLanguage = "accept-language"
    }
    
    enum ContentType: String {
        case json = "application/json"
    }
    
    struct Subscription {
//        static let productIds = [
//            "ovulenmintertest1",
//            "ovulenmintertest2",
//            "ovulenmintertest3"
//        ]
        static let productIds = [
            "com.sam.trox.week",
            "com.sam.trox.month",
            "com.sam.trox.year"
        ]
//        static let defaultId = "ovulenmintertest2"
        static let defaultId = "com.sam.trox.week"
        static let sharedKey = ""
    }
    
    static let apiKey: String = "e5250f91-0e34-4ce1-8c2e-ab3e7e0a7d04"
    static let skarbID: String = "trox"
    
    struct Branch {
        static let key = "key_live_nrc4ub2oIctuadg81rilQaolqBkzza9w"
        static let testKey = "key_test_jwc8DfZmVexrdobY5rabRhhetxayrhZa"
    }
    
    struct Support {
        static let email: String = "info@samtandyrspzoo.com"
        static let policy: String = "https://samtandyrspzoo.com/Privacy.html"
        static let terms: String = "https://samtandyrspzoo.com/terms.html"
        static let privacyContent = """
            Privacy Policy

            Information We Gather and Use
            When you engage with our app, the following data practices apply: • Our service does not store or track user data. We provide traffic encryption features without retaining any personal information. No user activity logs are maintained. • We do not collect details you may provide directly, such as names, email addresses, or contact numbers. Emails are used solely to respond to inquiries submitted via our official channels and cannot identify users individually. • Aggregate data, such as total traffic usage by all users in a specific country, is recorded to improve service quality. This information is generalized and does not link to individual users. • No device-specific data, such as IP addresses, device models, operating systems, or timestamps, is captured. Browsing histories, traffic contents, and DNS queries are also not tracked. • Third-party services integrated into our app may collect data for their purposes. Their respective privacy policies are available at: • The app employs third-party services that may collect data used to identify you. Privacy policies for these third-party services can be found here: Google Analytics for Firebase (https://firebase.google.com/policies/analytics), Appsflyer (https://www.appsflyer.com/legal/privacy-policy/).

            Links to External Sites
            Our service may contain links to third-party sites. By clicking such links, you will leave our platform. Please review the privacy policies of these external websites, as we are not responsible for their content, data practices, or policies.

            Children’s Privacy
            Our service is not intended for individuals under the age of 13. We do not knowingly collect personal data from children. If we discover such data has been provided, it will be deleted promptly. Parents or guardians who are aware of their child sharing personal information should contact us to address the issue immediately.

            Changes to This Privacy Policy
            We may update this Privacy Policy periodically. Users are encouraged to review this page regularly to stay informed about changes. Notifications of updates will be posted here.

            Contact Us:
            If you have any questions regarding our privacy practices or anything about our services, please contact us via email at samtandyrspzoo@proton.me
            """
    }
    
}

struct Localize {
    struct AlertSale {
        static let title = NSLocalizedString("Special Offer!🎁", comment: "")
        static let subtitle = NSLocalizedString("To get full access to the vpn you need to subscribe", comment: "")
        static let cancel = NSLocalizedString("Cancel", comment: "")
        static let get = NSLocalizedString("Get", comment: "")
    }
    
    struct Error {
        struct TryAgain {
            static let title =  NSLocalizedString("The device is not protected", comment: "")
            static let subtitle =  NSLocalizedString("Enable protection", comment: "")
            static let okButton =  NSLocalizedString("Try Again", comment: "")
        }
    }
    
    static let userComment = NSLocalizedString("This VPN is for people like me for simple safe connection to unknown and public wifi no other weird and confusing buttons. The connection is very fast and i have no problem using it. 👍 👍 👍", comment: "")
}

struct ProtectionError: LocalizedError {
    let title: String
    let subtitle: String
    let buttonTitle: String

    var errorDescription: String? {
        return subtitle
    }

    var failureReason: String? {
        return title
    }

    var recoverySuggestion: String? {
        return buttonTitle
    }
}

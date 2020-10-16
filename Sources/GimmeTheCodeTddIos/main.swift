import Foundation
import Publish
import Plot
import SplashPublishPlugin

// This type acts as the configuration for your website.
struct GimmeTheCodeTddIos: Website {
  enum SectionID: String, WebsiteSectionID {
    // Add the sections that you want your website to contain here:
    case introduction
    case general
    //case networking
  }
  
  struct ItemMetadata: WebsiteItemMetadata {
    // Add any site-specific metadata that you want to use here.
  }
  
  // Update these properties to configure your website:
  var url = URL(string: "https://your-website-url.com")!
  var name = "GimmeTheCode: TDD iOS"
  var description = "A description of GimmeTheCodeTddIos"
  var language: Language { .english }
  var imagePath: Path? { nil }
}

// This will generate your website using the built-in Foundation theme:
try GimmeTheCodeTddIos().publish(withTheme: .simple,
                                 plugins: [.splash(withClassPrefix: "")]
)


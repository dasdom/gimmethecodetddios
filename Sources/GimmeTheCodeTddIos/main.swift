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
    case depenency_injection
    case mocks
    case expectations
    case easy_tests
    case uiviewcontroller
    case uiview
    case uitableview
    case uicollectionview
    case uinavigationcontroller
    case presentation
    case coordinator
    case networking
    case imprint
    case privacy
  }
  
  struct ItemMetadata: WebsiteItemMetadata {
    // Add any site-specific metadata that you want to use here.
  }
  
  // Update these properties to configure your website:
  var url = URL(string: "https://gimmetheco.de")!
  var name = "Gimme The Code: TDD iOS"
  var description = "How to test iOS apps."
  var language: Language { .english }
  var imagePath: Path? { nil }
}

// This will generate your website using the built-in Foundation theme:
try GimmeTheCodeTddIos().publish(withTheme: .simple,
                                 deployedUsing: .gitHub("dasdom/gimmethecodetddios", useSSH: true),
                                 additionalSteps: [
                                  .addMarkdownFiles(at: "Content/pages"),
                                 ],
                                 plugins: [.splash(withClassPrefix: "")]
)


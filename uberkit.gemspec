Gem::Specification.new do |s|
  s.name = "uberkit"
  s.version = "0.0.1"
  s.date = "2008-07-07"
  s.summary = "A Rails plugin for a common set of UI tools and helpers for building interfaces."
  s.email = "michael@intridea.com"
  s.homepage = "http://www.actsascommunity.com/projects/uberkit"
  s.description = "UberKit is a set of tools for common UI problems in Rails including menus."
  s.has_rdoc = false
  s.authors = ["Michael Bleigh"]
  s.files = [ "MIT-LICENSE",
              "README",
              "lib",
              "lib/uberkit",
              "lib/uberkit/displayer.rb",
              "lib/uberkit/menu.rb",
              "lib/uberkit.rb",
              "rails",
              "rails/init.rb" ]
  #s.rdoc_options = ["--main", "README.txt"]
  #s.extra_rdoc_files = ["History.txt", "Manifest.txt", "README.txt"]
  #s.add_dependency("mbleigh-mash", [">= 0.0.5"])
end
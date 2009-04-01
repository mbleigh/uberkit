# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{uberkit}
  s.version = "0.0.5"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Michael Bleigh"]
  s.date = %q{2009-04-01}
  s.description = %q{UberKit is a set of tools for common UI problems in Rails including menus and forms.}
  s.email = %q{michael@intridea.com}
  s.extra_rdoc_files = ["README"]
  s.files = ["MIT-LICENSE", "Rakefile", "README", "VERSION.yml", "lib/uberkit", "lib/uberkit/displayer.rb", "lib/uberkit/form.rb", "lib/uberkit/forms", "lib/uberkit/forms/builder.rb", "lib/uberkit/forms/helper.rb", "lib/uberkit/menu.rb", "lib/uberkit.rb", "rails/init.rb"]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/mbleigh/uberkit}
  s.rdoc_options = ["--inline-source", "--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{A Rails plugin for a common set of UI tools and helpers for building interfaces.}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end

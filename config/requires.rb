$root = File.expand_path("..", File.dirname(__FILE__))

begin
  require "rubygems"
  require "bundler"
rescue LoadError
  raise "Could not load the bundler gem. Install it with `gem install bundler`."
end

begin
  ENV["BUNDLE_GEMFILE"] = $root + "/Gemfile"
  Bundler.setup
rescue Bundler::GemNotFound
  raise RuntimeError, "Bundler couldn't find some gems. Did you run `bundle install`?"
end

require 'ruby-debug'
require 'gosu'

def require_local(pattern)
  Dir.glob(File.expand_path(pattern, $root)).each {|f| require f }
end

# local requires
require_local($root + '/lib/processor.rb')


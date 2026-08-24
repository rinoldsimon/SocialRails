ENV["BUNDLE_GEMFILE"] ||= File.expand_path("../Gemfile", __dir__)

if (url = ENV["DATABASE_URL"]) && url.include?("channel_binding=")
  ENV["DATABASE_URL"] = url.gsub(/[?&]channel_binding=[^&]+/, "").sub(/\?$/, "")
end

require "bundler/setup" # Set up gems listed in the Gemfile.
require "bootsnap/setup" # Speed up boot time by caching expensive operations.

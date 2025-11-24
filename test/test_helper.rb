ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

module ActiveSupport
  class TestCase
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    # Add more helper methods to be used by all tests here...

    # Helper method to get or create the default prayer book for tests
    def default_prayer_book
      @default_prayer_book ||= PrayerBook.find_or_create_by!(code: "loc_2015") do |pb|
        pb.name = "Livro de Oração Comum 2015"
        pb.year = 2015
        pb.jurisdiction = "IEAB"
        pb.description = "Livro de Oração Comum para testes"
        pb.is_default = true
      end
    end
  end
end

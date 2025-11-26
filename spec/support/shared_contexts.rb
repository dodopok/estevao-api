# Shared contexts for common test scenarios
RSpec.shared_context "with default prayer book" do
  let(:default_prayer_book) do
    create(:prayer_book, :loc_2015, :default)
  end

  before do
    default_prayer_book
  end
end

RSpec.shared_context "with liturgical seasons" do
  let!(:advent) { create(:liturgical_season, :advent) }
  let!(:christmas) { create(:liturgical_season, :christmas) }
  let!(:epiphany) { create(:liturgical_season, :epiphany) }
  let!(:lent) { create(:liturgical_season, :lent) }
  let!(:easter) { create(:liturgical_season, :easter) }
  let!(:ordinary_time) { create(:liturgical_season, :ordinary_time) }
end

RSpec.shared_context "with authenticated user" do
  let(:user) { create(:user) }
  let(:auth_headers) do
    {
      "Authorization" => "Bearer valid_firebase_token",
      "Content-Type" => "application/json"
    }
  end

  before do
    # Mock Firebase authentication
    allow_any_instance_of(ApplicationController).to receive(:authenticate_user!).and_return(true)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
  end
end

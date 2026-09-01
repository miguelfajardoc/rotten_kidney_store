require "rails_helper"

RSpec.describe "Home", type: :request do
  it "renders the landing page without authentication" do
    get root_path

    expect(response).to have_http_status(:ok)
  end
end

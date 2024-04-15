# frozen_string_literal: true

RSpec.shared_examples("login examples") do
  let(:account) { create(:account) }
  before { sign_in account }

  it "logs in successfully" do
    expect(controller.current_account).to(eq(account))
  end
end

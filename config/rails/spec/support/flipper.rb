# frozen_string_literal: true

RSpec.configure do |config|
  config.before do
    # Reset feature-flipping between examples
    # (In test examples, stub Flipper as needed, passing specific args to #with)
    allow(Flipper).to receive(:enabled?).with(any_args).and_call_original
  end
end

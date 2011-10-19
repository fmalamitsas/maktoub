require 'test_helper'

module Maktoub
  class NewsletterMailerTest < ActionMailer::TestCase
    setup do
      @mailer = NewsletterMailer.publish('test_template', email: 'zaid@example.com', name: 'zaid')

    end
    test "should have the right subject recipient and sender" do
      assert_equal "Test template", @mailer.subject
      assert_equal ['maktoub@example.com'], @mailer.from # defined in dummy/config/initializers/maktoub.rb
      assert_equal ['zaid@example.com'], @mailer.to
    end

    test "should be multipart" do
      assert_equal true, @mailer.multipart?
      assert_equal false, @mailer.html_part.blank?
      assert_equal false, @mailer.text_part.blank?
    end

    test "html_part" do
      body = @mailer.html_part.body.to_s

      assert_match /View it in your browser/, body # change to link assertion
      assert_match /Copyright/, body
      assert_match /All rights reserved/, body
      assert_match /update subscription preferences/, body # change to link assertion
    end
  end
end


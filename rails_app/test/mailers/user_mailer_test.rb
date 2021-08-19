require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  test '正常系_アカウント有効化' do
    # 有効化トークンを持つユーザーを定義
    user = users(:michael)
    user.activation_token = User.new_token

    # メールを作成
    mail = UserMailer.account_activation(user)

    # タイトル、送信先などをチェック
    assert_equal 'Account activation', mail.subject
    assert_equal [user.email], mail.to
    assert_equal ['noreply@example.com'], mail.from
    assert_match user.name, mail.body.encoded
    assert_match user.activation_token, mail.body.encoded
    assert_match CGI.escape(user.email), mail.body.encoded
  end

  test 'password_reset' do
    mail = UserMailer.password_reset
    assert_equal 'Password reset', mail.subject
    assert_equal ['to@example.org'], mail.to
    assert_equal ['noreply@example.com'], mail.from
    assert_match 'Hi', mail.body.encoded
  end
end
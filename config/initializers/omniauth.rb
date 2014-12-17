Rails.application.config.middleware.use OmniAuth::Builder do
  provider :salesforce, ENV['SALESFORCE_KEY'], ENV['SALESFORCE_SECRET']
  provider :facebook, ENV['FACEBOOK_KEY'], ENV['FACEBOOK_SECRET'] ,:callback_path => '/auth/facebook/create'
#  provider :twitter, 'sbsOAvEZyKOZq6OzmQ9I5ZRsM' ,'xDomvBiTGQdlIQpd6XIt0tcyvfEEO834cAKWPV4bKOAraMTI15'


end
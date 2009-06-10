# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_glucodes_session',
  :secret      => 'f790d728b9e13ccd5feb3fe2d445cce95141299cd8740b4a31444ace8a6bb968292bad5288687f3832415af26a31dc6025dc7e085b3330abb4dbccc230456493'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store

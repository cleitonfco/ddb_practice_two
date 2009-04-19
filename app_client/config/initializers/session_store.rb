# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_app_session',
  :secret      => 'e6e295d5c53575d4631fb70f8a372e470d7cc8e084c8320e83641762da19c15d748e7efe05e833cef7808fd54c332e82457107b5b51ba26935963cf22f0ffb8d'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store

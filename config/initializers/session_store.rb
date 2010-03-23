# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_ingresso_na_pos_session',
  :secret      => '01fb2f7af24a37405b9e5d5c5407064c23ef4cf7deeb4843de9905b56e17009272b25033fafb2a4e58cbdfef45228e409014899dc9b2cc3fe67cecd545598c41'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store

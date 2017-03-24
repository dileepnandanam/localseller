Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '611998348985898', '6f3cc5229f6f7defb211032471e2ef17'
  provider :twitter, '2ubXMymbj2EyqJeZBMC4HvHt0', 'CEPvGTPxbtNKuUqPwANZyhcXQGXCy2i545RBWqTmHnb4JOWaCY'
  provider :google_oauth2, '934124494837-23deq20gu1ke9pn4ojej1bfpe34fgoeu.apps.googleusercontent.com', 'q9roVIIjmnmD9ldTp2m2gOve'
end
# frozen_string_literal: true

# API entity for oath application which also included secret field.
# Needs on creating new application so that the user can save secret key.
class OauthApplications::CreateResponse < BaseEntity
  expose :secret, documentation: { type: 'string', desc: 'The secret of the oauth application' }
end
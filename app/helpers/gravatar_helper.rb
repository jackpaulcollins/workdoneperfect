# frozen_string_literal: true

module GravatarHelper
  # Gravatar URL generator to get avatar by email
  # See for details: https://en.gravatar.com/site/implement/images/

  module_function

  def gravatar_url_for(email, **options)
    hash = Digest::MD5.hexdigest(email&.downcase || '')
    size = options[:size] || 48
    options.reverse_merge!(default: :mp, rating: :pg, size:)
    "https://secure.gravatar.com/avatar/#{hash}.png?#{options.to_param}"
  end
end

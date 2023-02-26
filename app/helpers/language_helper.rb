# frozen_string_literal: true

module LanguageHelper
  LANGUAGES = {
    "es-co": "Spanish (Columbia)",
    en: "English",
    fr: "French",
    nl: "Dutch"
  }.freeze

  def language_options
    LANGUAGES.slice(*I18n.available_locales).invert.to_a
  end
end

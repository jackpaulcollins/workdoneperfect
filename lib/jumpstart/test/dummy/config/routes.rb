# frozen_string_literal: true

Rails.application.routes.draw do
  mount Jumpstart::Engine => "/jumpstart"
end

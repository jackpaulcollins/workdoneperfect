# frozen_string_literal: true

# Example:
# <%= render TableComponent.new do |t| %>
#   <% t.with_header { "Name "} %>
#   <% t.with_header { "Email"} %>
#   <% t.with_header { "" } %>
#   <% t.with_row do |r| %>
#     <% r.with_col { "Jace Bayless" }%>
#     <% r.with_col { "jacebayless@gmail.com" }%>
#     <% r.with_col { "Edit" }%>
#   <% end %>
#   <% t.with_row do |r| %>
#     <% r.with_col { "Jack Collins" }%>
#     <% r.with_col { "jackpaulcollins@gmail.com" }%>
#     <% r.with_col { "Edit" }%>
#   <% end %>
# <% end %>
#
# Creates:
# .--------------.---------------------------.------.
# | Name         | Email                     |      |
# :--------------+---------------------------+------:
# | Jace Bayless | jacebayless@gmail.com     | Edit |
# :--------------+---------------------------+------:
# | Jack Collins | jackpaulcollins@gmail.com | Edit |
# '--------------'---------------------------'------'

class TableComponent < ViewComponent::Base
  renders_many :headers
  renders_many :rows, TableRowComponent
end

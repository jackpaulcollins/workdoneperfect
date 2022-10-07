# frozen_string_literal: true

class DashboardSidebarComponent < ViewComponent::Base
  def before_render
    @links = [
      {text: "Dashboard", icon: "house", path: user_root_path},
      {text: "Accounts", icon: "user", path: accounts_path},
      {text: "Jobs", icon: "hammer", path: accounts_path},
      {text: "Customers", icon: "dollar", path: accounts_path},
      {text: "Schedule", icon: "calendar", path: accounts_path},
      {text: "Inventory", icon: "box", path: accounts_path},
      {text: "Metrics", icon: "chart-simple", path: accounts_path},
      {text: "Employees", icon: "people-group", path: employees_path}
    ]
  end
end
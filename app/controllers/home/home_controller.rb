class Home::HomeController < ApplicationController
  def front
    if current_user
      show_info({"message" => "#{current_user.name}! Welcome to the Student Notices API"})
    else
     show_info({"message" => "Welcome to the Student Notices API", "prompt" => "Login to perform api actions."})
    end
  end
end

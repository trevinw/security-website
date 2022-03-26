module ApplicationHelper
  def active_class(params_controller, current_controller)
    if params_controller == current_controller
      'active'
    else
      ''
    end
  end
end

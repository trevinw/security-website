module WorkPermitsHelper
  STATUS_BACKGROUND_COLORS = {
    'Returned' => 'bg-green',
    'Out' => 'bg-orange',
    'Out/Disabled' => 'bg-red',
    'Missing' => 'bg-purple',
    'Expired' => 'bg-cyan'
  }.freeze

  def border_style(category)
    category == 'Regular' ? 'border-warning' : 'border-danger'
  end

  def status_message(work_permit)
    case work_permit.status
    when 'Returned' then ''
    when 'Out', 'Out/Disabled' then "Permit checked out at #{work_permit.updated_at.strftime('%H:%M %m/%d/%y')}"
    when 'Missing' then "Permit missing as of #{work_permit.updated_at.strftime('%H:%M %m/%d/%y')}"
    when 'Expired' then "Permit expired and in EOC.\nMail to <b>#{work_permit.seh_representative}</b> on #{(work_permit.updated_at + 2.days).strftime('%m/%d/%y')}".html_safe
    end
  end

  def status_background_color(status)
    STATUS_BACKGROUND_COLORS[status]
  end

  def html_title(company_id = nil, company_name = nil)
    if company_id && company_name
      "#{company_name} Work Permits"
    else
      'Work Permits'
    end
  end

  def active_css(active_company_id, current_company_id)
    return '' if active_company_id.nil? || current_company_id.nil? || active_company_id != current_company_id

    'active' if active_company_id == current_company_id
  end

  def buildings_html(buildings)
    "<b>#{'Building'.pluralize(buildings.length)}: </b>#{buildings.sort.map(&:number).join(', ')}".html_safe
  end
end

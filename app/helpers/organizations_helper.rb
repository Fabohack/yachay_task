module OrganizationsHelper

  def nested_organizations(organizations)
    organizations.map do |organization, sub_organizations|
      render(organization) + content_tag(:div, nested_organizations(sub_organizations), :class => "nested_organizations")
    end.join.html_safe
  end

end

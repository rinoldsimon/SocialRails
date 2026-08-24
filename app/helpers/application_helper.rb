module ApplicationHelper
  def page_title(title)
    content_for(:title, "#{title} · SocialRails")
  end

  def avatar_tag(user, size: :md)
    classes = {
      sm: "h-8 w-8 text-xs",
      md: "h-10 w-10 text-sm",
      lg: "h-16 w-16 text-lg"
    }.fetch(size)

    hue = (user.username.bytes.sum % 40) + 12
    content_tag(:span, user.initials, class: "inline-flex shrink-0 items-center justify-center rounded-full font-semibold text-paper #{classes}", style: "background: hsl(18 #{40 + hue % 20}% #{28 + hue % 10}%)", title: user.name)
  end

  def github_url(user)
    return if user.github_username.blank?

    "https://github.com/#{user.github_username}"
  end

  def formatted_time(time)
    return if time.blank?

    if time > 24.hours.ago
      "#{time_ago_in_words(time)} ago"
    else
      time.strftime("%b %-d")
    end
  end
end

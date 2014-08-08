module ApplicationHelper
  def root_page?
    current_page?(controller: :welcome, action: :index)
  end

  def home_page?
    current_page?(controller: :welcome, action: :home)
  end

  def search_page?
    controller_name == 'queries' &&  action_name == 'show'
  end

  def topic_page?
    controller_name == 'topics' &&  action_name == 'show'
  end

  def post_page?
    controller_name == 'posts' &&  action_name == 'show'
  end

  def page_title
    prefix = begin
      options = {
        user: @user.try(:username),
        topic: "#{t('shared.topic')} ##{@topic.try(:sequential_id)}",
        post: "#{t('shared.post')} ##{@post.try(:sequential_id)}",
        q: params[:q].try(:[], :posts_content_cont),
        raise: true
      }
      t("#{controller_name}.#{action_name}.page_title", options) + ' - '
    rescue I18n::MissingTranslationData
      ''
    end
    suffix = root_page? ? " - #{t('welcome.index.just_another')}" : ''
    "#{prefix}#{t('shared.brand')}#{suffix}"
  end

  def enum_for_select(model, attribute)
    Hash[model.send(attribute.to_s.pluralize).map { |key, value| [I18n.t("enum.#{attribute}.#{key}"), key] }]
  end

  def spinner
    fa_icon('spinner spin').to_str
  end

  def decode_bindings(encoded)
    space = '(\+|%20)'
    encoded
      .gsub(/%7B%7B#{space}/i, '{{ ').gsub(/#{space}%7D%7D/i, ' }}') # delimiters
      .gsub(/#{space}%7C#{space}/i, ' | ') # filter
      .gsub(/\+%2B\+/i, ' + ') # expression
  end

  def bindable_path(path, *args)
    decode_bindings(send("#{path}_path", *args))
  end

  def bindable_link_to(*args, &block)
    decode_bindings(link_to(*args, &block).to_s).html_safe
  end
end

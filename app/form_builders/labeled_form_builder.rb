class LabeledFormBuilder < ActionView::Helpers::FormBuilder
  delegate :content_tag, :image_tag, to: :@template

  %w(select text_field).each do |method_name|
    define_method(method_name) do |name, *args|
      field_wrap(name, *args) do
        super(name, *args)
      end
    end
  end

  def field_wrap(name, *args)
    content_tag :div, class: 'control-group' + (object.errors[name].empty? ? '' : ' error') do

      # Configurable labels
      if args.first.is_a?(Hash) and args.first.has_key?(:label)
        l = args.first[:label]
      else
        l = name.to_s.titleize
      end

      label(name, l, class: 'control-label') +

      content_tag(:div, class: 'controls') do
        (block_given? ? yield : '') +

        content_tag(:span, class: 'help-block') do
          object.errors[name].join(', ')
        end
      end

    end
  end

  def file_field(name, *args)
    field_wrap(name) do
      content_tag(:div, class: 'img-placeholder small') do
        image_tag object.send(name).url(:small)
      end +
      super(name, *args)
    end
  end

end

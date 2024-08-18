module ApplicationHelper
  def modal_button(text, options = {})
    options[:class] ||= 'mt-4 bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded-full'
    options[:data] ||= {}
    # options[:data][:controller] = 'modal'
    options[:data][:action] = 'click->modal#open'

    button_tag(text, options)
  end

  def close_button(options = {})
    options[:class] ||= 'absolute top-2 left-2 text-gray-500 hover:text-gray-700 focus:outline-none'
    options[:aria] ||= { label: 'Close' }
    
    button_tag(type: 'button', **options) do
      content_tag(:svg, class: 'w-6 h-6', fill: 'none', stroke: 'currentColor', viewBox: '0 0 24 24', xmlns: 'http://www.w3.org/2000/svg') do
        content_tag(:path, '', strokeLinecap: 'round', strokeLinejoin: 'round', strokeWidth: '2', d: 'M6 18L18 6M6 6l12 12')
      end
    end
  end

  def relative_time_for(time)
    (Time.zone.now - time) <= 1.day ? time_ago_in_words(time) + " ago" : time.strftime("%b %-d")
  end
end

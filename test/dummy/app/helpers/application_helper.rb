module ApplicationHelper
  def code_snippet(*lines)
    code = lines.join("\n")
    content_tag(:div, class: "mt-4") do
      content_tag(:pre, class: "bg-gray-800 text-gray-100 rounded-lg p-4 overflow-x-auto text-sm font-mono whitespace-pre") do
        content_tag(:code, code)
      end
    end
  end

  def component_example(title = nil)
    content_tag(:div, class: "mt-6") do
      content_tag(:h4, title, class: "text-sm font-medium text-gray-700 mb-3")
    end
  end
end

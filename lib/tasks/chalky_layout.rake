# frozen_string_literal: true

namespace :chalky_layout do
  desc "Update Tailwind @source path for ChalkyLayout gem (run before tailwindcss:build)"
  task :tailwind_source => :environment do
    # Find the Tailwind CSS file
    possible_paths = [
      Rails.root.join("app/assets/tailwind/application.css"),
      Rails.root.join("app/assets/stylesheets/application.tailwind.css")
    ]

    css_path = possible_paths.find { |p| File.exist?(p) }

    unless css_path
      puts "⚠️  Tailwind CSS file not found, skipping ChalkyLayout source update"
      next
    end

    content = File.read(css_path)
    gem_path = ChalkyLayout::Engine.root.to_s

    # Pattern to match existing ChalkyLayout @source directive
    chalky_source_pattern = /@source\s+["'][^"']*chalky_layout[^"']*["'];?\n?/

    # New source directive with current gem path
    new_source = %(@source "#{gem_path}/app/components/**/*.{rb,slim}";\n)

    if content.match?(chalky_source_pattern)
      # Update existing @source
      old_source = content.match(chalky_source_pattern)[0]
      content = content.sub(chalky_source_pattern, new_source)

      if old_source.strip != new_source.strip
        File.write(css_path, content)
        puts "✅ Updated ChalkyLayout @source path:"
        puts "   #{gem_path}/app/components/"
      else
        puts "✅ ChalkyLayout @source path is already correct"
      end
    else
      # Add new @source after @import "tailwindcss"
      if content.match?(/@import ["']tailwindcss["']/)
        content = content.sub(/(@import ["']tailwindcss["'];?\n?)/) do |match|
          "#{match}\n/* ChalkyLayout gem components */\n#{new_source}"
        end
        File.write(css_path, content)
        puts "✅ Added ChalkyLayout @source path:"
        puts "   #{gem_path}/app/components/"
      else
        puts "⚠️  Could not find @import 'tailwindcss' in #{css_path.basename}"
        puts "   Add manually: #{new_source}"
      end
    end
  end
end

# Hook into Tailwind build tasks if they exist
if Rake::Task.task_defined?("tailwindcss:build")
  Rake::Task["tailwindcss:build"].enhance(["chalky_layout:tailwind_source"])
end

if Rake::Task.task_defined?("tailwindcss:watch")
  Rake::Task["tailwindcss:watch"].enhance(["chalky_layout:tailwind_source"])
end

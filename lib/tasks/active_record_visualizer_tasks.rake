namespace :active_record_visualizer do
  task :install => "environment" do
    commands = <<~EOS.split("\n")
      rake webpacker:install
      rake webpacker:install:vue
      yarn add vue-apollo apollo-boost graphql
    EOS
    commands.each do |command|
      unless system(command)
        exit 1
      end
    end
    src_path = Rails.application.root + "config/webpacker.yml"
    data = src_path.read
    engine_path = ActiveRecordVisualizer::Engine.instance.root.relative_path_from(Rails.application.root)
    data.sub!(/source_path: app\/javascript$/) { "source_path: #{engine_path}/app/javascript" }
    src_path.write data
  end
end

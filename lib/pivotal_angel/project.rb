module PivotalAngel
  class Project
    class << self
      def deep_clone(source_project, name)
        new_project = source_project.clone
        new_project.name = name
        new_project.create

        new_project = PivotalTracker::Project.all.detect { |document| document.name == new_project.name }

        puts "Copying stories from #{source_project.name} to #{new_project.name}"
        source_project.stories.all.each do |story|
          new_story = story.clone
          new_story.project_id = new_project.id
          a_new_story = new_story.create

          story.tasks.all.each do |task|
            new_task = task.clone
            new_task.story_id = a_new_story.id
            new_task.project_id = new_project.id
            new_task.create
          end

          story.notes.all.each do |note|
            new_note = note.clone
            new_note.story_id = a_new_story.id
            new_note.project_id = new_project.id
            new_note.create
          end
          putc "."
        end
        puts "Done"
        new_project
      end
    end
  end
end

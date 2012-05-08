module PivotalAngel
  class Project
    class << self
      def deep_clone(source_project, name)
        new_project = PivotalTracker::Project.new name: name,
                                                  iteration_length: source_project.iteration_length,
                                                  point_scale: source_project.point_scale

        new_project = new_project.create

        raise "Uh Oh: #{new_project.errors.errors.join("\n")}" if new_project.errors.errors.to_a.size > 0

        puts "Copying stories from #{source_project.name} to #{new_project.name}"
        source_project.stories.all.each do |story|
        # new story will get the requested_by/owned_by of the api token owner
        # to preserve users, you would need to clone the project first
        # and add all users that were ever on the project to the
        # new project first through the pivotal tracker website
        description = "#{story.description}\n\nOriginally owned by #{story.owned_by}\nOriginally requested by #{story.requested_by}"

        new_story = new_project.stories.create name: story.name,
                                               description: description,
                                               estimate: story.estimate,
                                               story_type: story.story_type,
                                               current_state: story.current_state,
                                               accepted_at: story.accepted_at,
                                               created_at: story.created_at,
                                               labels: story.labels

        raise "Uh Oh: #{new_story.errors.join("\n")}" if new_story.errors.to_a.size > 0

        story.tasks.all.each do |task|
              new_task = nil
              begin
                new_task = new_story.tasks.create description: task.description,
                                                  complete: task.complete
                putc "t"
              rescue
                puts "0"*80
                puts "unable to create #{new_task.inspect}"
                puts "0"*80
              end
        end

        story.notes.all.each do |note|
                new_note = nil
              begin
                new_note = new_story.notes.create text: "#{note.text}\n\nOriginally by #{note.author}",
                                                  noted_at: note.noted_at.to_s,
                                                  author: note.author

                putc "n"
              rescue
                puts "%"*80
                puts "unable to create #{new_note.inspect}"
                puts "%"*80
              end
            end
            putc "."
        end
        puts "Done"
        new_project
      end
    end
  end
end

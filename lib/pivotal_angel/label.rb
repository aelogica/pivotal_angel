module PivotalAngel

  class Label

    class << self

      def apply_to(stories, label)
        stories.each do |s|
          story = get_story(s)
          labels = story.labels.split(',')
          labels << label unless labels.include?(label)
          story.update(:labels => labels.join(','))
        end
      end

      def remove_from(stories, label)
        stories.each do |s|
          story = get_story(s)
          labels = story.labels.split(',')
          labels.delete label
          story.update(:labels => labels.join(','))
        end
      end

      def rename(project, old_label, new_label)
        stories = project.stories.all(:label => old_label)
        stories.each do |story|
          labels = story.labels.split(',')
          labels.delete(old_label)
          labels << new_label
          story.update(:labels => labels.join(','))
        end
      end

    end

    private

    def self.get_story(story)
      if story.is_a? Numeric
        project.stories.all.find{|i| i.id == story }
      elsif story.is_a? PivotalTracker::Story
        story
      else
        raise "Invalid story record in stories array. All elements should either be a story ID or a PivotalTracker::Story"
      end
    end

  end

end

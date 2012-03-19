require 'spec_helper'

describe PivotalAngel::Project do

  let(:project) do
    PivotalTracker::Project.find(504031)
  end

  context ".deep_clone" do
    it "should clone the project including stories, tasks and notes" do
      PivotalAngel::Project.deep_clone(project, "clone of #{project.name}")

      sleep(10)
      clone_project = PivotalTracker::Project.all.find{ |i| i.name == "clone of #{project.name}" }
      clone_project.should_not be_nil
      project.stories.all.size == clone_project.stories.all.size

      # delete cloned project
    end
  end

end

require 'spec_helper'

describe PivotalAngel::Label do

  let(:project) do
    PivotalTracker::Project.find(504031)
  end

  context ".apply_to" do
    it "should apply label to array of stories" do
      stories = project.stories.all(:label => 'cart')
      PivotalAngel::Label.apply_to(stories, 'kariton')

      # Let the Pivotal Elves do the work first before we run our asserts
      sleep(10)
      stories_with_applied_labels = project.stories.all(:label => 'kariton')
      stories_with_applied_labels.size.should == stories.size

      # We should restore the labels so that future tests will also work
      PivotalAngel::Label.remove_from(stories, 'kariton')
    end
  end

  context ".remove_from" do
    it "should remove label from a story" do
      stories = project.stories.all(:label => 'cart')
      PivotalAngel::Label.remove_from(stories, 'cart')

      sleep(10)
      stories_with_applied_labels = project.stories.all(:label => 'cart')
      stories_with_applied_labels.should be_empty

      PivotalAngel::Label.apply_to(stories, 'cart')
    end
  end

  context ".rename" do
    it "should rename labels of a project" do
      PivotalAngel::Label.rename(project, 'shopping', 'splurging')

      sleep(10)
      stories = project.stories.all(:label => 'shopping')
      stories.should be_empty

      PivotalAngel::Label.rename(project, 'splurging', 'shopping')
    end
  end
end

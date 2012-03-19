# PivotalAngel

    A helper gem for manipulating Pivotal Tracker from within a Ruby app. Supplements the pivotal-tracker gem.

## Installation

Add this line to your application's Gemfile:

    gem 'pivotal_angel'

And then execute:

    $ bundle

Or install it yourself:

    $ gem install pivotal_angel

## Usage

# Create a deep clone of a project. Copies over stories, tasks and notes.

    source_project = PivotalTracker::Project.find 123456
    PivotalAngel::Project.deep_clone(source_project, 'cloned_project')

# Rename a label

    project = PivotalTracker::Project.find 123456
    PivotalAngel::Label.rename(project, 'old_label', 'new_label')

# Add a 'expense' label to all stories with the label 'shopping'

    project = PivotalTracker::Project.find 123456
    stories = project.stories.all(:labels => 'shopping')
    PivotalAngel::Label.apply_to(stories, 'expense')

# Remove the 'expense' label from all stories

    project = PivotalTracker::Project.find 123456
    stories = project.stories.all(:labels => 'expense')
    PivotalAngel::Label.remove_from(stories, 'expense')

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

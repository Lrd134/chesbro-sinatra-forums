Specs:

x Use Sinatra to build the app # I used sinatra to handle routes
x Use ActiveRecord for storing information in a database # I used Active Record to create models.
x Include more than one model class (e.g. User, Post, Category) # I have two models.
x Include at least one has_many relationship on your User model (e.g. User has_many Posts) # User has_many posts
x Include at least one belongs_to relationship on another model (e.g. Post belongs_to User) # Post belongs_to user
x Include user accounts with unique login attribute (username or email) # Helper method .exists checks if they exist.
x Ensure that the belongs_to resource has routes for Creating, Reading, Updating and Destroying # These routes exist
x Ensure that users can't modify content created by other users # If you try to edit a resource you don't own you will get an error.
 Include user input validations
 BONUS - not required - Display validation failures to user with error message (example form URL e.g. /posts/new)
 Your README.md includes a short description, install instructions, a contributors guide and a link to the license for your code
Confirm

x You have a large number of small Git commits # I do have a large number of commits.
x Your commit messages are meaningful # I try to give meaningful messages while keeping them short"
x You made the changes in a commit that relate to the commit message # If changes were made irrelevant to a commit, they were very small.
x You don't include changes in a commit that aren't related to the commit message # If there were any changes made there were not commit worthy themselves.
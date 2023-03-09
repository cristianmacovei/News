# News
News app, not done yet

Issue: tableView not being populated with cells.

Cells are custom made in the NewsTableViewCell.swift file
APICaller class has a public function getTopStories(completion). Print statements inside confirm the exit of the function and loading of the articles. Task resumes. 

ViewDidLoad calls the gteTopStories function, seems to miss the switch statemnt. 

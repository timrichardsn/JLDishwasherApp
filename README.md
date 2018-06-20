# Installation Instructions

The project should be good to go, but if you have any problems please follow these instructions.

To install dependencies make sure you have Carthage installed. If you don't you can follow the instructions available [here](https://github.com/Carthage/Carthage/#installing-carthage).

Once installed, you'll need to update and build the frameworks. CD into the project directory and run:

```
carthage update --platform iOS
```

After this, the project should build and run.

# Some things I would've liked to do

- I would like to have better feedback for the user when network requests are taking place. This could be in the form of an activity indicator present when making the initial request to get products, and product detail thereafter.
- I would (and could) spend a lot of time implementing robust network error handling using custom Error enums.

# Decisions

- I chose to use VIPER as the architecture since I'm quite fond of it and find it separates the app responsibilities nicely and in a format that encourages testing.
- I chose to use 2 dependencies, Alamofire and AlamofireImage. Alamofire is a widely used and recognised tool for making network calls in iOS. Regarding AlamofireImage, I could've used one of the other image caching libraries out there such as Kingfisher or SDWebImage, but for consistency sake I decided to use AlamofireImage.
- I chose Carthage as the dependency manager as in my experience I've found it less problematic to integrate with CI solutions such as Jenkins.
- To handle landscape and portrait view on the product detail page, I opted against using UISplitViewController as the UI layout was fairly simple and can be achieved using adaptive layout constraints.

# Final thoughts

I'm a big fan of TDD in production level apps. As you'll be able to see from the commit history I have approached this task as if I were in a production environment. The only difference I suppose is that I haven't worked on feature branches and then merged my work in as I've been going. Normally I would work from feature branches from JIRA and follow Git Flow practices, submit pull requests, and then merge once approved. I did work from a "develop" branch and upon completion merged this into the "master" branch.
# Neighborhood Tool Time

---

### Neighborhood Tool Time is a Ruby on Rails app that was designed to be used by neighborhoods. Neighbors sign up for the app and then add tools, equipiment, etc. that they own. Other neighbors can then sign up to borrow tools from their neighbors.

This app was inspired by my neighbor. Within the same week we had both needed a wheel barrow for landscape projects. He casually mentioned that someone in the neighborhood has to have one and how it would be great if there was an app to be able to see if a neighbor had a wheel barrow to borrow.

Heroku link: https://neighborhood-tool-time.herokuapp.com/

Video Walk-through: https://www.youtube.com/watch?v=AyRlsvqJtx8

---

### Registration

- In order to use the app you will need to register or sign in using a GitHub account. Once you register you will have access to the full functionality of the app.

---

### Installation

- To run this app on a local server:

1. Fork this repo and then clone to your local environment using `git@github.com:stennity8/neighborhood-tool-time.git` <br> for SSH or `https://github.com/stennity8/neighborhood-tool-time.git` for HTTPS
2. `cd` into the newly created `neighborhood-tool-time` folder.
3. Run `bundle install`
4. Run `rails s` and navigate to `localhost:3000`
5. You can now register and play around with the app.

\*\*Note: This app was created using Ruby on Rails 6, which inlcudes Webpacker and Babel. There may additional set up requirments to get these to work on your system. You will also need to make sure you are running Ruby version 2.5 or greater. Also, in order to use the GitHub login functionality you will need to create a .env file in the root directory. Within the .env file you will need to place:

```
GITHUB_KEY=your GitHub secret key here
GITHUB_SECRET=your GitHub secret here
```

### Contributing

- If you are interested in contributing to this app please feel free to submit a pull request.

### Authors

© 2019 by stennity8

### License

This project is licensed under the MIT License:

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE

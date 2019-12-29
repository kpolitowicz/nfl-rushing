# theScore "the Rush" Interview Question
At theScore, we are always looking for intelligent, resourceful, full-stack developers to join our growing team. To help us evaluate new talent, we have created this take-home interview question. This question should take you no more than a few hours.

**All candidates must complete this before the possibility of an in-person interview. During the in-person interview, your submitted project will be used as the base for further extensions.**

### Why a take-home interview?
In-person coding interviews can be stressful and can hide some people's full potential. A take-home gives you a chance work in a less stressful environment and showcase your talent.

We want you to be at your best and most comfortable.

### A bit about our tech stack
As outlined in our job description, you will come across technologies which include a server-side web framework (either Ruby on Rails or a modern Javascript framework) and a front-end Javascript framework (like ReactJS)

### Understanding the problem
In this repo is the file [`rushing.json`](/rushing.json). It contains data about NFL players' rushing statistics. Each entry contains the following information
* `Player` (Player's name)
* `Team` (Player's team abreviation)
* `Pos` (Player's postion)
* `Att/G` (Rushing Attempts Per Game Average)
* `Att` (Rushing Attempts)
* `Yrds` (Total Rushing Yards)
* `Avg` (Rushing Average Yards Per Attempt)
* `Yds/G` (Rushing Yards Per Game)
* `TD` (Total Rushing Touchdowns)
* `Lng` (Longest Rush -- a `T` represents a touchdown occurred)
* `1st` (Rushing First Downs)
* `1st%` (Rushing First Down Percentage)
* `20+` (Rushing 20+ Yards Each)
* `40+` (Rushing 40+ Yards Each)
* `FUM` (Rushing Fumbles)

##### Requirements
1. Create a web app. This must be able to do the following steps
    1. Create a webpage which displays a table with the contents of `rushing.json`
    2. The user should be able to sort the players by _Total Rushing Yards_, _Longest Rush_ and _Total Rushing Touchdowns_
    3. The user should be able to filter by the player's name
    4. The user should be able to download the sorted/filtered data as a CSV

2. Update the section `Installation and running this solution` in the README file explaining how to run your code

### Submitting a solution
1. Download this repo
2. Complete the problem outlined in the `Requirements` section
3. In your personal public GitHub repo, create a new public repo with this implementation
4. Provide this link to your contact at theScore

We will evaluate you on your ability to solve the problem defined in the requirements section as well as your choice of frameworks, and general coding style.

### Help
If you have any questions regarding requirements, do not hesitate to email your contact at theScore for clarification.

### Installation and running this solution

#### How to run the app

`$ docker build -t rushing-app .`

`$ docker run --publish 4000:4000 rushing-app`

The app is available at http://localhost:4000.

Note that sometimes the websocket does not connect properly on the first try. If this happens during
your testing, stop and restart `docker run` until it works.

#### Notes on the solution

Normally, to solve the challenge I would use a quick Phoenix or Rails setup with some minimalistic JS.
I would do the same for ready-to-production code. However, because of the nature of this exercise,
I decided to play a little with Phoenix LiveView, even though it is not an ideal tool for implementing
the required functionality.

The solution is optimized for readability and reliability, not performance. For example, the `rushing.json`
file is read everytime it is needed. Implementing a simple Agent to keep it cached would be beneficial, but the
solution is already fast enough.

Usually I would attempt to clarify the requirements with the product owner, but given that it is an interview
challenge and also a Christmas season, I tried to come up with reasonable assumptions.

I hope you enjoy looking at the app's code as much as I enjoyed writing it!

Now to the caveats...

##### CSV export resets filter and ordering

When you export CSV file, the correct content, based on current ordering and filter, is produced. However,
after the file is generated, the view is reset to the initial state (no filtering, order as in the JSON
file). This is because LiveView treats page request to the server as redirect, re-renders the stats
page and re-mounts the live channel.

It would be quite easy to fix that by providing Agent/GenServer to remember the current order/filter settings
and use them when remounting. Or use the LiveView session for this.

##### Filter does not remember ordering

If you sort by any column, filter by a player's name and then filter by All players, the sort order will be
forgotten. This does not impact functionality much, nor was it specified in requirements that the filter and
ordering should be remembered for any other purpose than generating the CSV file.

Still, if this functionality were needed, it would be quite easy to implement by always passing filter + order
between view and template, in a similar way ordering remembers that results are filtered and does not
bring back all the player rows.

##### Ordering is only descending

Clicking on one of the sortable column headers (TD, Lng, Yds) will sort the table by that column in
descending order. This is just for simplification.

Implementing ordering direction toggle would be easy, but as it was not required, I skipped it.

##### JSON file is read multiple times

As mentioned above, the `rushing.json` is read over and over again, in every request. I decided to keep it
this way, because it is fast enough for the purpose. Also, in production app it would be replaced by a more
reliable data store anyway, so there is really litlle value in optimizing it.

This approach has a side-effect in making the tests quite slow. But again, it is probably not worth fixing
for this simple exercise and for fewer than 20 tests.

##### CSV export href is manually encoded

Rather than using Phoenix Router, the export CSV link is manually constructed and the order and filter params
are manually encoded. This is because LiveView template does not have access to `@conn`, as normal templates
do. In normal circumstances one does not want external links on a LiveView page.

This is why I stated before that LiveView may be not the best tool for this job.

For this exercise however it is a non-issue. Only if there were more requirements to add non-live buttons
and links it would become a problem.


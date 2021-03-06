h1. Getting Started

<div id="letter_shadow">
<div class="letter">
*Dear build -monkey- -master- artist,*

We created CruiseControl.rb so that you can kick ass.

We want you to have basic continuous integration up and running 10 minutes after reading this page.
After that, we want you to find that the tool looks good, does what you expect, and basically just
works. Finally, when you need to do something unusual, we want you to be surprised by how easy that was, too.

In short, we want you to *love* CruiseControl.rb.

Very truly yours,<br/>
<br/>
CruiseControl.rb team<br/>
ThoughtWorks<br/>

<small>P.S. We also want to know if we somehow fall short of these goals.</small>
</div>
</div>

h1. Basics

CruiseControl.rb has two parts: a builder and a dashboard.

*Builder* is a daemon process that polls source control every once in a while for new revisions.

When someone performs a check in, the builder:

# detects it
# updates its own copy of the project
# runs the build
# notifies interested parties about the build's outcome

*Dashboard* is a web application that helps to monitor the status of project builds and troubleshoot failures.

Each installation of CruiseControl.rb may have multiple projects and multiple builders (one per project). There may
also be multiple installations of CruiseControl.rb per computer.


h1. Prerequisites

* "Ruby":http://www.ruby-lang.org/en/ 1.8.4 or 1.8.5 (Note: at the time of this writing there is a known problem with Ruby 1.8.6 that should be fixed in the next release of Ruby 1.8)
* "Subversion":http://subversion.tigris.org/ client 1.4 or later
* svn and ruby executables must both be in the PATH.


h1. Assumptions and limitations

* CruiseControl.rb currently only works with Subversion. We will be adding Mercurial and Git support in a near future.
* Dashboard and all builders need to run on the same computer.


h1. Installation

Follow these directions or watch our "5 minute install":/documentation/screencasts screencast.


1. "Download":http://rubyforge.org/frs/?group_id=2918 and unpack CruiseControl.rb

  p(def). Below, we will refer to the place where you unpack it as <em>[cruise]</em>

2. From <em>[cruise]</em>, run <code>./cruise add your_project --url [URL of your_project Subversion trunk]</code>.

  <p class="def hint">Optionally, you can specify username and password by adding <code> --username [your_user] --password 
    [your_password]</code> to the command</p>


  p(def). This creates a <code>$HOME/.cruise</code> directory (<code>%USERPROFILE%\.cruise</code>
    if you are on Windows), and that is where CruiseControl.rb keeps its data, and then checks out your_project
    from the subversion URL you provided to <code>$HOME/.cruise/projects/your_project/work/</code>.  

  p(def). Documentation refers to $HOME/.cruise/ as <em>[cruise&nbsp;data]</em>.

  p(def hint). Hint: Rakefile of your_project should be in <em>[cruise&nbsp;data]</em>/projects/your_project/work/ directory, not anywhere under
    it. A common mistake is to specify in <code>--url</code> option the root of project's SVN repository instead of the trunk.
    Rakefile then ends up in <em>[cruise&nbsp;data]</em>/projects/your_project/work/trunk/ and CruiseControl.rb does not see it there.


3. From <em>[cruise]</em>, run <code>./cruise start</code>.

  p(def hint). Hint: This starts CruiseControl.rb dashboard and builder(s). By default, the dashboard is bound to port 3333, 
    if you want to run your server on a different port, just type <code>./cruise start -p [port]</code>

4. Browse to "http://localhost:3333":http://localhost:3333. 

  p(def). All going well, weather permitting, you will see a page with CruiseControl.rb logo. This is the dashboard, and it 
    should display your project.  If it's passing, you're done - though you should double check that it's doing what it should be 
    by clicking on the project name and looking at the build log for the last build.  If it's failing or otherwise misbehaving, go 
    on to step 5.
   
5. Go to <em>[cruise&nbsp;data]</em>/projects/your_project/work/ and make the build pass.

  p(def). For a regular Rails app, this involves creating a test database, editing database.yml to connect to that 
    database, performing <code>rake RAILS_ENV=test db:migrate</code>, running <code>rake test</code> and making 
    sure that it passes.

6. Press the "build now" button on the "Dashboard":http://localhost:3333 to rebuild your project

  p(def). This should build your_project and place build outputs into <em>[cruise&nbsp;data]</em>/projects/your_project/build-[revision-number]/

  p(def hint). Hint: Monitor log/your_project_builder.log for any signs of trouble. Try to check in a change to
    your_project and see if the builder can detect and build it.  Check your_project status in the dashboard.

  p(def hint). Hint: <code>./cruise help</code> displays a list of commands, <code>./cruise help [command]</code>
    displays options available for each command.


<div class="next_step">Next step: read the "manual":/documentation/manual</div>

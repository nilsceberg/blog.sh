# blog.sh

**blog.sh** is a collection of simple bash scripts that act as boilerplate
for generating static HTML sites.

It is somewhat inspired by Jekyll.


## Basic usage

A page or post in a blog.sh site is simply a shell script that outputs
HTML. Typically, such a script does this by using another script in the
`layout/` directory: it exports a couple of environment variables
(depending on what layout it uses) and then pipes some source text to the
stdin of the layout script.

A basic *welcome* page (`pages/welcome.sh`), for instance,
might look something like:

```bash
export title="Welcome"

# The 'page' argument tells the base layout to use the 'page' sub-layout
layout/base.sh page << EOF
Hello and welcome to blog.sh!
EOF
```

This approach is rather flexible. For instance, if we want to add some
Markdown formatting to the page, we simply pipe the source text to a
Markdown converter first: 

```bash
export title="Welcome"

(markdown | layout/base.sh page) << "EOF"
*Hello* and **welcome** to `blog.sh`!
EOF
```

And that's it!

In order to allow enumerating pages and/or posts in, for example, the
navigation bar, the `layout/base.sh` script will exit immediately (thus
not outputting anything) if the `render` environment variable is set to `no`.
This is needed to avoid infinite recursion.

It also means that, if you for instance want to list the title of each post,
you can run something like:

```bash
ls posts | while read fileName; do
	render=no source posts/$fileName
	echo $title
done
```
Since `layout/base.sh` also *sets* `render=no` the first time it is run,
this can be done inside layouts (but not pages or posts) without explicitly
setting `render`, in order to create things like nav bars or a post index.


## Writing a post

blog.sh can be used to generate any static site, but its primary intended
use case is minimalistic blogs.

Posts work in exactly the same way as pages; the separation between `pages/`
and `posts/` is merely a logical one.

The default layout files contain a `post` layout, which simply renders a
header with the `title`, the `published` date, and the post's content.
The feed and index layouts list the posts sorted in reversed alphabetical
order, meaning that if you prefix the post's file name with an ISO date,
the latest post will appear first. For instance, we can create
`posts/2017-02-12-hello-world.sh`:

```bash
export title="Hello, world!"

# $published is interpreted and formatted by the date command, so the output
# of date without arguments should do nicely as the value
export published="Sun Feb 12 16:28:10 CET 2017"

(markdown | layout/base.sh post) << "EOF"

**Hello**, world!

Super test post!

EOF
```


## Bare rendering

The `render` environment variable can also be set to `bare`, which - like 
`no` - makes the base layout script exit immediately, except that it first
echoes back the input (that is, the output of the page or post script).

This can be used to create something like a "feed" page with an inline
display of all posts. It can thus be implemented as (see `pages/feed.sh`):

```bash
export title="Feed"

ls -r posts | while read fileName; do
	# Evaluate to get title
	render=no source posts/$fileName

	# Print metadata

	echo '<div class="feed-post">'
	echo "<h1 class='published'>$(date +%D --date="$published")</h1>"
	echo "<h1><a href="$baseUrl/posts/${fileName%%.*}.html">$title</a></h2>"

	# Render bare post content
	render=bare bash posts/$fileName
	
	echo "</div>"
done | layout/base.sh page

```


## Dependencies

blog.sh as a framework doesn't really have any dependencies other than bash,
but the example files use `markdown` for Markdown-to-HTML conversion, and
`python3` as a simple web server in the `watch.sh` implementation (which was
really quickly thrown together and could use some improvement).


## Styling

The HTML structure is easily edited and/or expanded by editing the
`layout/` scripts.

The CSS can, surprisingly, be found in the `css/` directory.



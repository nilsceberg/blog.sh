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

(markdown | layout/base.sh page) << EOF
Hello and welcome to blog.sh!
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
this can be done inside pages, posts, or layouts without explicitly setting
`render`.


## Dependencies

blog.sh as a framework doesn't really have any dependencies other than bash,
but the example files use `markdown` for Markdown-to-HTML conversion, and
`python3` as a simple web server in the `watch.sh` implementation (which was
really quickly thrown together and could use some improvement).


## Styling

The HTML structure is easily edited and/or expanded by editing the
`layout/` scripts.

The CSS can, surprisingly, be found in the `css/` directory.



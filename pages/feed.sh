export title="Feed"

# Since generating the output for this page requires sourcing every
# post, we can catch $render here and exit early if we don't need the output,
# which should be a potentially significant optimization
if [ "$render" == no ]; then
	exit
fi

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


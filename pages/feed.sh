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


echo '<div class="content">'

# Simply put the title at the top
echo "<h1 class='published'>$(date +%D --date="$published")</h1>"
echo "<h1>$title</h1>"

# ...and echo back the content
cat

echo '</div>'


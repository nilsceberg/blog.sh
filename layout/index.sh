function postLink()
{
cat << EOF
	<div class="published">$(date +%D --date "$published")</div>
	<a href='$baseUrl/posts/${1%%.*}.html'>$title</a>
EOF
}

export -f postLink

cat << EOF
<div class="index">
	<div>
		$(cat)
	</div>
	<ul>
		$(ls -r posts | xargs -I% bash -c 'source posts/% > /dev/null && echo "<li>$(postLink %)</li>"')
	</ul>
</div>
EOF


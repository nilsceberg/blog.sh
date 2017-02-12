
function pageLink()
{
	echo "<a href='$baseUrl/${1%%.*}.html'>$title</a>"
}

export -f pageLink

cat << EOF
<nav>
	<ul>
	$(ls pages | xargs -I% bash -c 'source pages/% > /dev/null && echo "<li>$(pageLink %)</li>"')
	</ul>
</nav>
EOF

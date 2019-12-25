
function pageLink()
{
    echo "<a href='$baseUrl/$(renderName $1)'>$title</a>"
}

export -f pageLink

cat << EOF
<nav>
	<ul>
	$(ls pages | xargs -I% bash -c 'render=no source pages/% > /dev/null && echo "<li>$(pageLink pages/%)</li>"')
	</ul>
</nav>
EOF

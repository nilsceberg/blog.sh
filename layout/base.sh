#!/usr/bin/env bash

# If rendering is disabled, simply exit (see below)
if [ "$render" == "no" ]; then
	exit
fi

# Avoid recursively rendering when evaluating pages in for example menus
# (where one might for instance do something like
# `ls pages | xargs bash -I% -c 'source pages/% && ...'`,
# so set render to false
export render=no

# Render
cat << EOF
<!DOCTYPE html>
<html>
	<head>
		<title>$title | $siteTitle</title>
		<meta charset="utf-8">
	</head>
	<body>
		<div id="header">$siteTitle</div>
		$(bash layout/nav.sh)
		<div id="content">
			$(cat)
		</div>
	</body>
</html>
EOF


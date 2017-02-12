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

# First argument is layout; default to 'page'
if [ -z "$1" ]; then
	layout=page
else
	layout="$1"
fi

# Render
cat << EOF
<!DOCTYPE html>
<html>
	<head>
		<title>$title | $siteTitle</title>
		<meta charset="utf-8">
		<link rel="stylesheet" href="$baseUrl/css/reset.css">
		<link rel="stylesheet" href="$baseUrl/css/main.css">
	</head>
	<body>
		<div id="main">
			<div id="header">$siteTitle</div>
			$(bash layout/nav.sh)
			$(bash layout/$layout.sh)
		</div>
	</body>
</html>
EOF


#!/bin/bash 
yt=$(echo "https://Youtube.com")
json=$(curl 'https://www.youtube.com/results?search_query=intitle%3Apimax&sp=CAISBAgCEAE%253D' | grep -Po '(?<=ytInitialData = ).*(?<=:{}}|]};)')
items=$(echo $json | jq -r '.contents.twoColumnSearchResultsRenderer.primaryContents.sectionListRenderer.contents[]?.itemSectionRenderer.contents[]? | length' )
title=$(echo "$json" | jq -r  '.contents.twoColumnSearchResultsRenderer.primaryContents.sectionListRenderer.contents[]?.itemSectionRenderer.contents[]? | .videoRenderer.title.runs[]?.text')
videoID=$(echo "$json" | jq -r '.contents.twoColumnSearchResultsRenderer.primaryContents.sectionListRenderer.contents[]?.itemSectionRenderer.contents[]? | .videoRenderer.videoId')
url=$(echo "$json" | jq -r '.contents.twoColumnSearchResultsRenderer.primaryContents.sectionListRenderer.contents[]?.itemSectionRenderer.contents[]? | .videoRenderer.navigationEndpoint.commandMetadata.webCommandMetadata.url')
link=$(echo "$yt$url")
Description=$(echo "$json" | jq -r  '.contents.twoColumnSearchResultsRenderer.primaryContents.sectionListRenderer.contents[]?.itemSectionRenderer.contents[]? | .videoRenderer.title.runs[]?.text')
thumbnail=$(echo "$json" | jq -r '.contents.twoColumnSearchResultsRenderer.primaryContents.sectionListRenderer.contents[]?.itemSectionRenderer.contents[]? | .videoRenderer.title.runs[]?.text')
owner=$(echo $json | jq -r '.contents.twoColumnSearchResultsRenderer.primaryContents.sectionListRenderer.contents[]?.itemSectionRenderer.contents[]? | .videoRenderer.ownerText.runs[]?.text')
BuildDate=$(echo date) 
echo "<?xml version='1.0' encoding='UTF-8'?>
<rss xmlns:dc='http://purl.org/dc/elements/1.1/' xmlns:content='http://purl.org/rss/1.0/modules/content/' xmlns:atom='http://www.w3.org/2005/Atom' xmlns:media='http://search.yahoo.com/mrss/' version='2.0'><channel><title><![CDATA[ Pimax - YouTube ]]></title><description><![CDATA[ Pimax - YouTube ]]></description>
<link>https://www.youtube.com/results?search_query=intitle%3Apimax&amp;sp=CAISBAgCEAE%253D</link>
<image>
<url>https://www.youtube.com/s/desktop/a386e432/img/favicon.ico</url>
<title>Pimax - YouTube</title>
<link>https://www.youtube.com/results?search_query=intitle%3Apimax&amp;sp=CAISBAgCEAE%253D</link>
</image>
<generator>https://github.com</generator>
<lastBuildDate> $(date) </lastBuildDate>
<atom:link href='hhttps://raw.githubusercontent.com/PylotLight/Pimax_RSS/master/XML/RSS.xml' rel='self' type='application/rss+xml'/><language>
<![CDATA[ en ]]></language>" > ./XML/RSS.xml
for vid in $(seq 1 $items)
do
echo "<item><title><![CDATA[ $title ]]></title>
<description><![CDATA[ <div><div><div style='left: 0; width: 100%; height: 0; position: relative; padding-bottom: 56.25%;'><iframe src='https://www.youtube.com/embed/gb3KM02CBIg' style='border: 0; top: 0; left: 0; width: 100%; height: 100%; position: absolute;' allowfullscreen scrolling='no' allow='encrypted-media; accelerometer; gyroscope; picture-in-picture'></iframe></div></div></div> ]]></description>
<link> ${link} </link>
<guid isPermaLink='false'>0db24e910f2d4f08620ca0b584fcaeb2</guid><dc:creator><![CDATA[ ${owner} ]]></dc:creator>
<pubDate> $(date) </pubDate>
<media:content medium='image' url='https://i.ytimg.com/vi/gb3KM02CBIg/maxresdefault.jpg'/></item>" >> ./XML/RSS.xml
done
echo '</channel></rss>' >> ./XML/RSS.xml


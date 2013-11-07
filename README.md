# GigaSpaces XAP Documentation

This repository contains the markup files, html templates and javascript sources for the new [GigaSpaces XAP documentation portal](http://wiki.gigaspaces.com.s3-website-us-east-1.amazonaws.com). 
It's based on [Jekyll](http://jekyllrb.com/), a Ruby-based static site generator. It was originally ported from Atlassian Confluence, and therefore multiple useful Jekyll [plugins](#available-plugins) were defined. The plugins mimic the behavior of original Confluene plugins to allow for easy migration from Confulence and provide content editor with useful markup extensions that are relevant to online documentation portals. 

## Installing and Testing Locally 
To run and test the website locally, you should perform the following steps: 
* Install the latest version of Jekyll (you can find detailed directions [here](http://jekyllrb.com/docs/installation/) 
* Clone this repository: 
```
git clone https://github.com/uric/gigaspaces-wiki-jekyll.git
```
* cd to the clone directory: 
```
cd gigaspaces-wiki-jekyll
```
* Run Jekyll in sever mode, and wait for the site generation to complete: 
```
jekyll serve
```
You should see the following output if everything was ok: 
```
Configuration file: /Users/uri1803/dev/gigaspaces-wiki-jekyll/_config.yml
            Source: /Users/uri1803/dev/gigaspaces-wiki-jekyll
       Destination: /Users/uri1803/dev/gigaspaces-wiki-jekyll/_site
      Generating... done.
    Server address: http://0.0.0.0:4000
  Server running... press ctrl-c to stop.
```

* Point your browser to [http://localhost:4000]. You should see the documentation portal home page. 

## Contributing 
TBD

## Available Plugins 
TBD

---
layout: post
title:  XAP Screencasts
categories: TUTORIALS
weight: 100
parent: none
---

#### Click the playlist icon at the top left of the player to view additional videos

<div id="player"></div>
<div id="listDiv">
	<ul id="list"></ul>
</div>

<script>
  // 2. This code loads the IFrame Player API code asynchronously.
  var tag = document.createElement('script');

  tag.src = "https://www.youtube.com/iframe_api";
  var firstScriptTag = document.getElementsByTagName('script')[0];
  firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);

  // 3. This function creates an <iframe> (and YouTube player)
  //    after the API code downloads.
  var player;
  function onYouTubeIframeAPIReady() {
    player = new YT.Player('player', {
      height: '480',
      width: '853',
      videoId: 'A3KcONlCIXU',
      playerVars: { 
        //'autoplay': 1, 
        'enablejsapi': 1, 
        //'quality': 'hd720',
        'list': 'PL2n0rHgIKEuUIl4-Lfm3PsqEgk0N63E8Q', 
        'listType': 'playlist'
      },
      events: {
        'onReady': onPlayerReady
        //'onStateChange': onPlayerStateChange
      }
    });
  }

  // 4. The API will call this function when the video player is ready.
  function onPlayerReady(event) {
    console.log(event.target.setPlaybackQuality('small'));
    console.log(event.target.getPlaybackQuality());//('small')
    /*var list = player.getPlaylist();      
    for (var i=0; i<list.length; i++) {
      $("#list").append("<li>"+list[i]+"</li>");
    }*/

    event.target.playVideo();
  }

  
</script>



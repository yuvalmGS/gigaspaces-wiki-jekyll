---
layout: post
title:  XAP Videos 
categories:
parent: none
---

#### Click a thumbnail to watch the relevant video

<div id="player"></div>
<div id="videosDiv"></div>

<script src="/js/ekko-lightbox.js"></script>
<script>

  var mq = window.matchMedia( "(min-width: 1024px)" );
  function listVideos() {
  	var videosPerRow = 2; 
  	if (mq.matches) {
  		videosPerRow = 4; 
  	}
  	var playListURL = 'http://gdata.youtube.com/feeds/api/playlists/2n0rHgIKEuUIl4-Lfm3PsqEgk0N63E8Q?v=2&alt=json&callback=?';
  	var videoURL= 'http://www.youtube.com/watch?v=';
  	var embedURL= 'http://www.youtube.com/embed/';
  	$.getJSON(playListURL, function(data) {  		
  		$.each(data.feed.entry, function(i, item) {        
  			var feedTitle = item.title.$t;
  			var desc = item.media$group.media$description.$t;
  			var feedURL = item.link[1].href;
  			var fragments = feedURL.split("/");
  			var videoID = fragments[fragments.length - 2];
        	var thumb = "http://img.youtube.com/vi/"+ videoID +"/0.jpg";
  			var url = videoURL + videoID;						
	        var rowId = "videosRow" + Math.floor(i/videosPerRow);
	        if (i%videosPerRow == 0) {
	          var rowHtml = '<div class="row" id="' + rowId + '"></div>';        
	          $("#videosDiv").append(rowHtml);  
	          $("#videosDiv").append('</br>');  

	        }
	        var vid = null; 
	        if (mq.matches) {
	        	vid = '<a href="' + url + '" data-toggle="lightbox" data-width="853" data-height="480" data-' + 
	            'gallery="youtubevideos" class="col-sm-3 col-md-3 col-xs-6"><img src="'+ thumb + '" class="img-responsive img-rounded">' +  
	            feedTitle  +'</a>';
	        	$("#" + rowId).append(vid);  			
	        } else {
	        	vid = '<div class="col-xs-6"><iframe src="' + embedURL + videoID + '" frameborder="0" width="80%"></iframe></br>'+feedTitle +'</div>';
	        	$("#" + rowId).append(vid);  			
	        }
  		});
    });
  }

  listVideos();

  
  if (mq.matches) {
    $(document).delegate('*[data-toggle="lightbox"]', 'click', function(event) {
      event.preventDefault();
      return $(this).ekkoLightbox();
    });
  }

</script>



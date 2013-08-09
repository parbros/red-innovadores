window.SocialPoints = {
  init: function() {
    this.cacheElements();
    this.bindElements();
  },
  
  cacheElements: function() {
    this.facebookShare = $('.st_facebook_hcount');
    this.facebookLike = $('.st_fblike_hcount');
    this.tweet = $('.st_twitter_hcount');
    this.google = $('.st_googleplus_hcount');
    this.commentLike = $('.fb-like')
  },
  
  bindElements: function() {
    klass = this;
    this.facebookShare.on('click', function() {klass.addPoints(10, 'Social')});
    this.facebookLike.on('click', function() {klass.addPoints(10, 'Social')});
    this.tweet.on('click', function() {klass.addPoints(10, 'Social')});
    this.google.on('click', function() {klass.addPoints(10, 'Social')});
    this.commentLike.on('click', function() {
      klass.addPoints(5, 'Social');
      klass.addPoints(5, 'Comentador');
    })
  },
  
  addPoints: function(points, type) {
    $.get('/add_points', {points: points, type: type});
  }
}
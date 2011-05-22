Ajax.Responders.register({
  onCreate: function() {
    if(jQuery('loading') && Ajax.activeRequestCount>0)
      Effect.Appear('loading',{duration:0.25,queue:'end'});
  },
  onComplete: function() {
    if(jQuery('loading') && Ajax.activeRequestCount==0)
      Effect.Fade('loading',{duration:0.25,queue:'end'});
  }
});
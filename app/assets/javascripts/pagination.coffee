jQuery ->
  if $('#infinite-scrolling').size() > 0
        $(window).on 'scroll', ->
        more_microposts_link = $('.pagination .next_page a').attr('href')
        if more_microposts_link && $(window).scrollTop() > $(document).height() - $(window).height() - 60
            $('.pagination').html('<img src="ajax-loader.gif" alt="Loading..." title="Loading..." />')
            $.getScript more_microposts_link
        return
    return
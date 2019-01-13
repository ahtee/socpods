jQuery -> 
    if $('#infinite-scrolling').size() > 0
        $(window).on 'scroll', ->
            more_micropost_url = $('.pagination .next_page a').attr('href')
            if more_micropost_url && $(window).scrollTop() > $(document).height() - $(window).height() - 60
                $('.pagination').html('<img src="ajax-loader.gif" alt="Loading..." title="Loading..." />')
                $.getScript more_micropost_url
            return
    return

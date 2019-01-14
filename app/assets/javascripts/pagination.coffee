jQuery ->
  if $('#infinite-scrolling').size() > 0
        $(window).on 'scroll', ->
        more_microposts_link = $('.pagination .next_page a').attr('href')
        if more_microposts_link && $(window).scrollTop() > $(document).height() - $(window).height() - 60
            $('.pagination').html('<div class="d-flex justify-content-center">
                                    <div class="spinner-border" role="status">
                                        <span class="sr-only">Loading...</span>
                                    </div>
                                   </div>')
            $.getScript more_microposts_link
        return
    return
module ApplicationHelper
    def randomized_background_image
        images = ["assets/images/gifloop.gif", "assets/images/wheat.gif", "assets/images/waves.gif"]
        images[rand(images.size)]
    end
end

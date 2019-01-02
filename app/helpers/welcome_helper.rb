module WelcomeHelper
    def randomized_background_image
        images = ["assets/gifloop.gif", "assets/wheat.gif", "assets/waves.gif", "assets/nightsky.gif", "assets/pool.gif", "assets/street.gif", "assets/world.gif", "assets/hotdog.gif"]
        images[rand(images.size)]
    end
end

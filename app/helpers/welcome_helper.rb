module WelcomeHelper
    def randomized_background_image
        images = ["gifloop.gif", "assets/random.jpg", "assets/super_random"]
        images[rand(images.size)]
      end
end

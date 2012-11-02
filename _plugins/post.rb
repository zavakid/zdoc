module Jekyll
  class Post
    def render(layouts, site_payload)
      # construct payload                                                                                                                                        
      payload = {
        "site" => { 
          "related_posts" => related_posts(site_payload["site"]["posts"]),
          "other_random_posts" => other_random_posts(site_payload["site"]["posts"]) 
        },
        "page" => self.to_liquid
      }.deep_merge(site_payload)

      do_layout(payload, layouts)
    end

    def other_random_posts(posts)
      return [] unless posts.size > 1
      (posts.shuffle - [self])[0..9]
    end
  end
end

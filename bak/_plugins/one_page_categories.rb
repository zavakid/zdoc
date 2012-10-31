module Jekyll

  class OnePageCategory < Page

    # Init a new OnePaeCategoryPage
    #
    # site - The site object
    # base - The String path to the source
    # dir  - The String path between the source and the file
    #  name - The String filename of the file
    def initialize(site, base, dir, name)
      @site = site
      @base = base
      @dir = dir
      @name = name

      self.process(@name)

      #init data
      self.data ||= {}
      self.data['layout'] = 'one_page_category'
      self.data['title'] = site.config['one_page_category_title'] || 'Categories'
    end
  end


  class OnePageCategoryGenerator < Generator
    safe true

    def generate(site)
      if site.layouts.key? 'one_page_category'
        site.pages << OnePageCategory.new(site, site.source, '', 'categories.html')
      end
    end

  end

end

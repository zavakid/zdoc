module Jekyll
  module Filters

    ## 2012-12-24 for example
    def date_to_standard(date)
      date.strftime("%Y-%m-%d")
    end

  end
end

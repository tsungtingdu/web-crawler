class UnitPagePresenter

  def initialize(unit_url, mechanize_agent)
    @unit_url = unit_url
    @mechanize_agent = mechanize_agent

    # use nokogiri to parse HTML
    # use begin/rescue to solve 404 issue (there are some pages are 404)
    # use .xpath to find the specific content I need
    begin   
      @page = mechanize_agent.get @unit_url  
      @doc = Nokogiri::HTML(@page.body)
      @quiz_divs = @doc.xpath("//div[@class='quiz']")
    rescue
      @quiz_divs = [] 
    end  
  end

  # use quizzes method to sort out the data

  def quizzes
    if @quiz_divs
      @quiz_divs.map do |quiz_div|
        arr = quiz_div.children.inner_text.split("\n").delete_if(&:blank?)
        {
          title: arr[1],
          options: arr[2..-3],
          explanation: arr[-2]
        }
      end
    end
  end
  
end
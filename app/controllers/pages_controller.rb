class PagesController < ApplicationController

  def index
    # use mechanize to fill in the login form and submit
    
    @agent = Mechanize.new
    login_page = @agent.get() #url  
    login_form = login_page.form
    login_form['user[email]'] =  #email
    login_form['user[password]'] = #password
    @page = @agent.submit(login_form)
  end

end

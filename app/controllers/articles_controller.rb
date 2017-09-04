class ArticlesController < ApplicationController

  require 'nokogiri'
  require 'open-uri'

  def scraping
    user_name = params[:user_name].to_s

    html = open("https://github.com/#{user_name}?tab=repositories").read
    doc = Nokogiri::HTML(html)
    entries = doc.css('#user-repositories-list ul li')
    @repositoriesArray = []
    entries.each do |entry|
      title = entry.at_css('h3 a').text.strip
      # code = entry.at_css('.repo-language-color, .ml-0').text.strip
      # code = "CSS"
      date = entry.at_css('relative-time').text.strip
      # code_color = entry.at_css('span.repo-language-color').attr('style')
      # code_color = entry.css('div')[1].to_html
      @repositoriesArray.push([title,date,user_name])
    end

    profile = doc.css('.h-card')
    @profileArray = []
    profile.each do |entry|
      name = profile.at_css('.p-name').text.strip
      username = profile.at_css('.p-nickname').text.strip
      img = profile.at_css('.avatar').attr('src')
      @profileArray.push([img, name, username])
    end

      # @repositoriesArray.paginate(:page => 1, :per_page => 5)

    respond_to do |format|
      format.html
      format.js # handle ajax request
    end

  end

end

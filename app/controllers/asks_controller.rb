class AsksController < ApplicationController
  def new
    @ask = Ask.new
    all_doc_query = "matchall&q.parser=structured"
    # @all_docs = get_tweets_from_cloud_search(all_doc_query)
    @all_docs = get_full_doc_from_cloudsearch(all_doc_query)

    # Get statistic data from cloudsearch
    @manhattan = []
    @manhattan[0] = get_doc_from_cloudsearch("manhattan%20noise-residential")
    @manhattan[1] = get_doc_from_cloudsearch("manhattan%20noise-commercial")
    @manhattan[2] = get_doc_from_cloudsearch("manhattan%20noise-vehicle")
    @manhattan[3] = get_doc_from_cloudsearch("manhattan%20noise-street")

    @brooklyn = []
    @brooklyn[0] = get_doc_from_cloudsearch("brooklyn%20noise-residential")
    @brooklyn[1] = get_doc_from_cloudsearch("brooklyn%20noise-commercial")
    @brooklyn[2] = get_doc_from_cloudsearch("brooklyn%20noise-vehicle")
    @brooklyn[3] = get_doc_from_cloudsearch("brooklyn%20noise-street")

    @queens = []
    @queens[0] = get_doc_from_cloudsearch("queens%20noise-residential")
    @queens[1] = get_doc_from_cloudsearch("queens%20noise-commercial")
    @queens[2] = get_doc_from_cloudsearch("queens%20noise-vehicle")
    @queens[3] = get_doc_from_cloudsearch("queens%20noise-street")

    @bronx = []
    @bronx[0] = get_doc_from_cloudsearch("bronx%20noise-residential")
    @bronx[1] = get_doc_from_cloudsearch("bronx%20noise-commercial")
    @bronx[2] = get_doc_from_cloudsearch("bronx%20noise-vehicle")
    @bronx[3] = get_doc_from_cloudsearch("bronx%20noise-street")

    @staten = []
    @staten[0] = get_doc_from_cloudsearch("staten%20noise-residential")
    @staten[1] = get_doc_from_cloudsearch("staten%20noise-commercial")
    @staten[2] = get_doc_from_cloudsearch("staten%20noise-vehicle")
    @staten[3] = get_doc_from_cloudsearch("staten%20noise-street")


  end

  def create
    @ask = Ask.new
    @query = ask_params
    @search_query = ask_params[:query]
    @search_result = get_full_doc_from_cloudsearch(@search_query)



  end

  private

    def ask_params
      params.require(:ask).permit(:query)
    end

    def get_complaint_from_query(query)
        url1 = "http://search-nyc-noise-map-cp-zmgtbsu4ea5fhof2ti7nvrsdcy.us-east-1.cloudsearch.amazonaws.com/2013-01-01/search?q="
        url2 = "&q.parser=simple&q.options=%7B%22defaultOperator%22%3A%22and%22%2C%22fields%22%3A%5B%22complaint_type%22%5D%2C%22operators%22%3A%5B%22and%22%2C%22escape%22%2C%22fuzzy%22%2C%22near%22%2C%22not%22%2C%22or%22%2C%22phrase%22%2C%22precedence%22%2C%22prefix%22%2C%22whitespace%22%5D%7D&return=_all_fields%2C_score&highlight.closed_date=%7B%22max_phrases%22%3A3%2C%22format%22%3A%22text%22%2C%22pre_tag%22%3A%22*%23*%22%2C%22post_tag%22%3A%22*%25*%22%7D&highlight.community_board=%7B%22max_phrases%22%3A3%2C%22format%22%3A%22text%22%2C%22pre_tag%22%3A%22*%23*%22%2C%22post_tag%22%3A%22*%25*%22%7D&highlight.complaint_type=%7B%22max_phrases%22%3A3%2C%22format%22%3A%22text%22%2C%22pre_tag%22%3A%22*%23*%22%2C%22post_tag%22%3A%22*%25*%22%7D&highlight.created_date=%7B%22max_phrases%22%3A3%2C%22format%22%3A%22text%22%2C%22pre_tag%22%3A%22*%23*%22%2C%22post_tag%22%3A%22*%25*%22%7D&highlight.cross_street_1=%7B%22max_phrases%22%3A3%2C%22format%22%3A%22text%22%2C%22pre_tag%22%3A%22*%23*%22%2C%22post_tag%22%3A%22*%25*%22%7D&highlight.cross_street_2=%7B%22max_phrases%22%3A3%2C%22format%22%3A%22text%22%2C%22pre_tag%22%3A%22*%23*%22%2C%22post_tag%22%3A%22*%25*%22%7D&highlight.due_date=%7B%22max_phrases%22%3A3%2C%22format%22%3A%22text%22%2C%22pre_tag%22%3A%22*%23*%22%2C%22post_tag%22%3A%22*%25*%22%7D&highlight.incident_address=%7B%22max_phrases%22%3A3%2C%22format%22%3A%22text%22%2C%22pre_tag%22%3A%22*%23*%22%2C%22post_tag%22%3A%22*%25*%22%7D&highlight.intersection_street_1=%7B%22max_phrases%22%3A3%2C%22format%22%3A%22text%22%2C%22pre_tag%22%3A%22*%23*%22%2C%22post_tag%22%3A%22*%25*%22%7D&highlight.intersection_street_2=%7B%22max_phrases%22%3A3%2C%22format%22%3A%22text%22%2C%22pre_tag%22%3A%22*%23*%22%2C%22post_tag%22%3A%22*%25*%22%7D&highlight.location=%7B%22max_phrases%22%3A3%2C%22format%22%3A%22text%22%2C%22pre_tag%22%3A%22*%23*%22%2C%22post_tag%22%3A%22*%25*%22%7D&highlight.resolution_action_updated_date=%7B%22max_phrases%22%3A3%2C%22format%22%3A%22text%22%2C%22pre_tag%22%3A%22*%23*%22%2C%22post_tag%22%3A%22*%25*%22%7D&highlight.street_name=%7B%22max_phrases%22%3A3%2C%22format%22%3A%22text%22%2C%22pre_tag%22%3A%22*%23*%22%2C%22post_tag%22%3A%22*%25*%22%7D&sort=_score+desc"

        url = url1 + query + url2
        uri = URI.parse(url)

        @link = url
        # Get Response of HTTP Request
        begin
          @response_cloud_search = Net::HTTP.get_response(uri)
        rescue SocketError => e
          puts e.message
        end
        # Parse Request into JSON file.
        @parsed = JSON.parse @response_cloud_search.body unless @response_cloud_search.nil?
        @parsed['hits']['found'].to_i

    end

    def get_doc_from_cloudsearch(search_query)
      require "net/http"
      require "uri"
      require "json"

      search_end_point = "http://search-nyc-noise-map-cp-zmgtbsu4ea5fhof2ti7nvrsdcy.us-east-1.cloudsearch.amazonaws.com/2013-01-01/"
      link_to_cloudsearch = search_end_point + 'search?q=' + search_query + '&return=_all_fields'
      uri = URI.parse(link_to_cloudsearch)

      @link = link_to_cloudsearch
      # Get Response of HTTP Request
      begin
        @response_cloud_search = Net::HTTP.get_response(uri)
      rescue SocketError => e
        puts e.message
      end
      # Parse Request into JSON file.
      @parsed = JSON.parse @response_cloud_search.body unless @response_cloud_search.nil?
      @parsed['hits']['found'].to_i
    end




  def get_full_doc_from_cloudsearch(search_query)
    require "net/http"
    require "uri"
    require "json"

    search_end_point = "http://search-nyc-noise-map-cp-zmgtbsu4ea5fhof2ti7nvrsdcy.us-east-1.cloudsearch.amazonaws.com/2013-01-01/"
    link_to_cloudsearch = search_end_point + 'search?q=' + search_query + '&return=_all_fields'
    uri = URI.parse(link_to_cloudsearch)

    @link = link_to_cloudsearch
    # Get Response of HTTP Request
    begin
      @response_cloud_search = Net::HTTP.get_response(uri)
    rescue SocketError => e
      puts e.message
    end
    # Parse Request into JSON file.
    @parsed = JSON.parse @response_cloud_search.body unless @response_cloud_search.nil?


    size = @parsed['hits']['found']
    search_end_point = "http://search-nyc-noise-map-cp-zmgtbsu4ea5fhof2ti7nvrsdcy.us-east-1.cloudsearch.amazonaws.com/2013-01-01/"
    link_to_cloudsearch = search_end_point + 'search?q=' + search_query + '&return=_all_fields' + '&size=' + size.to_s
    uri = URI.parse(link_to_cloudsearch)

    @link = link_to_cloudsearch
    # Get Response of HTTP Request
    begin
      @response_cloud_search = Net::HTTP.get_response(uri)
    rescue SocketError => e
      puts e.message
    end
    # Parse Request into JSON file.
    @parsed = JSON.parse @response_cloud_search.body unless @response_cloud_search.nil?


  end

  # def get_objects_from_s3
  #   require 'aws-sdk'
  #
  #   object_key =  "kmeansCentersCSV.csv"
  #
  #
  #
  #       # retrieve the access key and secret key
  #   access_key_id = ENV['AKIAJQISAHEBLQ4QUI6Q']
  #   secret_access_key = ENV['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']
  #
  #       # create an instance of the s3 client
  #   s3 = AWS::S3.new(access_key_id: access_key_id, secret_access_key: secret_access_key)
  #
  #       # get the bucket
  #   # bucket = s3.buckets['outputkmeans']
  #
  #       # retrieve the objects
  #
  #   # bucket.objects.each do |object|
  #   #   if object.key.equal?(object_key)
  #   #     return object
  #   #   end
  #   # end
  #
  # end

end

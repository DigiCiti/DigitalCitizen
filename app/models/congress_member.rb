require 'uri'
require 'net/http'
require 'openssl'
require 'json'

class CongressMember
  attr_accessor :endpoint, :branch, :member_id

  def initialize(args = {})
    @endpoint = args.fetch(:endpoint, "n/a")
    @branch = args.fetch(:branch, "n/a")
    @member_id = args.fetch(:member_id, "n/a")

    if @endpoint == "member_list"
      url = URI("https://api.propublica.org/congress/v1/115/#{@branch}/members.json")
    elsif @endpoint == "find_member"
      url = URI("https://api.propublica.org/congress/v1/members/#{@member_id}.json")
    end

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Get.new(url)
    request["x-api-key"] = ENV['PROPUBLICA_KEY']
    request["cache-control"] = 'no-cache'
    request["postman-token"] = ENV['PROPUBLICA_POSTMAN_TOKEN']

    response = http.request(request)
    @parsed_response = JSON.parse(response.read_body)
  end

  # def get_members_full_info(full_name, state)
  #   member_full_details = @parsed_response["results"][0]["members"]
  #   found_member = []
  #   member_full_details.each do |member|
  #     member_full_name = "#{member["first_name"]}" + " #{member["last_name"]}"
  #     if full_name == member_full_name && state == member["state"]
  #       found_member = member
  #     end
  #   end
  #   found_member
  # end

  def members_basic_details
    members_115_details = @parsed_response["results"][0]["members"]
    member_basics_hashes = []
    members_115_details.each_with_index do |member, i|
      member = {}
      member[:id] = members_115_details[i]["id"]
      member[:full_name] = members_115_details[i]["first_name"] + " #{members_115_details[i]["last_name"]}"
      member[:state] = members_115_details[i]["state"]
      member[:party] = members_115_details[i]["party"]
      member[:votes_with_party_pct] = members_115_details[i]["votes_with_party_pct"]
      member_basics_hashes << member
    end
    member_basics_hashes
  end


  def single_member_details
    member_details = @parsed_response["results"][0]
  end

  # def get_member_basic_info(full_name, state)
  #   found_member = {}
  #   self.members_basic_details.each do |member|
  #     if full_name == member[:full_name] && state == member[:state]
  #       found_member = member
  #     end
  #   end
  #   found_member
  # end
end

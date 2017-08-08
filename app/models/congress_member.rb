require 'uri'
require 'net/http'
require 'openssl'

class Congress < ApplicationRecord

  def initialize
    url = URI("https://api.propublica.org/congress/v1/115/house/members.json")

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Get.new(url)
    request["x-api-key"] = ENV['PROPUBLICA_KEY']
    request["cache-control"] = 'no-cache'
    request["postman-token"] = ENV['PROPUBLICA_POSTMAN_TOKEN']

    response = http.request(request)
    pre_parse = response.read_body
    @house_members_115 = JSON.parse(pre_parse)
  end

  def get_member_full_info(full_name, state)
    member_full_details = @house_members_115["results"][0]["members"]
    found_member = []
    member_full_details.each do |member|
      member_full_name = "#{member["first_name"]}" + " #{member["last_name"]}"
      if full_name == member_full_name && state == member["state"]
        found_member = member
      end
    end
    found_member
  end

  def get_basic_member_details
    house_members_115_details = @house_members_115["results"][0]["members"]
    member_basics_hashes = []
    house_members_115_details.each_with_index do |member, i|
      house_member = {}
      house_member[:full_name] = house_members_115_details[i]["first_name"] + " #{house_members_115_details[i]["last_name"]}"
      house_member[:state] = house_members_115_details[i]["state"]
      house_member[:party] = house_members_115_details[i]["party"]
      house_member[:votes_with_party_pct] = house_members_115_details[i]["votes_with_party_pct"]
      member_basics_hashes << house_member
    end
    member_basics_hashes
  end

  def get_member_basic_info(full_name, state)
    found_member = {}
    self.get_basic_member_details.each do |member|
      if full_name == member[:full_name] && state == member[:state]
        found_member = member
      end
    end
    found_member
  end

end

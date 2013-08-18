require 'debugger'              # optional, may be helpful
require 'open-uri'
require 'cgi'
require 'nokogiri'
require 'active_model'

class OracleOfBacon

  class InvalidError < RuntimeError ; end
  class NetworkError < RuntimeError ; end

  attr_accessor :from, :to
  attr_reader :api_key
  
  include ActiveModel::Validations
  validates_presence_of :from
  validates_presence_of :to
  validates_presence_of :api_key
  validate :from_does_not_equal_to

  def from_does_not_equal_to
    # YOUR CODE HERE
    if @from == @to
      self.errors.add(:from, 'cannot be the same as To')
    end
  end

  def initialize(api_key='')
    @api_key = api_key
    @from = 'Kevin Bacon'
    @to = 'Kevin Bacon'
  end

  def find_connections
    raise InvalidError unless self.valid?
    uri = make_uri_from_arguments
  end

  def make_uri_from_arguments
    'http://oracleofbacon.org/cgi-bin/xml?p=38b99ce9ec87&a=' +
      CGI.escape(from) + '&b=' + CGI.escape(to)
  end
      

end


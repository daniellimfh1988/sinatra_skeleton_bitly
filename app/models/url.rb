class Url < ActiveRecord::Base
  belongs_to :user
  validates :long_url, :format => URI::regexp(%w(http https)) #ask jay tomorrow http://ruby-doc.org/stdlib-2.1.1/libdoc/uri/rdoc/URI.html
end

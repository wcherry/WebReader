# == Schema Information
#
# Table name: webviews
#
#  id          :integer          not null, primary key
#  aurl        :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#  line_number :integer
#

class Webview < ActiveRecord::Base
	#attr_accessor :url, :line_number
end

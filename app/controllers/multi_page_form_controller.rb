class MultiPageFormController < ApplicationController
	include Wicked::Wizard

	steps :confirm_password, :confirm_profile, :find_friends
end

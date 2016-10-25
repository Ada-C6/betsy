class HomeController < ApplicationController
    # Will likely need to remove this line (or further customize this), once we've narrowed down which pages require login. This line allows our tests to pass.
    skip_before_action :require_login
    
    def index; end
end

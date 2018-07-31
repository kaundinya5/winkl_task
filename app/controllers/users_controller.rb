class UsersController < ApplicationController

  def index

  end
  def filter
    all_scope = User
    if params[:filter].has_key?(:emailPresent)
      if params[:filter][:emailPresent] == "yes"
        all_scope = all_scope.where.not(:email=>nil)
      else
        all_scope = all_scope.where(:email=>nil)
      end
    end
    if params[:filter].has_key?(:followers)
      case params[:filter][:followers]
        when "<500"
          all_scope = all_scope.where("CAST(followers AS INT)<  ?", 500)
        when "<1k"
          all_scope = all_scope.where("CAST(followers AS INT) >= ? AND CAST(followers AS INT) < ?", 500, 1000)
        when "<5k"
          all_scope = all_scope.where("CAST(followers AS INT) >= ? AND CAST(followers AS INT) < ?", 1000, 5000)
        when "<10k"
          all_scope = all_scope.where("CAST(followers AS INT) >= ? AND CAST(followers AS INT) < ?", 5000, 10000)
        when "<20k"
          all_scope = all_scope.where("CAST(followers AS INT) >= ? AND CAST(followers AS INT) < ?", 10000, 20000)
        when "<100k"
          all_scope = all_scope.where("CAST(followers AS INT) >= ? AND CAST(followers AS INT) < ?", 200000, 100000)
        when ">100k"
          all_scope = all_scope.where("CAST(followers AS INT) >= ?", 100000)
      end
    end
    if params[:filter].has_key?(:ratio)
      case params[:filter][:ratio]
        when "<0"

        when "<1"

        when "<5"

        when "<10"

      end
    end
    if params[:filter].has_key?(:posts)
      case params[:filter][:posts]
        when "<100"
          all_scope = all_scope.where("CAST(number_of_posts AS INT) < ?", 100)
        when "<1k"
          all_scope = all_scope.where("CAST(number_of_posts AS INT) >= ? AND CAST(number_of_posts AS INT) < ?", 100, 1000)
        when ">1k"
          all_scope = all_scope.where("CAST(number_of_posts AS INT) >= ?", 1000)
      end
    end
    if params[:filter].has_key?(:avgeng)
      case params[:filter][:avgeng]
        when "<1%"
          all_scope = all_scope.where("CAST(avg_engagement AS INT) < ?", 1)
        when "<5%"
          all_scope = all_scope.where("CAST(avg_engagement AS INT) >= ? AND CAST(avg_engagement AS INT) < ?", 1, 5)
        when "<10%"
          all_scope = all_scope.where("CAST(avg_engagement AS INT) >= ? AND CAST(avg_engagement AS INT) < ?", 5, 10)
        when ">10%"
          all_scope = all_scope.where("CAST(avg_engagement AS INT) >= ?", 10)
      end
    end
    if params[:filter].has_key?(:winkl)
      case params[:filter][:avgeng]
        when "yes"
          all_scope = all_scope.where.not(:email=>nil)
        when "no"
          all_scope = all_scope.where(:email=>nil)
      end
    end
    @users = all_scope.all
    respond_to do |format|
      format.json { render :json => {:status => 200 , :users => @users}}
    end
  end
end
require 'test_helper'

class ProductsControllerTest < ActionController::TestCase
  test "should show the index page" do
    get :index
    assert_template :index
    assert_response :success
  end

  test "show should a specific product" do
    get :show, {id: products(:cat_suit).id}
    assert_response :success
    assert_template :show
    assert_equal assigns(:product), products(:cat_suit)
  end

  test "should return 404 for a product that doesn't exist" do
    product_id = 123448658
    assert_raises ActiveRecord::RecordNotFound do
      Product.find(product_id)
    end

  end

end

#   get :show, {id: movie_id}
#   assert_response :not_found
# end
#
# test "should get the new form" do
#   get :new
#   assert_template :new
#   assert_template partial: '_form'
#   assert_response :success
# end
#
# test "add a new movie to the database" do
#   post_params = {movie: {name: "The Sound of Music", director: "no idea"} }
#   assert_difference("Movie.count", 1) do
#     post :create, post_params
#   end
#
#   assert_redirected_to movies_path
# end
#
# test "a movie with no title can't change the database" do
#   post_params = { movie: {director: "someone", description: "empty values"}}
#
#   assert_no_difference("Movie.count") do
#     post :create, post_params
#   end
#
#   assert_template :new
# end
#
# test "a movie with no author can't change the database" do
#   post_params = { movie: {name: "something", description: "empty values"}}
#
#   assert_no_difference("Movie.count") do
#     post :create, post_params
#   end
#
#   assert_template :new
# end
#
# test "should get the edit form" do
#   movie_id = movies(:schindlers_list).id
#   get :edit, {id: movie_id}
#   assert_template :edit
#   assert_template partial: '_form'
#   assert_response :success
#
#   movie = assigns(:movie)
#   assert_not_nil movie
#   assert_equal movie.id, movie_id
# end
#
# test "update should change the movie" do
#   movie_id = movies(:galaxy_quest).id
#   patch :update, {id: movie_id, movie: {name: "Galaxy Quest (ick)"} }
#   assert_equal "Galaxy Quest (ick)", Movie.find(movie_id).name
#
#   assert_redirected_to movie_path
# end
#
# test "update should not allow nil name" do
#   movie_id = movies(:toy_story).id
#   patch :update, {id: movie_id, movie: {name: nil} }
#
#   assert_equal "Toy Story", Movie.find(movie_id).name
#
#   assert_template :edit
# end
#
# test "update should not allow nil director" do
#   movie_id = movies(:toy_story).id
#   patch :update, {id: movie_id, movie: {director: nil} }
#
#   assert_equal "Pixar", Movie.find(movie_id).director
#   assert_template :edit
# end
#
# test "destroy should delete the item" do
#   movie_id = movies(:galaxy_quest).id
#
#   assert_difference("Movie.count", -1) do
#     delete :destroy, {id: movie_id}
#   end
#
#   assert_raises ActiveRecord::RecordNotFound do
#     Movie.find(movie_id)
#   end
#
#   assert_redirected_to movies_path
# end
#
# test "upvote should increment rank by one" do
#   movie_id = movies(:schindlers_list).id
#
#   assert_difference("Movie.find(movie_id).rank", 1) do
#     patch :upvote, {id: movie_id}
#   end
#
#   assert_redirected_to movie_path(movie_id)
# end
#
# test "upvote should set nil ranks to one" do
#   movie_id = movies(:nil_rank).id
#
#   assert_difference("Movie.find(movie_id).rank", 1) do
#     patch :upvote, {id: movie_id}
#   end
# end

require 'test_helper'

class MerchantsControllerTest < ActionController::TestCase
  test "show the individual merchant page" do
    merchant_id = merchants(:hilarious).id

    get :show, {id: merchant_id}
    assert_response :success
    assert_template :show

    merchant = assigns(:merchant)
    assert_not_nil merchant
    assert_equal merchant.id, merchant_id
  end

  test "show a merchant that doesn't exist" do
    merchant_id = 334456777592
    assert_raises ActiveRecord::RecordNotFound do
      Merchant.find(merchant_id)
    end

    get :show, {id: merchant_id}
    assert_response :not_found
  end
end



#   test "should get the new form" do
#     get :new
#     assert_template :new
#     assert_template partial: '_form'
#     assert_response :success
#   end
#
#   test "add a new book to the database" do
#     post_params = {book: {title: "Anna Karenina", author: "Tolstoy?"} }
#     assert_difference("Book.count", 1) do
#       post :create, post_params
#     end
#
#     assert_redirected_to books_path
#   end
#
#   test "a book with no title can't change the database" do
#     post_params = { book: {author: "someone", description: "empty values"}}
#
#     assert_no_difference("Book.count") do
#       post :create, post_params
#     end
#
#     assert_template :new
#   end
#
#   test "a book with no author can't change the database" do
#     post_params = { book: {title: "something", description: "empty values"}}
#
#     assert_no_difference("Book.count") do
#       post :create, post_params
#     end
#
#     assert_template :new
#   end
#
#   test "should get the edit form" do
#     book_id = books(:lotr).id
#     get :edit, {id: book_id}
#     assert_template :edit
#     assert_template partial: '_form'
#     assert_response :success
#
#     book = assigns(:book)
#     assert_not_nil book
#     assert_equal book.id, book_id
#   end
#
#   test "update should change the book" do
#     book_id = books(:of_mice_and_men).id
#     patch :update, {id: book_id, book: {title: "Of Mice & Men"} }
#     assert_equal "Of Mice & Men", Book.find(book_id).title
#
#     assert_redirected_to book_path
#   end
#
#   test "update should not allow nil title" do
#     book_id = books(:lotr).id
#     patch :update, {id: book_id, book: {title: nil} }
#
#     assert_equal "Lord of the Rings", Book.find(book_id).title
#
#     assert_template :edit
#   end
#
#   test "update should not allow nil author" do
#     book_id = books(:gone_with_the_wind).id
#     patch :update, {id: book_id, book: {author: nil} }
#
#     assert_equal "Margaret Mitchell", Book.find(book_id).author
#     assert_template :edit
#   end
#
#   test "destroy should delete the item" do
#     book_id = books(:lotr).id
#
#     assert_difference("Book.count", -1) do
#       delete :destroy, {id: book_id}
#     end
#
#     assert_raises ActiveRecord::RecordNotFound do
#       Book.find(book_id)
#     end
#
#     assert_redirected_to books_path
#   end
#
#   test "upvote should increment rank by one" do
#     book_id = books(:lotr).id
#
#     assert_difference("Book.find(book_id).rank", 1) do
#       patch :upvote, {id: book_id}
#     end
#
#     assert_redirected_to book_path(book_id)
#   end
#
#   test "upvote should set nil ranks to one" do
#     book_id = books(:nil_rank).id
#
#     assert_difference("Book.find(book_id).rank", 1) do
#       patch :upvote, {id: book_id}
#     end
#   end
# end

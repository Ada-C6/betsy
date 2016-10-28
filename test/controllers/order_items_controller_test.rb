require 'test_helper'

class OrderItemsControllerTest < ActionController::TestCase
# CREATE!!!
  # test "should create a new OrderItem" do
  #   post_params = {product: products(:three), order: orders(:three_pending)}
  #   puts "#{post_params} >>>>>>>>>"
  #   post :create, post_params
  #   assert_response :redirect
  # end

  # test "creating a new order_item should change the total number" do
  #   assert_difference 'OrderItem.count', 1 do
  #     post_params = {order_item: {product_id: products(:three).id, order_id: orders(:three_pending).id, quantity: 1 }}
  #     post :create, post_params
  #   end
  # end


#
#   test "should create a new order when one doesn't already exist" do
#     # Create a new order with a new order_item
#     order_count = Order.all.count.to_i
#
#     needs_order = OrderItem.new(order_id:1, product_id:products(:two).id, quantity:1)
#     needs_order.save
#     new_order_count = Order.all.count
#     assert_equal order_count + 1, new_order_count
#   end
# #
# #   # TO FIX ERROR - end of input error
#   # test "should not create a new order if one already exists" do
#   #   # Order_Item with existing Order id should NOT create a new order.
#   #   new_order_count = Order.all.count
#   #   # Not sure why there is an error appearing on the next line, all parts are closed.
#   #   next_order = OrderItem.new(order_id:orders(one:).id, product_id:products(:two).id, quantity:1)
#   #   next_order.save
#   #   new_two = Order.all.count
#   #   assert_equal new_order_count, new_two
#   # end
# #
# #   #UPDATE - NOTE - A person should only be able to update the quatity because they shouldn't be able to change the order_id which is unqiue to them and if they want to change the product, they have to go to that product and put it in the order.
#
# # WHY IS THIS PASSING?!?!
#   test "a person should be able to update the quantity" do
#     order_item = OrderItem.find(order_items(:four).id)
#     order_item.quantity = 3
#     assert order_item.valid?
#   end
# # WHY IS THIS PASSING?!?!
#   test "a person should not add more items to their cart than are available" do
#     order_item = OrderItem.find(order_items(:four).id)
#     order_item.quantity = 7
#     assert_raise "You may not add a quantity to the order that is greater than the stock quantity."
#   end
# #
# # MAYBE THIS IS BETTER FOR ORDER? WHY ARE THEY PAYING FOR THE ITEM, NOT THE ORDER?
# #   test "an order_item can't be updated once the order is paid for" do
# #     order_item = OrderItem.find(order_items(:five).id)
# #     order_item.quantity = 2
# #     #Did we want to flash this?
# #     assert_not order_item.valid?
# #     assert_raise "You can't update an item that has already been paid for"
# #   end
# #
# #   #DESTROY
# #   test "should be able to call destroy" do
# #     delete :destroy, {id: items(:four).id}
# #     assert_response :redirect
# #   end
# #
# #   test "Deleting the order_item should remove it from the order" do
# #     assert_difference 'OrderItem.count', -1 do
# #       delete :destroy, {id: order_items(:four).id }
# #     end
# #   end
# #
# #   test "An order_item may not be deleted if the order has been paid for already " do
# #     order_item = OrderItem.find(order_items(:five).id)
# #     order_item.destroy
# #     #Did we want to flash this?
# #     assert_raise "You can't delete an item that has already been paid for"
# #   end
# #
# #   test "Deleteing the last order_item from the order will cancel the order" do
# #     assert_difference 'Order.count', -1 do
# #       delete :destroy, {id: order_items(:one).id }
# #     end
# #   end
# #
# #   #SHIPPED - Still need to think through the tests here. Right now, I see how this would change the order status but not sure all the implications of being shipped.
# #
# #   test "Shipping an item will update the shippment status" do
# #
# #   end
end
# #
# # # create update destroy shipped

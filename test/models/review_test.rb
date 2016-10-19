require 'test_helper'

class ReviewTest < ActiveSupport::TestCase
    # test "Can create an album with only a name provided" do
    #     assert albums(:valid_data).valid?
    # end
    #
    # test "Cannot create an album without a name" do
    #     album = Album.new
    #     assert_not album.valid?
    # end
    #
    # test "Create two albums with different titles" do
    #     album1 = albums(:valid_data)
    #     album2 = albums(:another_album)
    #     assert album2.valid?
    # end
    #
    # test "Cannot create two albums with the same title" do
    #     album1 = albums(:valid_data)
    #     album2 = Album.new(name: "Hello")
    #     assert_not(album2.valid?)
    # end
    #
    # test "Can create an album with a description 808 characters long" do
    #     album1 = albums(:valid_data)
    #     album2 = Album.new(name: "Hello")
    #     assert_not(album2.valid?)
    # end
    #
    # test "Cannot create an album with a description 810 characters long" do
    #     album_too_long = Album.new(name: "Too Long", description: "Here is a description of Book Title #12. It is a great book, worth reading and possibly adding to your personal library. You will not be disappointed. Check this book out from your local library so you can form your own opinion and upvote it here. klsjdf lkajsf jej faiosejf esj oiasejf lsdjf ;oasjef ojsdfkl jasefj sodf lsdfj oisejf SDJf lKSDJFo iejw lKDSFJ l;SEF SIefj l;KSZDf os;IF ;KLSDJf l;SJf;ijsefl j SDKL:fj es f;oSJDF l;kSDJFio SJefm LS:Dfj ;djf ;LKSDFj ;Ldjs ;ILEJSF l;SDJF SDIJfp oSfj ko;SDfopPSEfj PAEIOSfj lsidfj IOSEfj KL o;iSDfj efj DFIJS IOSEf oIAEJSf oDJS fo;IJSDF ;oIJDF ioSdfj dios;f jo;ISJf io;SDFJ ;SDKOFj ;Sdfj ;Jf :IOSDFJ ads o;iASdfj AKLSdj O:IADJ ;AOId oSDFJ S:OIDF :OSjm S:DFJ oiDJSf L:DFSZ O:IDSZJF ;oISJDf ;OSDFJ L:SDIFj L:SDKFJ O:ISDJf ;DFJS ;sIOJF ;oDFJS IO:SEfjDJSF ;SDFJ ioSfjUH")
    #     assert_not(album_too_long.valid?)
    # end
    #
    # test "Creating a new album will instantiate vote count at zero" do
    #     b = Album.new
    #     assert_equal(0, b.votes)
    # end
    #
    # test "Calling upvote_one increments votes by 1 correctly when starting with a new album" do
    #     b = Album.new
    #     b.upvote_one
    #     assert_equal(1, b.votes)
    # end
    #
    # test "Calling upvote_one increments votes by 1 correctly with any integer higher than zero" do
    #     b = Album.new
    #     b.votes = 5
    #     b.upvote_one
    #     assert_equal(6, b.votes)
    # end
    #
    # test "Cannot set votes to a negative integer" do
    #     b = Album.new(name: "yellow")
    #     b.votes = -4
    #     assert(b.invalid?)
    #     assert_includes(b.errors, :votes)
    # end
    #
    # test "Votes cannot be set to nil" do
    #     b = Album.new(name: "yellow")
    #     b.votes = nil
    #     assert(b.invalid?)
    #     assert_includes(b.errors, :votes)
    # end
end

# on rails console, object.new goes straight to the model, bypassing the controller completely.

# Reviews:
# Rating: integer default to 1
# Description: string
# Product_ID
# (belongs to a product)

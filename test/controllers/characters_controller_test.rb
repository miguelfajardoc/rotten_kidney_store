require "test_helper"

class CharactersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @character = characters(:one)
  end

  test "should get index" do
    get admin_characters_url
    assert_response :success
  end

  test "should get new" do
    get new_admin_character_url
    assert_response :success
  end

  test "should create character" do
    assert_difference("Character.count") do
      post admin_characters_url, params: { character: { klass: @character.klass, name: @character.name } }
    end

    assert_redirected_to admin_character_url(Character.last)
  end

  test "should show character" do
    get admin_character_url(@character)
    assert_response :success
  end

  test "should get edit" do
    get edit_admin_character_url(@character)
    assert_response :success
  end

  test "should update character" do
    patch admin_character_url(@character), params: { character: { klass: @character.klass, name: @character.name } }
    assert_redirected_to admin_character_url(@character)
  end

  test "should destroy character" do
    assert_difference("Character.count", -1) do
      delete admin_character_url(@character)
    end

    assert_redirected_to admin_characters_url
  end
end

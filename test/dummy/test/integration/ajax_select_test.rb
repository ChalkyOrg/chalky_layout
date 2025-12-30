# frozen_string_literal: true

require "test_helper"

class AjaxSelectTest < ActionDispatch::IntegrationTest
  test "ajax select page loads successfully" do
    get ajax_select_path
    assert_response :success
  end

  test "ajax select page contains form with chalky styling" do
    get ajax_select_path
    assert_select "form.chalky-form"
  end

  test "ajax select has tom-select controller with url value" do
    get ajax_select_path
    assert_select "select[data-controller='tom-select'][data-tom-select-url-value]"
  end

  test "ajax select has min-chars value attribute" do
    get ajax_select_path
    assert_select "select[data-tom-select-min-chars-value]"
  end

  test "search countries endpoint returns JSON" do
    get search_countries_path, params: { q: "fra" }
    assert_response :success
    assert_equal "application/json", response.media_type

    json = JSON.parse(response.body)
    assert_kind_of Array, json
  end

  test "search countries filters results by query" do
    get search_countries_path, params: { q: "france" }
    json = JSON.parse(response.body)

    assert json.any? { |c| c["text"] == "France" }
    assert json.none? { |c| c["text"] == "Allemagne" }
  end

  test "search countries returns empty array for no match" do
    get search_countries_path, params: { q: "zzzzzzz" }
    json = JSON.parse(response.body)

    assert_equal [], json
  end

  test "search countries returns correct JSON format" do
    get search_countries_path, params: { q: "esp" }
    json = JSON.parse(response.body)

    assert json.first.key?("value")
    assert json.first.key?("text")
    assert_equal "ES", json.first["value"]
    assert_equal "Espagne", json.first["text"]
  end

  test "search countries limits results to 50" do
    # Search with a common letter to get many results
    get search_countries_path, params: { q: "a" }
    json = JSON.parse(response.body)

    assert json.length <= 50
  end

  test "classic select still works without url value" do
    get ajax_select_path
    # Role select should not have url-value (classic mode)
    assert_select "select#form_demo_role[data-controller='tom-select']" do |elements|
      element = elements.first
      refute element["data-tom-select-url-value"], "Classic select should not have url-value"
    end
  end
end

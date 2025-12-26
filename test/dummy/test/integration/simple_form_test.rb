# frozen_string_literal: true

require "test_helper"

class SimpleFormTest < ActionDispatch::IntegrationTest
  test "simple form page loads successfully" do
    get simple_form_path
    assert_response :success
  end

  test "simple form page contains form with chalky styling" do
    get simple_form_path
    assert_select "form.chalky-form"
  end

  test "simple form page has text inputs with chalky classes" do
    get simple_form_path
    assert_select "input.chalky-input[type=text]"
    assert_select "input.chalky-input[type=email]"
  end

  test "simple form page has textarea with chalky classes" do
    get simple_form_path
    assert_select "textarea.chalky-input"
  end

  test "simple form page has radio buttons" do
    get simple_form_path
    assert_select ".chalky-radio-group"
    assert_select "input[type=radio]"
  end

  test "simple form page has checkboxes" do
    get simple_form_path
    assert_select ".chalky-checkbox-wrapper"
    assert_select "input[type=checkbox]"
  end

  test "simple form page has select dropdown with TomSelect controller" do
    get simple_form_path
    assert_select "select.chalky-select[data-controller='tom-select']"
  end

  test "simple form page has multiple select with TomSelect controller" do
    get simple_form_path
    assert_select "select.chalky-select[multiple][data-controller='tom-select']"
  end

  test "simple form page has file input" do
    get simple_form_path
    assert_select "input.chalky-file-input[type=file]"
  end

  test "simple form page has submit button with chalky styling" do
    get simple_form_path
    assert_select "input.chalky-button--primary[type=submit]"
  end

  test "simple form page shows labels" do
    get simple_form_path
    assert_select "label.chalky-label"
  end

  test "simple form page shows hints" do
    get simple_form_path
    assert_select "p.chalky-hint"
  end

  test "form submission with valid data redirects" do
    post create_form_demo_path, params: {
      form_demo: {
        name: "John Doe",
        email: "john@example.com",
        terms_accepted: "1"
      }
    }
    assert_redirected_to simple_form_path
    follow_redirect!
    assert_select ".chalky-alert--success"
  end

  test "form submission with invalid data shows errors" do
    post create_form_demo_path, params: {
      form_demo: {
        name: "",
        email: "invalid-email"
      }
    }
    assert_response :unprocessable_entity
    assert_select ".chalky-error"
  end
end

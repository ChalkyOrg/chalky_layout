# frozen_string_literal: true

require "spec_helper"

RSpec.describe Chalky::Pagination::Component do
  # Mock Pagy object for testing
  let(:mock_pagy) do
    double(
      "Pagy",
      page: 2,
      pages: 5,
      count: 100,
      from: 21,
      to: 40,
      prev: 1,
      next: 3,
      limit: 20
    )
  end

  let(:first_page_pagy) do
    double(
      "Pagy",
      page: 1,
      pages: 5,
      count: 100,
      from: 1,
      to: 20,
      prev: nil,
      next: 2,
      limit: 20
    )
  end

  let(:last_page_pagy) do
    double(
      "Pagy",
      page: 5,
      pages: 5,
      count: 100,
      from: 81,
      to: 100,
      prev: 4,
      next: nil,
      limit: 20
    )
  end

  let(:single_page_pagy) do
    double(
      "Pagy",
      page: 1,
      pages: 1,
      count: 10,
      from: 1,
      to: 10,
      prev: nil,
      next: nil,
      limit: 20
    )
  end

  let(:url_builder) { ->(page) { "/items?page=#{page}" } }

  describe "#render?" do
    it "returns true when there are multiple pages" do
      component = described_class.new(pagy: mock_pagy)
      expect(component.render?).to be true
    end

    it "returns false when there is only one page" do
      component = described_class.new(pagy: single_page_pagy)
      expect(component.render?).to be false
    end

    it "returns false when pagy is nil" do
      component = described_class.new(pagy: nil)
      expect(component.render?).to be false
    end
  end

  describe "#page_url" do
    it "uses the provided url_builder" do
      component = described_class.new(pagy: mock_pagy, url_builder: url_builder)
      expect(component.page_url(3)).to eq("/items?page=3")
    end

    it "uses default url_builder when not provided" do
      component = described_class.new(pagy: mock_pagy)
      expect(component.page_url(3)).to eq("?page=3")
    end
  end

  describe "#info_text" do
    it "returns formatted range info" do
      component = described_class.new(pagy: mock_pagy)
      expect(component.info_text).to eq("21-40 sur 100")
    end

    it "handles first page correctly" do
      component = described_class.new(pagy: first_page_pagy)
      expect(component.info_text).to eq("1-20 sur 100")
    end
  end

  describe "#page_info_text" do
    it "returns page X sur Y format" do
      component = described_class.new(pagy: mock_pagy)
      expect(component.page_info_text).to eq("Page 2 sur 5")
    end
  end

  describe "#pages_to_show" do
    context "when on the first page" do
      it "returns correct page series with gap" do
        component = described_class.new(pagy: first_page_pagy)
        pages = component.pages_to_show

        expect(pages.first).to eq(1)
        expect(pages.last).to eq(5)
        expect(pages).to include(:gap)
      end
    end

    context "when on a middle page" do
      it "returns pages around current page" do
        component = described_class.new(pagy: mock_pagy)
        pages = component.pages_to_show

        expect(pages).to include(1)
        expect(pages).to include(2)
        expect(pages).to include(5)
      end
    end

    context "when on the last page" do
      it "returns correct page series" do
        component = described_class.new(pagy: last_page_pagy)
        pages = component.pages_to_show

        expect(pages.first).to eq(1)
        expect(pages.last).to eq(5)
      end
    end

    context "with few pages" do
      let(:few_pages_pagy) do
        double(
          "Pagy",
          page: 2,
          pages: 3,
          count: 50,
          from: 21,
          to: 40,
          prev: 1,
          next: 3,
          limit: 20
        )
      end

      it "shows all pages without gaps" do
        component = described_class.new(pagy: few_pages_pagy)
        pages = component.pages_to_show

        expect(pages).to eq([1, 2, 3])
        expect(pages).not_to include(:gap)
      end
    end
  end
end

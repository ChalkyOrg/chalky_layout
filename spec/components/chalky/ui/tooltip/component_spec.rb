# frozen_string_literal: true

require "spec_helper"

RSpec.describe Chalky::Ui::Tooltip::Component do
  describe "#render?" do
    it "returns false when both are missing" do
      component = described_class.new

      expect(component.render?).to be false
    end
  end

  describe "#initialize" do
    it "uses default values" do
      component = described_class.new

      expect(component.position).to eq(:top)
      expect(component.variant).to eq(:dark)
      expect(component.delay).to eq(0)
    end

    it "accepts custom position" do
      component = described_class.new(position: :bottom)

      expect(component.position).to eq(:bottom)
    end

    it "accepts custom variant" do
      component = described_class.new(variant: :light)

      expect(component.variant).to eq(:light)
    end

    it "accepts custom delay" do
      component = described_class.new(delay: 500)

      expect(component.delay).to eq(500)
    end

    it "falls back to default for invalid position" do
      component = described_class.new(position: :invalid)

      expect(component.position).to eq(:top)
    end

    it "falls back to default for invalid variant" do
      component = described_class.new(variant: :invalid)

      expect(component.variant).to eq(:dark)
    end
  end

  describe "#tooltip_classes" do
    it "includes base classes" do
      component = described_class.new

      expect(component.tooltip_classes).to include("px-3")
      expect(component.tooltip_classes).to include("py-2")
      expect(component.tooltip_classes).to include("text-sm")
      expect(component.tooltip_classes).to include("rounded-lg")
      expect(component.tooltip_classes).to include("max-w-xs")
    end

    it "includes dark variant classes by default" do
      component = described_class.new

      expect(component.tooltip_classes).to include("bg-gray-900")
      expect(component.tooltip_classes).to include("text-white")
    end

    it "includes light variant classes when specified" do
      component = described_class.new(variant: :light)

      expect(component.tooltip_classes).to include("bg-white")
      expect(component.tooltip_classes).to include("text-gray-900")
      expect(component.tooltip_classes).to include("border")
    end
  end

  describe "#arrow_classes" do
    it "includes base classes" do
      component = described_class.new

      expect(component.arrow_classes).to include("absolute")
      expect(component.arrow_classes).to include("w-2")
      expect(component.arrow_classes).to include("h-2")
    end

    it "includes dark variant classes by default" do
      component = described_class.new

      expect(component.arrow_classes).to include("bg-gray-900")
    end

    it "includes light variant classes when specified" do
      component = described_class.new(variant: :light)

      expect(component.arrow_classes).to include("bg-white")
      expect(component.arrow_classes).to include("border")
    end
  end

  describe "#container_data" do
    it "includes tooltip controller" do
      component = described_class.new

      expect(component.container_data[:controller]).to eq("tooltip")
    end

    it "includes delay value" do
      component = described_class.new(delay: 300)

      expect(component.container_data[:tooltip_delay_value]).to eq(300)
    end

    it "includes position value" do
      component = described_class.new(position: :bottom)

      expect(component.container_data[:tooltip_position_value]).to eq("bottom")
    end
  end
end

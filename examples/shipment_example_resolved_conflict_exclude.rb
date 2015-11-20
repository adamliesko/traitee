require 'traitee'

transporter = Class.new do
  extend(Traitee::Trait)

  serves do
    def dimensions
      'small'
    end
  end
end

shipper = Class.new do
  extend(Traitee::Trait)

  attr_accessor :width, :height, :depth

  serves do
    def set_dimensions(w, h, d)
      @width = w
      @height = h
      @depth = d
    end

    def dimensions
      "#{@width} x #{@height} x #{@depth}"
    end
  end
end

shipment_class = Class.new do
  extend Traitee::Merger
  merge transporter.methods(except: :dimensions), shipper
end

shipment = shipment_class.new

p "shipment.set_dimensions 10, 20, 15 >>> #{ shipment.set_dimensions 10, 20, 15}"
p "shipment.dimensions                >>> #{shipment.dimensions}"


require 'traitee'

transporter = Class.new do
  extend(Traitee::Trait)

  serves do
    def compute_volume
      "1000"
    end
  end
end

shipper = Class.new do
  extend(Traitee::Trait)

  serves do
    def compute_volume
      "1000"
    end
  end
end

shipment_class = Class.new do
  extend Traitee::Merger
  merge transporter, shipper
end

shipment = shipment_class.new
shipment.compute_volume

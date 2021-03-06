require 'traitee'

transporter = Class.new do
  extend(Traitee::Trait)

  serves do
    def compute_volume(w, h, d)
      "Dimensions #{w} x #{h} x #{d} form a volume of: #{w*h*d*1000}"
    end
  end
end

shipper = Class.new do
  extend(Traitee::Trait)

  serves do
    def compute_volume(w, h, d)
      "Dimensions #{w} x #{h} x #{d} form a volume of: #{w*h*d}"
    end
  end
end

shipment_class = Class.new do
  extend Traitee::Merger
  merge transporter.methods(aliases: { compute_volume: :compute_transporting_volume }), shipper
end

shipment = shipment_class.new

p "shipment.compute_volume 10, 20, 15 >>> #{ shipment.compute_volume 10, 20, 15}"
p "shipment.compute_volume 10, 20, 15 >>> #{ shipment.compute_transporting_volume 10, 20, 15}"

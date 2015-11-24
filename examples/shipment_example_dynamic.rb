require 'traitee'

transporter = Class.new do
  extend(Traitee::Trait)

  serves do
    def shipping_address
      'Koniarkova 101, 831 07 Bratislava Slovakia'
    end

    def dimensions
    end

    def current_range
      kms_left = rand(600) + 10
      "You have around #{kms_left} kms left."
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
  merge transporter, shipper
end

shipment = shipment_class.new

p "shipment.shipping_address          >>>  #{shipment.shipping_address}"
p "shipment.current_range             >>> #{shipment.current_range}"
p "shipment.compute_volume 10, 20, 15 >>> #{ shipment.compute_volume 10, 20, 15}"
p "shipment.dimensions                >>> #{shipment.dimensions}"
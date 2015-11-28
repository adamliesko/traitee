require 'traitee'
class Transporter
  extend(Traitee::Trait)

  serves do
    def shipping_address
      'Koniarkova 101, 831 07 Bratislava Slovakia'
    end

    def current_range
      kms_left = rand(600) + 10
      "You have around #{kms_left} kms left."
    end
  end
end

class Shipper
  extend(Traitee::Trait)

  serves do
    def compute_volume(w, h, d)
      "Dimensions #{w} x #{h} x #{d} form a volume of: #{w*h*d}"
    end
  end
end

class Shipment
  extend Traitee::Merger
  merge Shipper, Transporter
end

shipment = Shipment.new

p "shipment.shipping_address          >>>  #{shipment.shipping_address}"
p "shipment.current_range             >>> #{shipment.current_range}"
p "shipment.compute_volume 10, 20, 15 >>> #{ shipment.compute_volume 10, 20, 15}"


class A
  include B
  include C
end
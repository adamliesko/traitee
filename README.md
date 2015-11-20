# Traitee

Mixins or so-called traits for Ruby (like module did not exist :)).

## How to use Traitee
```ruby
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

class Shipment
  extend Traitee::Merger
  merge Shipper, Transporter
end

shipment = Shipment.new
```
For more examples take a look into files inside examples folder.
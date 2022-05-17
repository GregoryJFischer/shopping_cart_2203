require 'rspec'
require './lib/product'
require './lib/shopping_cart'

describe Product do
  before :each do
    @cart = ShoppingCart.new("King Soopers", "30items")

    @product1 = Product.new(:paper, 'toilet paper', 3.70, '10')
    @product2 = Product.new(:meat, 'chicken', 4.50, '2')
    @product3 = Product.new(:paper, 'tissue paper', 1.25, '1')
    @product4 = Product.new(:produce, 'apples', 0.99, '20')
  end

  it 'Product exists' do
    expect(@cart).to be_a ShoppingCart
  end

  it 'Product has a name' do
    expect(@cart.name).to eq 'King Soopers'
  end

  it 'Product has a capacity' do
    expect(@cart.capacity).to eq 30
  end

  it 'Can add products' do
    expect(@cart.products).to eq []

    @cart.add_product(@product1)
    @cart.add_product(@product2)

    expect(@cart.products).to eq [
      @product1,
      @product2
    ]
  end

  it 'Has details' do
    expect(@cart.details).to eq({
      name: "King Soopers",
      capacity: 30
    })
  end

  it 'Can get total number of products' do
    @cart.add_product(@product1)
    @cart.add_product(@product2)
    @cart.add_product(@product3)

    expect(@cart.total_number_of_products).to eq 13
  end

  it 'can tell if a cart is full' do
    @cart.add_product(@product1)
    @cart.add_product(@product2)
    @cart.add_product(@product3)

    expect(@cart.is_full?).to be false

    @cart.add_product(@product4)

    expect(@cart.is_full?).to be true
  end

  it 'can give products by category' do
    @cart.add_product(@product1)
    @cart.add_product(@product2)
    @cart.add_product(@product3)
    @cart.add_product(@product4)

    expect(@cart.products_by_category(:paper)).to eq([
      @product1,
      @product3
    ])
  end

  it 'can generate a percentage occupied' do
    @cart.add_product(@product1)
    @cart.add_product(@product2)
    @cart.add_product(@product3)

    expect(@cart.percentage_occupied).to eq 43.33
  end

  it 'can sort products by quantity' do
    @cart.add_product(@product1)
    @cart.add_product(@product2)
    @cart.add_product(@product3)
    @cart.add_product(@product4)

    expect(@cart.sorted_products_by_quantity).to eq([
      @product3,
      @product2,
      @product1,
      @product4
    ])
  end

  it 'can breakdown products into their categories' do
    @cart.add_product(@product1)
    @cart.add_product(@product2)
    @cart.add_product(@product3)
    @cart.add_product(@product4)

    expect(@cart.product_breakdown).to eq({
      meat: [@product2],
      paper: [@product1, @product3],
      produce: [@product4]
    })
  end

  it 'can find the product with the highest price' do
    @cart.add_product(@product1)
    @cart.add_product(@product2)
    @cart.add_product(@product3)
    @cart.add_product(@product4)

    expect(@cart.max_price).to eq @product1
  end
end
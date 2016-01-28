class Page
  include Virtus.model
  extend SeoHelper
  attribute :title
  attribute :description
  attribute :keywords
  attribute :og_title
  attribute :og_description
  attribute :og_image
  attribute :og_url
  attribute :og_type, String, default: :website

  def meta_tags
    to_hash.slice(:title, :description, :keywords)
  end

  def self.build(source)
    new title: meta_title(source), description: meta_description(source), keywords: meta_keywords(source)
  end

  def self.build_from_product(product)
    new title: meta_title(product),
        description: meta_description(product),
        keywords: meta_keywords(product),
        og_image: product.image.try(:url),
        og_url: Rails.application.routes.url_helpers.vendor_product_url(product)
  end

  def self.build_from_vendor(vendor)
    new title: vendor.name, description: vendor.description
  end

  def self.build_for_cart(vendor)
    new title: "#{I18n.vt('pages.titles.cart')} - #{vendor.name}"
  end

  def self.build_for_order(vendor)
    new title: "#{I18n.vt('pages.titles.order')} - #{vendor.name}"
  end

  def self.build_for_payment(vendor)
    new title: "#{I18n.vt('pages.titles.payment')} - #{vendor.name}"
  end

  def self.build_for_failure_payment(vendor)
    new title: "#{I18n.vt('pages.titles.payment_success')} - #{vendor.name}"
  end

  def self.build_for_success_payment(vendor)
    new title: "#{I18n.vt('pages.titles.payment_error')} - #{vendor.name}"
  end
end

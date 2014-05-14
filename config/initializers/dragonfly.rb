require "dragonfly/rails/images"

Dragonfly::App[:images].configure do |c|
  c.url_handler.configure do |u|
    u.protect_from_dos_attacks = true
    u.secret = "the dog is is the way of my chair yet again"
  end
end
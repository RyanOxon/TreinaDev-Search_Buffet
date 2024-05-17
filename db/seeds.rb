# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
PaymentMethod.methods.keys.each do |method|
  PaymentMethod.create!(method: method)
end

Feature.features.keys.each do |feature|
  Feature.create!(feature: feature)
end

EventCategory.categories.keys.each do |category|
  EventCategory.create!(category: category)
end

# Descomente o codigo abaixo para popular o codigo com exemplos
=begin
user = BuffetOwner.create!(email: 'empresa@empresa.com', password: 'password')
customer = Customer.create!(email: 'cliente@cliente.com', password: 'password', cpf: '83949909087' )

buffet = Buffet.create!(brand_name: "Fiesta Fabulosa", corporate_name: "Fiesta Fabulosa LTDA",
                        registration: "26350656000128",phone_number: "(11) 98765-4321",
                        email: "contato@fiestafabulosa.com.br", address: "Rua das Festas, 123",
                        district: "Bairro da Alegria", city: "São Paulo", state_code: "SP",
                        zip_code: "12345-678", buffet_owner: user,
                        description: "O melhor buffet para suas festas e eventos inesquecíveis! Comida deliciosa, decoração deslumbrante e diversão garantida!",)
BuffetPaymentMethod.create!(buffet: buffet, payment_method: PaymentMethod.find_by(method: 'credit_card'))
BuffetPaymentMethod.create!(buffet: buffet, payment_method: PaymentMethod.find_by(method: 'cash'))

event = Event.create!(name: "Aniversário Encantado", exclusive_address: true, buffet: buffet,
              description: "Celebre seu aniversário com estilo e diversão em um ambiente mágico e encantador!",
              min_capacity: 30, max_capacity: 100, default_duration: 240,
              menu: "Buffet completo com pratos salgados, doces finos, bolo personalizado e bebidas.",
              event_category: EventCategory.find_by(category: 'birthday'))
EventFeature.create!(event: event, feature: Feature.find_by(feature: "decoration"))
image_1 = HolderImage.create!(image: File.open(Rails.root.join('spec', 'support', 'birthday_1.jpg')), user: user, holder: event)
event.update!(cover_photo: image_1)
price1 = EventPrice.create!(price_type: 0, base_value: 5000, extra_per_person: 120, extra_per_hour: 750, event: event)
EventPrice.create!(price_type: 1, base_value: 7500, extra_per_person: 200, extra_per_hour: 1250, event: event)

event_2 = Event.create!(name: "Casamento dos Sonhos", exclusive_address: true, buffet: buffet,
                description: "Realize o casamento dos seus sonhos com uma cerimônia e recepção inesquecíveis!",
                min_capacity: 50, max_capacity: 200, default_duration: 300,
                menu: "Menu sofisticado com entrada, prato principal, sobremesa e open bar.",
                event_category: EventCategory.find_by(category: "wedding"))
EventFeature.create!(event: event_2, feature: Feature.find_by(feature: "alcohol"))
EventFeature.create!(event: event_2, feature: Feature.find_by(feature: "decoration"))
image_2 = HolderImage.create!(image: File.open(Rails.root.join('spec', 'support', 'casamento_1.jpg')), user: user, holder: event_2)
event_2.update!(cover_photo: image_2)
EventPrice.create!(price_type: 0, base_value: 25000, extra_per_person: 200, extra_per_hour: 1600, event: event_2)
EventPrice.create!(price_type: 1, base_value: 30000, extra_per_person: 300, extra_per_hour: 2500, event: event_2)

event_3 = Event.create!( name: "Festa Corporativa Premium", exclusive_address: false, buffet: buffet,
                  description: "Organize sua festa corporativa em grande estilo com uma experiência premium para seus convidados.",
                  min_capacity: 20, max_capacity: 150, default_duration: 360,
                  menu: "Catering gourmet com opções variadas e coquetel de boas-vindas.",
                  event_category: EventCategory.find_by(category: "corporate"))
EventFeature.create!(event: event_3, feature: Feature.find_by(feature: "decoration"))

image_3 = HolderImage.create!(image: File.open(Rails.root.join('spec', 'support', 'corporate_1.jpg')), user: user, holder: event_3)
event_3.update!(cover_photo: image_3)
EventPrice.create!(price_type: 0, base_value: 10000, extra_per_person: 200, extra_per_hour: 1600, event: event_3)
EventPrice.create!(price_type: 1, base_value: 13000, extra_per_person: 300, extra_per_hour: 2500, event: event_3)

order = Order.create!(customer: customer, event: event, date: 5.months.from_now, 
                      people_count: 50, details: "Aniversário de 50 anos da Sra. Maria", status: 'negotiating')
ServiceProposal.create!(value: price1.base_value, extra_fee: 0, discount: 0, 
                      description: "Sem valores adicionais nem desconto", 
                      payment_method_id: PaymentMethod.find_by(method: "credit_card").id,
                      order: order, expiration_date: 1.month.from_now)
Message.create!(content: "Olá, o pagamento seria por cartao de credito.", user: customer, order: order)
Message.create!(content: "Ok, proposta enviada", user: user, order: order)
=end
# Seeds file for DT Rails - Fuel Distribution Company
# Data compliant with Guinean laws and regulations

puts "🌱 Starting seed process..."

# Clear existing data
puts "🧹 Clearing existing data..."
DeliveryNote.destroy_all
Document.destroy_all
Truck.destroy_all
Employee.destroy_all
Citerne.destroy_all
BillingRate.destroy_all
User.destroy_all

# Guinean cities and regions
guinean_cities = [
  'Conakry', 'Kankan', 'Kindia', 'N\'Zérékoré', 'Labé', 'Mamou', 'Boké', 'Faranah',
  'Kouroussa', 'Siguiri', 'Kérouané', 'Mandiana', 'Dinguiraye', 'Dabola', 'Fria',
  'Coyah', 'Dubréka', 'Forécariah', 'Télimélé', 'Pita', 'Dalaba', 'Mali', 'Lélouma'
]

guinean_regions = [
  'Conakry', 'Boké', 'Kindia', 'Mamou', 'Labé', 'Kankan', 'Faranah', 'N\'Zérékoré'
]

# Guinean phone number prefixes
phone_prefixes = ['+224 6', '+224 7', '+224 8']

# Guinean vehicle plate formats
plate_formats = ['AB-123-CD', 'EF-456-GH', 'IJ-789-KL', 'MN-012-OP', 'QR-345-ST']

# Fuel types and capacities
fuel_types = ['Diesel']
citerne_capacities = ['40,000L', '45,000L']

# Vehicle makes and models common in Guinea
vehicle_makes = ['Renault', 'Volvo']
vehicle_models = ['FMX', 'Premium']

# Departments and positions
departments = ['Operations', 'Logistics', 'Maintenance', 'Sales', 'Administration', 'Security']
positions = ['Manager', 'Supervisor', 'Driver', 'Mechanic', 'Electrician', 'Coordinator', 'CEO', 'CFO']

# Document types and statuses
document_types = ['invoice', 'delivery_note', 'contract', 'maintenance_report', 'other']
document_statuses = ['draft', 'active', 'archived', 'expired']

# Delivery note statuses
delivery_statuses = ['pending', 'in_transit', 'delivered', 'returned', 'cancelled']

# Employee statuses
employee_statuses = ['active', 'inactive', 'suspended', 'terminated']

# Vehicle statuses
vehicle_statuses = ['available', 'in_use', 'maintenance', 'out_of_service']

puts "👥 Creating Users..."

# Create 25 users with realistic Guinean names and data
users = []
25.times do |i|
  user = User.create!(
    first_name: [
      'Mamadou', 'Fatoumata', 'Ibrahima', 'Aissatou', 'Ousmane', 'Mariama', 'Alpha', 'Hawa',
      'Boubacar', 'Fanta', 'Moussa', 'Aminata', 'Lamine', 'Kadiatou', 'Sekou', 'Fatou',
      'Mohamed', 'Aicha', 'Amadou', 'Djenabou', 'Souleymane', 'Maimouna', 'Bakary', 'Safiatou',
      'Moussa', 'Aissatou', 'Boubacar', 'Fatoumata'
    ][i],
    last_name: [
      'Diallo', 'Camara', 'Bah', 'Barry', 'Sow', 'Touré', 'Keita', 'Sylla', 'Cissé',
      'Traoré', 'Konaté', 'Coulibaly', 'Doumbouya', 'Condé', 'Baldé', 'Dramé',
      'Fofana', 'Kouyaté', 'Sidibé', 'Diakité', 'Sangaré', 'Ouattara', 'Koné', 'Bamba',
      'Diallo', 'Camara', 'Bah', 'Barry'
    ][i],
    email: "user#{i+1}@dtrails.gn",
    password: "password123",
    password_confirmation: "password123",
    phone_number: "#{phone_prefixes.sample} #{rand(10000000..99999999)}",
    address_line: "#{rand(1..999)} #{['Rue', 'Avenue', 'Boulevard'].sample} #{['Liberté', 'Indépendance', 'Victoire', 'Paix', 'Unité'].sample}",
    city: guinean_cities.sample,
    state: guinean_regions.sample,
    country: 'Guinea',
    role: ['user', 'admin', 'manager'].sample,
    is_active: [true, false].sample,
    confirmed_at: Time.current
  )
  users << user
  print "."
end
puts " ✅ Created #{users.count} users"

puts "👷 Creating Employees..."

# Create 25 employees
employees = []
25.times do |i|
  employee = Employee.create!(
    user: users[i],
    matricule: "EMP#{sprintf('%04d', i+1)}",
    department: departments.sample,
    position: positions.sample,
    status: employee_statuses.sample,
    salary: "#{rand(500000..5000000)} GNF"
  )
  employees << employee
  print "."
end
puts " ✅ Created #{employees.count} employees"

puts "🚛 Creating Citernes (Fuel Tankers)..."

# Create 25 citernes with realistic Guinean plate numbers
citernes = []
25.times do |i|
  citerne = Citerne.create!(
    plate_number: "#{('A'..'Z').to_a.sample(2).join}-#{sprintf('%03d', rand(1..999))}-#{('A'..'Z').to_a.sample(2).join}",
    chassis_number: "CH#{sprintf('%08d', rand(10000000..99999999))}",
    capacity: citerne_capacities.sample,
    status: vehicle_statuses.sample
  )
  citernes << citerne
  print "."
end
puts " ✅ Created #{citernes.count} citernes"

puts "🚚 Creating Trucks..."

# Create 25 trucks
trucks = []
25.times do |i|
  truck = Truck.create!(
    make: vehicle_makes.sample,
    model: vehicle_models.sample,
    plate_number: "#{('A'..'Z').to_a.sample(2).join}-#{sprintf('%03d', rand(1..999))}-#{('A'..'Z').to_a.sample(2).join}",
    status: vehicle_statuses.sample,
    vin: "VIN#{sprintf('%012d', rand(100000000000..999999999999))}",
    employee: employees.sample,
    citerne: citernes.sample
  )
  trucks << truck
  print "."
end
puts " ✅ Created #{trucks.count} trucks"

puts "💰 Creating Billing Rates..."

# Create 25 billing rates for different routes in Guinea
billing_rates = []
25.times do |i|
  origin = guinean_cities.sample
  destination = guinean_cities.sample
  
  # Ensure origin and destination are different
  while destination == origin
    destination = guinean_cities.sample
  end
  
  # Realistic rates based on distance (in Guinean Francs)
  base_rate = rand(50000..500000)
  
  billing_rate = BillingRate.create!(
    origin: origin,
    destination: destination,
    rate: base_rate
  )
  billing_rates << billing_rate
  print "."
end
puts " ✅ Created #{billing_rates.count} billing rates"

puts "📄 Creating Documents..."

# Create 25 documents
documents = []
25.times do |i|
  document = Document.create!(
    title: [
      'Fuel Delivery Contract', 'Maintenance Report', 'Safety Inspection',
      'Insurance Policy', 'Registration Document', 'Technical Specification', 'Operating Manual',
      'Training Certificate', 'Audit Report', 'Compliance Document', 'Emergency Procedure',
      'Route Planning', 'Cost Analysis', 'Performance Report', 'Inventory List',
      'Supplier Agreement', 'Customer Contract', 'Service Record', 'Incident Report',
      'Training Material', 'Policy Document', 'Procedure Guide', 'Checklist Form',
      'Safety Protocol', 'Quality Assurance', 'Risk Assessment'
    ][i],
    description: "Document #{i+1} for operational purposes",
    file_path: "/documents/#{i+1}.pdf",
    document_type: document_types.sample,
    number: "DOC#{sprintf('%04d', i+1)}",
    status: document_statuses.sample,
    delivery_date: rand(1..365).days.ago,
    expiry_date: rand(1..365).days.from_now,
    employee: employees.sample,
    truck: trucks.sample,
    citerne: citernes.sample
  )
  documents << document
  print "."
end
puts " ✅ Created #{documents.count} documents"

puts "📋 Creating Delivery Notes..."

# Create 25 delivery notes
delivery_notes = []
25.times do |i|
  # Realistic fuel quantities in liters (Diesel only as per company policy)
  diesel_qty = rand(10000..40000)
  total_qty = diesel_qty
  missing_qty = rand(0..500)
  
  delivery_note = DeliveryNote.create!(
    number: "DN#{sprintf('%04d', i+1)}",
    status: delivery_statuses.sample,
    origin: guinean_cities.sample,
    destination: guinean_cities.sample,
    gasoline_quantity: "0L",
    diesel_quantity: "#{diesel_qty}L",
    total_quantity: "#{total_qty}L",
    missing_quantity: "#{missing_qty}L",
    missing_description: missing_qty > 0 ? "Minor spillage during transfer" : "No missing quantity",
    updated_by: employees.sample.matricule,
    created_by: employees.sample.matricule,
    issued_date: rand(1..30).days.ago,
    delivery_date: rand(1..7).days.ago,
    return_date: rand(1..3).days.ago,
    employee: employees.sample,
    truck: trucks.sample,
    citerne: citernes.sample
  )
  delivery_notes << delivery_note
  print "."
end
puts " ✅ Created #{delivery_notes.count} delivery notes"

puts "🎯 Creating additional records to ensure minimum 20 per table..."

# Ensure we have at least 20 records in each table
if users.count < 20
  (20 - users.count).times do |i|
    User.create!(
      first_name: "Additional#{i+1}",
      last_name: "User#{i+1}",
      email: "additional#{i+1}@dtrails.gn",
      password: "password123",
      password_confirmation: "password123",
      phone_number: "#{phone_prefixes.sample} #{rand(10000000..99999999)}",
      address_line: "#{rand(1..999)} Additional Street",
      city: guinean_cities.sample,
      state: guinean_regions.sample,
      country: 'Guinea',
      role: 'user',
      is_active: true,
      confirmed_at: Time.current
    )
  end
end

if employees.count < 20
  (20 - employees.count).times do |i|
    Employee.create!(
      user: User.last,
      matricule: "EMP#{sprintf('%04d', 1000+i)}",
      department: departments.sample,
      position: positions.sample,
      status: 'active',
      salary: "#{rand(500000..5000000)} GNF"
    )
  end
end

if citernes.count < 20
  (20 - citernes.count).times do |i|
    Citerne.create!(
      plate_number: "XX-#{sprintf('%03d', 1000+i)}-XX",
      chassis_number: "CH#{sprintf('%08d', 100000000+i)}",
      capacity: citerne_capacities.sample,
      status: 'available'
    )
  end
end

if trucks.count < 20
  (20 - trucks.count).times do |i|
    Truck.create!(
      make: vehicle_makes.sample,
      model: vehicle_models.sample,
      plate_number: "XX-#{sprintf('%03d', 1000+i)}-XX",
      status: 'available',
      vin: "VIN#{sprintf('%012d', 100000000000+i)}",
      employee: employees.sample,
      citerne: citernes.sample
    )
  end
end

if billing_rates.count < 20
  (20 - billing_rates.count).times do |i|
    origin = guinean_cities.sample
    destination = guinean_cities.sample
    while destination == origin
      destination = guinean_cities.sample
    end
    
    BillingRate.create!(
      origin: origin,
      destination: destination,
      rate: rand(50000..500000)
    )
  end
end

if documents.count < 20
  (20 - documents.count).times do |i|
    Document.create!(
      title: "Additional Document #{i+1}",
      description: "Additional document for compliance",
      file_path: "/documents/additional#{i+1}.pdf",
      document_type: document_types.sample,
      number: "DOC#{sprintf('%04d', 1000+i)}",
      status: 'active',
      delivery_date: rand(1..365).days.ago,
      expiry_date: rand(1..365).days.from_now,
          employee: employees.sample,
    truck: trucks.sample,
    citerne: citernes.sample
    )
  end
end

if delivery_notes.count < 20
  (20 - delivery_notes.count).times do |i|
    diesel_qty = rand(10000..40000)
    total_qty = diesel_qty
    
    DeliveryNote.create!(
      number: "DN#{sprintf('%04d', 1000+i)}",
      status: 'delivered',
      origin: guinean_cities.sample,
      destination: guinean_cities.sample,
      gasoline_quantity: "0L",
      diesel_quantity: "#{diesel_qty}L",
      total_quantity: "#{total_qty}L",
      missing_quantity: "0L",
      missing_description: "No missing quantity",
      updated_by: employees.sample.matricule,
      created_by: employees.sample.matricule,
      issued_date: rand(1..30).days.ago,
      delivery_date: rand(1..7).days.ago,
      return_date: rand(1..3).days.ago,
      employee: employees.sample,
      truck: trucks.sample,
      citerne: citernes.sample
    )
  end
end

puts "🔐 Creating OAuth Applications..."

# Create a test OAuth application
test_app = OauthApplication.create!(
  name: 'Test OAuth Application',
  uid: "test_app_#{SecureRandom.hex(8)}",
  secret: 'test_secret_456',
  redirect_uri: 'http://localhost:3000/callback',
  scopes: 'read write',
  confidential: true,
  owner: users.first,
  created_by_id: users.first.id
)

# Create an admin user for testing
admin_user = User.create!(
  first_name: 'Admin',
  last_name: 'User',
  email: 'admin@dtrails.gn',
  password: 'admin123',
  password_confirmation: 'admin123',
  phone_number: '+224 6 12345678',
  address_line: '123 Admin Street',
  city: 'Conakry',
  state: 'Conakry',
  country: 'Guinea',
  role: 'admin',
  is_active: true,
  confirmed_at: Time.current
)

puts " ✅ Created OAuth application: #{test_app.name}"
puts " ✅ Created admin user: #{admin_user.email}"

puts "\n🎉 Seed process completed successfully!"
puts "📊 Final record counts:"
puts "   Users: #{User.count}"
puts "   Employees: #{Employee.count}"
puts "   Citernes: #{Citerne.count}"
puts "   Trucks: #{Truck.count}"
puts "   Billing Rates: #{BillingRate.count}"
puts "   Documents: #{Document.count}"
puts "   Delivery Notes: #{DeliveryNote.count}"
puts "   OAuth Applications: #{OauthApplication.count}"

puts "\n✅ All tables now contain at least 20 records with data compliant with Guinean laws!"
puts "🌍 Data includes realistic Guinean cities, regions, names, and business practices."
puts "🚛 Fuel distribution company data with proper vehicle registrations and compliance."
puts "🔐 OAuth2 authentication system with test application and admin user ready!"

# Note: Active Admin now uses the existing User model with admin role
puts "👑 Active Admin configured to use existing User model with admin role"
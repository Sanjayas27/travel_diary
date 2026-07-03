-- ════════════════════════════════════════════════════
-- Travel Diary Holidays — Supabase CMS Setup
-- Run this entire file in Supabase → SQL Editor
-- ════════════════════════════════════════════════════

-- 1. TOUR PACKAGES (Destinations section)
CREATE TABLE IF NOT EXISTS packages (
  id bigint primary key generated always as identity,
  name text not null,
  destination text,
  duration text,
  price text,
  tag text,
  emoji text default '🌍',
  gradient text default 'linear-gradient(135deg,#1a3060,#0d2a55)',
  active boolean default true,
  sort_order int default 0,
  image_url text,
  created_at timestamptz default now()
);

-- 2. SERVICES
CREATE TABLE IF NOT EXISTS services (
  id bigint primary key generated always as identity,
  name text not null,
  icon text default '✈️',
  description text,
  active boolean default true,
  sort_order int default 0
);

-- 3. WHY CHOOSE US
CREATE TABLE IF NOT EXISTS why_us (
  id bigint primary key generated always as identity,
  icon text default '🏆',
  title text not null,
  description text,
  active boolean default true,
  sort_order int default 0
);

-- 4. TESTIMONIALS
CREATE TABLE IF NOT EXISTS testimonials (
  id bigint primary key generated always as identity,
  customer_name text not null,
  location text,
  review text not null,
  stars int default 5,
  active boolean default true,
  sort_order int default 0,
  created_at timestamptz default now()
);

-- 5. SITE SETTINGS (contact info, hero text, etc)
CREATE TABLE IF NOT EXISTS site_settings (
  key text primary key,
  value text
);

-- ── Enable RLS on all tables ──
ALTER TABLE packages ENABLE ROW LEVEL SECURITY;
ALTER TABLE services ENABLE ROW LEVEL SECURITY;
ALTER TABLE why_us ENABLE ROW LEVEL SECURITY;
ALTER TABLE testimonials ENABLE ROW LEVEL SECURITY;
ALTER TABLE site_settings ENABLE ROW LEVEL SECURITY;

-- ── Allow anon (public) full access ──
CREATE POLICY "allow_all_packages"      ON packages      FOR ALL TO anon USING (true) WITH CHECK (true);
CREATE POLICY "allow_all_services"      ON services      FOR ALL TO anon USING (true) WITH CHECK (true);
CREATE POLICY "allow_all_why_us"        ON why_us        FOR ALL TO anon USING (true) WITH CHECK (true);
CREATE POLICY "allow_all_testimonials"  ON testimonials  FOR ALL TO anon USING (true) WITH CHECK (true);
CREATE POLICY "allow_all_site_settings" ON site_settings FOR ALL TO anon USING (true) WITH CHECK (true);

-- ════════════════════════════════════════════════════
-- SEED DATA — default content (matches the website)
-- ════════════════════════════════════════════════════

INSERT INTO packages (name, destination, emoji, gradient, price, tag, sort_order) VALUES
('Dubai Getaway',       'Dubai, UAE',       '🕌', 'linear-gradient(135deg,#1a3060,#0d2a55)', 'From ₹18,500/person', 'HOT',       1),
('Maldives Retreat',    'Maldives',         '🏖️', 'linear-gradient(135deg,#003f5c,#0077b6)', 'From ₹32,000/person', '',          2),
('Thailand Adventure',  'Thailand',         '🗺️', 'linear-gradient(135deg,#1b4332,#40916c)', 'From ₹22,000/person', 'VISA FREE', 3),
('Europe Tour',         'Europe',           '🏰', 'linear-gradient(135deg,#2d1b69,#6a0572)', 'From ₹95,000/person', '',          4),
('Kerala Special',      'Kerala, India',    '🌺', 'linear-gradient(135deg,#145a32,#1e8449)', 'From ₹8,500/person',  'LOCAL',     5),
('Singapore Trip',      'Singapore',        '🎑', 'linear-gradient(135deg,#1a237e,#283593)', 'From ₹28,000/person', '',          6);

INSERT INTO services (name, icon, description, sort_order) VALUES
('Flight Tickets',          '✈️', 'Domestic & international flights at the best rates. All airlines covered.',              1),
('Train & Bus Tickets',     '🚂', 'Quick bookings across India. Save time, travel comfortably.',                            2),
('Holiday Packages',        '🌴', 'Curated packages for families, couples & groups. All-inclusive & customizable.',         3),
('Passport Assistance',     '🛂', 'New passport, renewal, and Tatkal — we guide you every step of the way.',               4),
('Visa Assistance',         '📋', 'Tourist, business & work visas for all countries. Fast processing.',                    5),
('Certificate Attestation', '📜', 'HRD, MEA, Embassy attestation for education & employment abroad.',                      6),
('Certified Translation',   '🌐', 'Accurate certified document translation for visa and immigration.',                     7),
('Travel Insurance',        '🛡️', 'Medical, cancellation, and baggage protection for all trips.',                          8),
('Hotel Booking',           '🏨', 'Best deals worldwide — budget to luxury, we find the perfect stay.',                    9),
('Emigration Clearance',    '🖊️', 'ECR passport holders — we handle your emigration clearance smoothly.',                 10);

INSERT INTO why_us (icon, title, description, sort_order) VALUES
('🏆', 'Trusted & Certified',    'Government-approved travel agency serving Kerala for over a decade.', 1),
('💰', 'Best Price Guarantee',   'We compare fares across all airlines to get you the lowest prices always.', 2),
('🕐', '24/7 Support',           'Always reachable via phone or WhatsApp for any travel emergency.', 3),
('⚡', 'Fast Processing',        'Visa, attestation, and ticket confirmations processed faster than anywhere.', 4);

INSERT INTO testimonials (customer_name, location, review, stars, sort_order) VALUES
('Arun Mathew',   'Cochin, Kerala',   'Got my Dubai visa in just 3 days! The team was extremely helpful and made the whole process smooth. Highly recommend.', 5, 1),
('Priya & Rahul', 'Thrissur, Kerala', 'Booked a Thailand package for our honeymoon — everything was perfectly arranged. Hotels, flights, sightseeing. Zero stress!', 5, 2),
('Sibin George',  'Angamaly, Kerala', 'Certificate attestation for Saudi Arabia done flawlessly. Very professional, totally transparent pricing. Will always come back!', 5, 3);

INSERT INTO site_settings (key, value) VALUES
('phone1',    '+91 89434 44771'),
('phone2',    '+91 89434 44772'),
('whatsapp',  '918943444771'),
('email',     'traveldiaryholidays@gmail.com'),
('addr1',     'KPBs Prime Trade Center'),
('addr2',     'Angamaly, Cochin, Kerala'),
('hours',     'Monday – Saturday, 9:00 AM – 7:00 PM'),
('instagram', '@TravelDiaryHolidays'),
('tagline',   'Your Dream Trip<br>Starts Right Here'),
('hero_desc', 'Flight tickets, hotel bookings, visa assistance, holiday packages — everything handled with care by Travel Diary Holidays.');


-- If packages table already exists, add image_url column:
ALTER TABLE packages ADD COLUMN IF NOT EXISTS image_url text;

-- Add image_url to services and why_us (run if tables already exist)
ALTER TABLE services ADD COLUMN IF NOT EXISTS image_url text;
ALTER TABLE why_us ADD COLUMN IF NOT EXISTS image_url text;

-- Seed default social media settings
INSERT INTO site_settings (key, value) VALUES
('social_facebook',  'https://facebook.com/traveldiaryholidays'),
('social_instagram', 'https://instagram.com/traveldiaryholidays'),
('social_twitter',   'https://x.com/traveldiaryholidays'),
('social_linkedin',  'https://linkedin.com/company/traveldiaryholidays')
ON CONFLICT (key) DO NOTHING;

-- ════════════════════════════════
-- OFFERS TABLE
-- ════════════════════════════════
CREATE TABLE IF NOT EXISTS offers (
  id bigint primary key generated always as identity,
  title text not null,
  discount text,
  price text,
  package text,
  valid_until text,
  description text,
  active boolean default true,
  sort_order int default 0,
  created_at timestamptz default now()
);
ALTER TABLE offers ENABLE ROW LEVEL SECURITY;
CREATE POLICY "allow_all_offers" ON offers FOR ALL TO anon USING (true) WITH CHECK (true);

-- ════════════════════════════════
-- POSTERS TABLE
-- ════════════════════════════════
CREATE TABLE IF NOT EXISTS posters (
  id bigint primary key generated always as identity,
  title text,
  description text,
  image_url text not null,
  active boolean default true,
  sort_order int default 0,
  created_at timestamptz default now()
);
ALTER TABLE posters ENABLE ROW LEVEL SECURITY;
CREATE POLICY "allow_all_posters" ON posters FOR ALL TO anon USING (true) WITH CHECK (true);

-- Add recovery email field to admin_users
ALTER TABLE admin_users ADD COLUMN IF NOT EXISTS recovery_email text;
ALTER TABLE admin_users ADD COLUMN IF NOT EXISTS reset_code text;
ALTER TABLE admin_users ADD COLUMN IF NOT EXISTS reset_code_expires timestamptz;

-- Add Google Maps embed link to site_settings
INSERT INTO site_settings (key, value) VALUES
('google_maps_embed', '')
ON CONFLICT (key) DO NOTHING;

-- Office email used for enquiry notifications AND password recovery
INSERT INTO site_settings (key, value) VALUES
('office_email', 'reservation@traveldiaryholidays.com')
ON CONFLICT (key) DO UPDATE SET value = EXCLUDED.value;

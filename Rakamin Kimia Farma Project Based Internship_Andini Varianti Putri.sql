-- Agregasi Tabel
CREATE TABLE `rakamin-kf-analytics-464908.Kimia_Farma.kf_analisa` AS
SELECT
  ft.transaction_id,
  ft.date,
  ft.branch_id,
  kc.branch_name,
  kc.kota,
  kc.provinsi,
  kc.rating AS rating_cabang,
  ft.customer_name,
  ft.product_id,
  p.product_name,
  ft.price AS actual_price,
  ft.discount_percentage,

  -- Persentase gross laba
  CASE
    WHEN ft.price <= 50000 THEN 0.10
    WHEN ft.price > 50000 AND ft.price <= 100000 THEN 0.15
    WHEN ft.price > 100000 AND ft.price <= 300000 THEN 0.20
    WHEN ft.price > 300000 AND ft.price <= 500000 THEN 0.25
    ELSE 0.30
  END AS persentase_gross_laba,

  -- Nett sales
  ft.price * (1 - ft.discount_percentage) AS nett_sales,

  -- Nett profit
  (ft.price * (1 - ft.discount_percentage)) *
  CASE
    WHEN ft.price <= 50000 THEN 0.10
    WHEN ft.price > 50000 AND ft.price <= 100000 THEN 0.15
    WHEN ft.price > 100000 AND ft.price <= 300000 THEN 0.20
    WHEN ft.price > 300000 AND ft.price <= 500000 THEN 0.25
    ELSE 0.30
  END AS nett_profit,

  ft.rating AS rating_transaksi

FROM `rakamin-kf-analytics-464908.Kimia_Farma.kf_final_transaction` ft
JOIN `rakamin-kf-analytics-464908.Kimia_Farma.kf_product` p
  ON ft.product_id = p.product_id
JOIN `rakamin-kf-analytics-464908.Kimia_Farma.kf_kantor_cabang` kc
  ON ft.branch_id = kc.branch_id;

-- Kolom Baru Untuk Geo Map
CREATE OR REPLACE TABLE `rakamin-kf-analytics-464908.Kimia_Farma.kf_analisa` AS
SELECT
  *,
  
  CASE provinsi
    WHEN 'Jawa Barat' THEN 'West Java'
    WHEN 'Jawa Tengah' THEN 'Central Java'
    WHEN 'Jawa Timur' THEN 'East Java'
    WHEN 'DI Yogyakarta' THEN 'Yogyakarta'
    WHEN 'DKI Jakarta' THEN 'Jakarta'
    WHEN 'Banten' THEN 'Banten'
    WHEN 'Aceh' THEN 'Aceh'
    WHEN 'Bali' THEN 'Bali'
    WHEN 'Bangka Belitung' THEN 'Bangka Belitung Islands'
    WHEN 'Riau' THEN 'Riau'
    WHEN 'Sumatera Utara' THEN 'North Sumatra'
    WHEN 'Sumatera Barat' THEN 'West Sumatra'
    WHEN 'Sumatera Selatan' THEN 'South Sumatra'
    WHEN 'Lampung' THEN 'Lampung'
    WHEN 'Kepulauan Riau' THEN 'Riau Islands'
    WHEN 'Kalimantan Barat' THEN 'West Kalimantan'
    WHEN 'Kalimantan Timur' THEN 'East Kalimantan'
    WHEN 'Kalimantan Tengah' THEN 'Central Kalimantan'
    WHEN 'Kalimantan Selatan' THEN 'South Kalimantan'
    WHEN 'Kalimantan Utara' THEN 'North Kalimantan'
    WHEN 'Sulawesi Selatan' THEN 'South Sulawesi'
    WHEN 'Sulawesi Tenggara' THEN 'Southeast Sulawesi'
    WHEN 'Sulawesi Tengah' THEN 'Central Sulawesi'
    WHEN 'Sulawesi Utara' THEN 'North Sulawesi'
    WHEN 'Gorontalo' THEN 'Gorontalo'
    WHEN 'Maluku' THEN 'Maluku'
    WHEN 'Maluku Utara' THEN 'North Maluku'
    WHEN 'Papua' THEN 'Papua'
    WHEN 'Papua Barat' THEN 'West Papua'
    WHEN 'Nusa Tenggara Timur' THEN 'East Nusa Tenggara'
    WHEN 'Nusa Tenggara Barat' THEN 'West Nusa Tenggara'
    WHEN 'Jambi' THEN 'Jambi'
    ELSE provinsi
  END AS province_for_map
FROM `rakamin-kf-analytics-464908.Kimia_Farma.kf_analisa`;
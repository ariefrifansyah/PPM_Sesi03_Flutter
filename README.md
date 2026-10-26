# NusaBookstore 📚

Aplikasi e-commerce toko buku sederhana yang dikembangkan menggunakan **Flutter** dengan menerapkan arsitektur **State Management menggunakan Provider**. Proyek ini dibuat untuk memenuhi Tugas 4 Pemrograman Perangkat Mobile.

## 👤 Identitas Mahasiswa
- **Nama:** Mohamad Arief Rifansyah
- **NIM:** 20240040194
- **Program Studi:** S1 Teknik Informatika (TI24B)
- **Universitas:** Universitas Nusa Putra

---

## ✨ Fitur & Implementasi Utama
1. **Katalog Buku:** Menampilkan daftar buku lengkap dengan informasi judul, penulis, harga, dan tombol "Tambah ke Keranjang".
2. **State Management (Provider):** 
   - `CartProvider`: Mengelola daftar belanja, kuantitas item, perhitungan total harga secara reaktif menggunakan `notifyListeners()`, serta fungsi *checkout*.
   - `ThemeProvider`: Mengatur perpindahan *Light Mode* dan *Dark Mode* secara instan di seluruh layar aplikasi.
3. **MultiProvider:** Didaftarkan pada *root* aplikasi (`main.dart`) untuk membungkus `CartProvider` dan `ThemeProvider`.
4. **Format Rupiah:** Perhitungan total harga belanja disajikan secara presisi dalam format mata uang Rupiah (`intl`).
5. **Interaktif:** Dilengkapi dengan *Badge* keranjang dinamis di *AppBar*, tombol penambahan/pengurangan kuantitas (`+`/`-`), fitur hapus item, serta *SnackBar* saat *checkout* berhasil mengosongkan keranjang.

---

## 📂 Struktur Folder Proyek
```text
lib/
├── models/
│   └── book.dart
├── providers/
│   ├── cart_provider.dart
│   └── theme_provider.dart
├── screens/
│   ├── catalog_screen.dart
│   └── cart_screen.dart
|
└── main.dart



# گزارش بررسی مشکلات پروژه (2026-04-23)

## وضعیت کلی
- `cargo check` بدون خطا پاس شد.
- `cargo test` بدون خطا پاس شد (67 تست).
- `cargo clippy --all-targets --all-features -- -D warnings` شکست خورد و 24+ مورد قابل‌بهبود/خطا گزارش کرد.

## مشکلات مهم شناسایی‌شده

### 1) دروازه کیفیت Clippy شکسته است (High)
با توجه به اجرای Clippy در حالت `-D warnings`، پروژه در CI سخت‌گیرانه fail می‌شود.
نمونه ایرادها:
- `needless_arbitrary_self_type` در `src/domain_fronter.rs`.
- `io_other_error` در `src/proxy_server.rs`.
- `manual_div_ceil` در `src/scan_ips.rs`.
- `match_like_matches_macro` در `src/scan_sni.rs`.
- `manual_pattern_char_comparison` در `src/update_check.rs`.

### 2) پیچیدگی تایپ بالا در چند تابع (Medium)
Clippy روی `type_complexity` هشدار/خطا داده؛ نگهداشت و خوانایی را پایین می‌آورد.
- `split_response` در `src/domain_fronter.rs`.
- `parse_request_head` در `src/proxy_server.rs`.

### 3) الگوهای قدیمی یا کم‌کیفیت در ساخت Error (Medium)
موارد متعدد `std::io::Error::new(ErrorKind::Other, ...)` دیده می‌شود که بهتر است با `std::io::Error::other(...)` جایگزین شود.
- نمونه‌ها در `src/proxy_server.rs`.

### 4) بهبودهای کوچک ولی پرتعداد در کد (Low/Medium)
مواردی مثل:
- `manual_contains` در `src/cert_installer.rs`.
- `bool_assert_comparison` در `src/config.rs`.
- `manual_is_multiple_of` در `src/proxy_server.rs`.
- `print_literal` در `src/scan_ips.rs` و `src/scan_sni.rs`.
- `unnecessary_cast` در `src/rlimit.rs`.

### 5) آیتم امنیتی/عملیاتی: وجود keystore ریلیز در ریپو (Risk)
فایل `android/app/release.jks` داخل مخزن وجود دارد. نگه‌داری keystore امضای release در ریپو عمومی/مشترک ریسک امنیتی جدی دارد مگر اینکه عمداً test-only باشد و چرخش کلید و کنترل دسترسی انجام شده باشد.

## پیشنهاد برنامه اصلاح
1. **Phase 1 (سریع):** رفع خطاهای Clippy مکانیکی (مثل `io_other_error`, `manual_div_ceil`, `manual_contains`, `print_literal`, `bool_assert_comparison`).
2. **Phase 2 (ساختاری):** کاهش `type_complexity` با type alias و شکستن توابع بزرگ.
3. **Phase 3 (امنیتی):** خارج‌کردن keystore از ریپو، چرخش کلید release، و استفاده از Secret Manager در CI.
4. افزودن Job اجباری CI برای:
   - `cargo fmt --check`
   - `cargo clippy --all-targets --all-features -- -D warnings`
   - `cargo test`

## فرمان‌های اجراشده
```bash
cargo check
cargo test
cargo clippy --all-targets --all-features -- -D warnings
rg -n "TODO|FIXME|unwrap\(|expect\(" src android tunnel-node | head -n 200
```

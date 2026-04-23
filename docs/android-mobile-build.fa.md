# بیلد APK اندروید فقط با موبایل (بدون دسترسی به کامپیوتر)

## روش پیشنهادی (بدون نصب ابزار روی گوشی): GitHub Actions

این ریپو workflow بیلد اندروید دارد که با push شدن tag اجرا می‌شود.

1. با موبایل وارد GitHub repo شوید.
2. از بخش **Releases** یک Release جدید بسازید.
3. یک tag جدید مثل `v1.2.8-mobile.1` بزنید و Publish کنید.
4. با ایجاد tag، workflow `release` اجرا می‌شود.
5. بعد از سبز شدن jobها، از بخش **Actions** یا **Release Assets** فایل APK را دانلود کنید.

## چرا این روش جواب می‌دهد؟

- workflow روی tagهای `v*` اجرا می‌شود.
- job `android` داخل CI خودش `./gradlew :app:assembleRelease` را اجرا می‌کند.
- خروجی در CI به نام `mhrv-rs-android-universal-v<version>.apk` کپی/آپلود می‌شود.

## اگر نمی‌خواهی صبر کنی (همین الان نصب)

در همین ریپو یک APK آماده وجود دارد:

- `releases/mhrv-rs-android-universal-v1.1.0.apk`

می‌توانی مستقیم از GitHub دانلود و نصب کنی.

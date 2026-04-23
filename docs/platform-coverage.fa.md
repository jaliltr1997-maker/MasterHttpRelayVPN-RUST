# پوشش سیستم‌عامل‌ها در ریپو

بر اساس README اصلی و جدول `releases/README.md`، این ریپو این پلتفرم‌ها را پوشش می‌دهد:

| سیستم‌عامل / پلتفرم | معماری‌های پوشش‌داده‌شده | نوع خروجی |
|---|---|---|
| Linux | `x86_64`, `aarch64` | باینری CLI + (برای amd64) UI |
| Linux (musl) برای روتر/سبک | `x86_64`, `aarch64` | باینری استاتیک CLI + اسکریپت init |
| Raspberry Pi / Raspbian | `armhf` (ARMv7 hardfloat) | CLI |
| macOS | Intel (`amd64`), Apple Silicon (`arm64`) | CLI + UI + App bundle |
| Windows | `x86_64` | CLI + UI |
| Android 7.0+ | APK یونیورسال: `arm64-v8a`, `armeabi-v7a`, `x86_64`, `x86` | اپ اندروید + هسته Rust |

## نکته

`README.md` پوشش کلی را Linux/macOS/Windows/Android اعلام می‌کند و `releases/README.md` جزئیات دقیق‌تر (از جمله Raspbian و buildهای musl برای OpenWRT/Alpine) را نشان می‌دهد.

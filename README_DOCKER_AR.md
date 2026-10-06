# Istakoza POS v14 — Docker

النسخة دي مجهزة لتشغيل Istakoza POS داخل Docker مع حفظ قاعدة البيانات والنسخ الاحتياطية خارج الـ container.

## التشغيل السريع على Windows

1. ثبّت Docker Desktop وشغّله.
2. فك ضغط الملف.
3. شغّل `start.bat`.
4. افتح: `http://localhost:8080`
5. بيانات الدخول الأولية الموجودة في البرنامج: `admin / admin` — غيّر كلمة المرور بعد أول دخول.

## التشغيل من Terminal

```bash
docker compose up -d --build
```

ثم افتح:

```text
http://localhost:8080
```

إيقاف النظام:

```bash
docker compose down
```

متابعة السجلات:

```bash
docker compose logs -f --tail=200
```

## مكان البيانات

كل البيانات الدائمة موجودة داخل مجلد:

```text
./data
```

ومن ضمنها:

```text
data/pos_data.db
data/backups/
```

لا تحذف مجلد `data` إذا كنت تريد الاحتفاظ بالمبيعات والإعدادات.

## تغيير البورت

عدّل `.env`:

```text
ISTAKOZA_HOST_PORT=8080
```

مثلاً لو عايز 8090:

```text
ISTAKOZA_HOST_PORT=8090
```

بعدها نفّذ:

```bash
docker compose up -d
```

وافتح `http://localhost:8090`.

## أوضاع البرنامج

من `.env` غيّر:

```text
ISTAKOZA_MODE=full
```

القيم المدعومة:

- `full` — النظام كامل.
- `cashier` — الكاشير/الصالة/استلام الفرع.
- `backoffice` — المخازن والأوردرات والدليفري بدون نافذة الكاشير.

بعد تغيير الوضع:

```bash
docker compose up -d
```

## الوصول من أجهزة الشبكة

استخدم IP الجهاز الذي يشغّل Docker، مثلاً:

```text
http://192.168.1.50:8080
```

قد تحتاج للسماح للبورت 8080 في Firewall الخاص بالجهاز.

## الطابعة الشبكية

البرنامج يطبع مباشرة على عنوان IP للطابعة وبورتها (غالباً 9100). الـ container يستطيع إجراء اتصالات صادرة إلى شبكة الجهاز في أغلب إعدادات Docker Desktop/Linux. تأكد أن عنوان الطابعة يمكن الوصول إليه من جهاز Docker وأن Firewall/VLAN لا يمنع الاتصال.

## تحديث التطبيق بدون فقد البيانات

استبدل ملفات التطبيق ثم شغّل:

```bash
docker compose up -d --build
```

قاعدة البيانات تظل في `./data` ولا تُحذف بإعادة بناء الـ image.

## نسخة احتياطية يدوية سريعة

أوقف الـ container مؤقتاً ثم انسخ مجلد `data` بالكامل لمكان آمن:

```bash
docker compose stop
```

بعد النسخ:

```bash
docker compose start
```

البرنامج نفسه يحتوي أيضاً على نظام النسخ الاحتياطي SQLite الخاص به داخل `data/backups`.

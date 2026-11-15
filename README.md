# Body Health Calculator (Flutter)

แอปพลิเคชันคำนวณดัชนีมวลกาย (BMI) และอัตราการเผาผลาญพื้นฐาน (BMR)

## ความต้องการ
- Flutter SDK ที่มาพร้อม Dart 3.6.0 ขึ้นไป
- Google Chrome
- Visual Studio Code พร้อมส่วนขยาย Flutter และ Dart (หากใช้ VS Code)

## ติดตั้งแพ็กเกจ
เปิด Terminal ที่โฟลเดอร์โปรเจกต์ แล้วรัน:

```bash
flutter clean
flutter pub get
```

## รันบน Chrome

```bash
flutter devices
flutter run -d chrome
```

หรือเลือกอุปกรณ์ **Chrome** ใน VS Code แล้วกด `F5` ได้

## Build เป็นเว็บ

```bash
flutter build web
```

ไฟล์เว็บที่ Build แล้วจะอยู่ใน `build/web`

## โครงสร้างไฟล์หลัก
- `lib/main.dart` จุดเริ่มต้นของแอป
- `lib/splash_screen_ui.dart` หน้าเริ่มต้น
- `lib/home_ui.dart` หน้าหลักและเมนูนำทาง
- `lib/bmi_ui.dart` หน้าคำนวณ BMI
- `lib/bmr_ui.dart` หน้าคำนวณ BMR
- `lib/about_ui.dart` หน้าเกี่ยวกับแอป
- `assets/` รูปภาพและไอคอน

> หมายเหตุ: หาก Chrome เปิดหน้าเว็บว่าง ให้หยุดการรันเดิม แล้วรัน `flutter clean`, `flutter pub get` และ `flutter run -d chrome` ใหม่อีกครั้ง ตรวจสอบข้อผิดพลาดใน Debug Console ด้วย

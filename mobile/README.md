# SCL Mobile (Flutter)

O'quv boshqaruv tizimining mobil ilovasi. 3 ta role: **Super Admin**, **O'qituvchi**, **Talaba**.

## Demo kirish

| Role        | Login    | Parol |
|------------|----------|--------|
| O'qituvchi | teacher1 | 123    |
| Super Admin| admin    | admin  |
| Talaba     | student1 | 123    |

## Loyiha joylashuvi

Loyiha `scl` loyihasi ichida: `scl/mobile/`

## Ishga tushirish

```bash
cd mobile
flutter pub get
flutter run
```

(Simulyator yoki qurilma tanlang: iOS, Android, macOS.)

Agar Flutter cache xatosi chiqsa:
```bash
sudo chown -R $(whoami) /Users/azizbekrahimjonov/development/flutter/bin/cache
```

## Hozirgi imkoniyatlar (Teacher UI)

- **Fanlar** — ro'yxat, "Salom, o'qituvchi! — Karimov Sardor", Chiqish.
- **Fan bo'yicha** — 3 ta tab: Materiallar, Testlar, Vazifalar.
- **Material qo'shish** — Sarlavha, Tavsif, Fayl nomi, Saqlash.
- **Test qo'shish** — Test nomi, Savollar (A/B/C/D variant, to'g'ri javob tanlash), Savol qo'shish, Saqlash.
- **Vazifa qo'shish** — Sarlavha, Tavsif, Saqlash.

Barcha ma'lumotlar **demo** rejimida xotirada (keyinroq API ga ulanadi).

## Keyingi qadamlar

1. **Student UI** — talaba ekranlari (fanlar, materiallar, testlar, vazifalar).
2. **Super Admin UI** — o'qituvchilar va fanlar qo'shish, fanlarga o'qituvchi biriktirish.
3. **API** — backend ga ulash, haqiqiy login va ma'lumotlar.

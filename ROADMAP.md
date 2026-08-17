# AirSnap — Roadmap

Basado en análisis de competencia (jul 2026): SelfiShop Camera (10M+, 3.6★, UI saturada),
Bluetooth Camera Shutter, Remote Shutter Camera, Open Camera. Patrón claro del mercado:
**las apps queridas hacen una cosa bien con UI mínima; la queja nº1 de la categoría es
"el botón hace zoom en vez de disparar"; lo premium siempre es timelapse/intervalos,
nunca el disparo básico.**

Principio de diseño: todo en una pantalla (viewfinder + estado BT siempre visible),
settings tras un solo icono, cero menús anidados.

## v1.1 — Robustez del disparo (mata las reviews de 1★)
- [ ] **Wizard de mapeo de keycode**: "pulsa el botón de tu mando ahora" → detecta y mapea.
      Con override manual. Es la causa nº1 de 1★ en toda la categoría (zoom vs disparo).
- [x] **Ampliar keycodes escuchados a auriculares "media button"** — YA IMPLEMENTADO por el
      Mac: `MediaButtonReceiver.kt` intercepta `ACTION_MEDIA_BUTTON` (AVRCP: play/pause/next/prev)
      además de `KEYCODE_VOLUME_UP/DOWN` (HID). Cubre la inmensa mayoría de auriculares BT.
      Pendiente: probar en dispositivo real (Realme 14 Pro+).
- [ ] **Sonido/vibración de confirmación** de disparo (el usuario está lejos del móvil).
- [ ] **Perfiles por dispositivo BT**: recuerda el mapeo de cada mando/auricular.

## v1.2 — Esenciales de foto (trivial con camerawesome)
- [ ] **Timer 0/3/10s** tras pulsación, con cuenta atrás visual + sonora.
- [ ] **Burst**: N fotos por pulsación.
- [ ] **Grid + nivel de horizonte**.
- [ ] **Filtros**: ya existen en camerawesome — carrusel oculto por defecto, no engordar UI.

## v1.3 — Vídeo (diferenciador: nadie lo hace bien)
- [ ] **Grabar/parar vídeo con el botón BT** (doble pulsación o pulsación larga).
- [ ] **Multi-acción por patrones de pulsación**: 1 clic = foto, 2 = vídeo, largo = cambiar cámara.

## v2.0 — Premium (IAP única 2-4€, nunca ads sobre el viewfinder, nunca suscripción)
- [ ] **Intervalómetro / timelapse** — LA feature de pago de la categoría.
- [ ] **Modo pantalla apagada** (disparar con pantalla bloqueada, foreground service).
- [ ] **Quick Settings tile / widget**.

## v3.0 — Bandas y relojes (investigado ago 2026, ver detalle abajo)
- [ ] **Comprobar gratis si ya funciona**: si el usuario activa "cámara remota" en la app
      oficial de su band (Mi Fitness/Zepp/Huawei Health), varios modelos emulan tecla de
      Volumen — el AccessibilityService actual podría ya captarlo sin tocar código. Probar
      primero con un Mi Band/Amazfit real antes de invertir en nada más.
- [ ] **App nativa Wear OS** (Kotlin, módulo aparte — no hay bridge Flutter maduro): escucha
      un botón/tile en el reloj y reenvía el evento al móvil vía Data Layer API
      (`WearableListenerService` + `MessageClient`). Ruta oficial con precedentes reales
      funcionando. Cubre Wear OS genérico y Galaxy Watch4+ (Samsung discontinuó Tizen).
      Esfuerzo medio, sin experiencia previa esperar días de curva de aprendizaje, no semanas.
- [ ] **(Opcional, solo si falla el punto 1) Soporte BLE directo Mi Band/Amazfit vía
      Gadgetbystem/Freeyourgadget** — protocolo bien documentado para Band 4-8 y varios
      Amazfit, pero cifrado/autenticado en modelos nuevos → mantenimiento continuo, se rompe
      con firmwares. Solo bandas populares, soporte "best effort".
- [ ] ~~Fitbit~~ y ~~Galaxy Watch Tizen legado~~ — **descartado**: SDK de terceros retirado
      (Fitbit) o plataforma discontinuada (Tizen), sin cooperación del fabricante no hay vía.

## Reglas aprendidas del mercado
1. Gratis sin trampas todo lo básico (disparo, timer, burst).
2. La UI nunca crece: cada feature nueva se esconde hasta que se necesita.
3. Nunca romper compatibilidad de mandos baratos de 2€ — es el caso de uso estrella.

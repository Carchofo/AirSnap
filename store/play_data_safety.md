# Play Console — Cuestionario "Seguridad de los datos" (respuestas exactas)

App: AirSnap 1.0.10 — no tiene analytics, no tiene red salvo el check de updates a la API pública de GitHub, no tiene cuentas ni SDKs de terceros que recojan datos.

## Sección 1 — Recogida y compartición de datos
- **¿Tu app recoge o comparte alguno de los tipos de datos de usuario obligatorios?** → **No**

Con esa respuesta el resto del cuestionario se salta y la ficha mostrará "No se recogen datos".

## Justificación (por si Google pregunta en revisión)
- Las fotos se guardan **solo en el dispositivo** (MediaStore local). Nunca salen del móvil.
- El AccessibilityService solo lee **keycodes de periféricos Bluetooth** (volumen/media) para disparar la cámara. No lee contenido de pantalla, no registra texto, no almacena ni transmite nada.
- `update_checker.dart` hace GET anónimo a `api.github.com/repos/Carchofo/AirSnap/releases/latest` — sin identificadores de usuario.
- Sin analytics, sin crash reporting, sin publicidad, sin login.

## Sección aparte — Declaración de AccessibilityService (obligatoria)
Play Console pedirá justificar el uso de la API de accesibilidad (formulario "App content" → "Accessibility API"):

> AirSnap uses the AccessibilityService API solely to detect physical button presses (volume/media keycodes) from Bluetooth peripherals such as headphones, smartbands and selfie remotes, so users can trigger the camera shutter remotely. This is the core functionality of the app. The service does not read screen content, does not collect, store or share any personal or sensitive data, and processes key events only while the user has explicitly enabled the feature. A prominent in-app disclosure is shown before requesting the permission (see lib/screens/accessibility_screen.dart).

## Otros pasos pendientes en Play Console
1. **Categoría**: Fotografía
2. **Política de privacidad**: https://github.com/Carchofo/AirSnap/blob/main/PRIVACY.md
   ⚠️ Google a veces rechaza URLs de github.com/blob — si da error, usar la versión raw o GitHub Pages.
3. Cuando todo esté verde → **Enviar a revisión**

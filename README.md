# Automatización de Pruebas – App Android de Mercado Libre

Conjunto de pruebas para la aplicación **Mercado Libre** en Android utilizando  
**Ruby**, **Appium**, **Cucumber**.  
El flujo abre la app, realiza una búsqueda de producto, aplica varios filtros y extrae
nombre y precio de los cinco primeros resultados.  
Cada ejecución genera capturas de pantalla y reportes (HTML, JSON y Allure) con sello de fecha /hora.

---

## ✨ Funcionalidades principales
| Área | Descripción |
|------|-------------|
| **Driver móvil** | Appium + UiAutomator2  |
| **BDD** | Escenarios Gherkin en `features/*.feature`; steps en `features/step_definitions` |
| **Page-Objects / Localizadores** | Definidos en `pages/` (`elements/EML.rb`, `BasePages.rb`) |
| **Reportes** | • Consola `pretty`<br>• `cucumber.html` / `cucumber.json`<br>• Resultados Allure en `allure-results/`<br>• Cada corrida se archiva en `target/reports_<AAAAMMDD_HHMMSS>/` |
| **Evidencias** | Captura automática en cada paso/escenario fallido (`screenshots/`) |
| **Config sencilla** | Capacidades centralizadas en `features/support/env.rb` |

---

## 🛠️ Requisitos previos

| Herramienta | Versión probada |
|-------------|-----------------|
| Ruby | 3.2.x |
| Bundler | 2.5.x |
| Node + Appium Server | Node ≥ 18, Appium ≥ 2.0 |
| Android SDK / adb | Build-Tools ≥ 34.0.0 |
| Java JDK | 17 (solo para herramientas Android) |

> **Dispositivo**  
> Conecta un teléfono Android.  
> Asegúrate de tener la **Depuración USB** activada.

---

## 🚀 Instalación

```
bash
# 1. Clonar repositorio
git clone https://github.com/Thevage97/Automatizaci-n-de-Pruebas-App-Android-de-Mercado-Libre.git

# 2. En la carpeta raiz del proyecto ejecutar
bundle install

# 3. Instalar driver de Appium (solo la primera vez)
appium driver install uiautomator2

```

## 📂 Estructura del proyecto

```
.
├─ features
│  ├─ ML.feature                # Escenarios Gherkin
│  └─ support
│     └─ env.rb                 # Hooks, caps, rotación de reportes
├─ pages
│  ├─ BasePages.rb              # Ayudas comunes (scroll, etc.)
│  └─ elements
│     └─ EML.rb                 # Localizadores [:estrategia, 'selector']
└─ target/                      # Reportes + resultados Allure
```

## ▶️ Ejecución de pruebas

Iniciar el servicio de Appium
```
appium
```
Ejecutar el comando en consola
```
 bundle exec cucumber
```

## 📝 Personalización rápida

| Quieres | Edita |
|-------------|-----------------|
| Cambiar dispositivo / paquete | Método caps en env.rb |
| Añadir localizadores nuevos	 | pages/elements/EML.rb |
| Crear nuevos pasos | features/step_definitions/ |
| Agregar escenarios | features/*.feature |

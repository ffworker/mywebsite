
# Dokumentation: Prozess zur Erstellung und Konfiguration neuer Maschinen mit SSO

## 1. Zielsetzung
Dieses Dokument beschreibt den standardisierten Prozess zur Erstellung, Konfiguration und Synchronisation neuer Maschinen, um eine reibungslose Anmeldung mit vollständigem Single-Sign-On (SSO) zu gewährleisten. Zudem werden Herausforderungen sowie mögliche Optimierungen beschrieben.

---

## 2. Prozessbeschreibung

### Schritt 1: Maschinen bereitstellen
- Auf dem Server **GH-CON11** werden neue Maschinen erstellt.
- Der Bereitstellungsprozess wird gestartet, und die Maschinen wechseln in den Status **„Verfügbar“**.

### Schritt 2: Neustart der Maschinen
- Sobald die Maschinen den Status **„Verfügbar“** erreicht haben, ist ein **Neustart** der Maschinen erforderlich.

### Schritt 3: Synchronisation mit Active Directory
- Nachdem die Maschinen wieder den Status **„Verfügbar“** erreicht haben, wird auf dem Server **GH-DC01** ein **AD-SyncCycle** durchgeführt.
- Das PowerShell-Skript für den AD-SyncCycle befindet sich auf dem Desktop von **GH-DC01**.

### Schritt 4: Überprüfung in Microsoft Entra
- In der Microsoft Entra-Umgebung (**entra.microsoft.com**) wird unter **Geräte -> Alle Geräte** ein Filter gesetzt:
  - **Filter: „NLV“ oder „LS-Admin“**
- Warten, bis alle neuen Maschinen den Status **„Ausstehend“** anzeigen.

### Schritt 5: Abschluss und SSO-Validierung
Es gibt zwei Möglichkeiten, den Prozess abzuschließen:

1. **Option A: Erneuter Neustart der Maschinen**
   - Die Maschinen erneut neustarten.
   - Der Benutzer kann sich nun direkt mit vollständigem SSO anmelden.
   
2. **Option B: Benutzeranmeldung**
   - Der Benutzer meldet sich an der neuen Maschine an und wartet 2–3 Minuten (bis ProCall gestartet ist).
   - Anschließend meldet sich der Benutzer ab und wieder an.
   - Die nächste Anmeldung erfolgt mit vollständigem SSO.

---

## 3. Herausforderungen

### Neues Image oder Entfernen der Maschinen
- Wird ein neues Image ausgerollt oder eine Maschine entfernt, muss der gesamte Prozess von vorne gestartet werden.
- Andernfalls funktioniert SSO nicht ordnungsgemäß.

---

## 4. Optimierungsvorschläge

### 4.1. Pool von Reservegeräten
- Bereitstellung eines Pools von 3–5 Geräten, die als Reserve dienen.
- Wenn eine Maschine gelöscht wird, kann ein Benutzer direkt auf eine der Reservegeräte zugreifen.
- Vor dem Entfernen einer Maschine:
  - Maschine aus **entra.microsoft.com** und der Domäne entfernen.
  - Dies kann manuell oder per Skript erfolgen.

### 4.2. Automatisierung des Prozesses
- Erstellung eines Skripts zur Automatisierung der Schritte:
  - Maschinenbereitstellung.
  - Überprüfung des Status („Verfügbar“).
  - Neustart der Maschinen.
  - Durchführung des AD-SyncCycle.

### 4.3. Überwachung und Benachrichtigung
- Einrichtung eines Monitoringsystems, das Benachrichtigungen sendet, wenn:
  - Maschinen bereitgestellt werden.
  - Der Status „Ausstehend“ in Microsoft Entra erreicht wird.

---

## 5. Verantwortlichkeiten

| **Schritt**              | **Verantwortlich**       | **Werkzeug/Plattform**            |
|--------------------------|-------------------------|-----------------------------------|
| Maschinenbereitstellung  | IT-Administrator        | GH-CON11, Virtualisierungsplattform |
| Neustart der Maschinen   | IT-Administrator/Skript | GH-CON11                           |
| AD-SyncCycle durchführen | IT-Administrator/Skript | GH-DC01, PowerShell               |
| Überprüfung in Entra     | IT-Administrator        | entra.microsoft.com               |

---

## 6. Anhang

### PowerShell-Befehl für AD-SyncCycle:
```powershell
Start-ADSyncSyncCycle -PolicyType Delta
```

### Filter in Entra setzen:
1. Navigieren zu **Geräte -> Alle Geräte**.
2. Filter setzen:
   - NLV oder LS-Admin.

---

Diese Dokumentation sollte regelmäßig überprüft und angepasst werden, um den Prozess zu optimieren und neue Herausforderungen zu berücksichtigen.

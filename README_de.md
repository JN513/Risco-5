Claro, aqui está a tradução para o alemão:

---

# RISCO 5

<p align="center">
<img src="docs/docs/imgs/risco5.jpeg" alt="Prozessorlogo" width="300px">
</p>

Mehrphasen-Prozessor [RISC-V](https://riscv.org/) mit RV32I-Implementierung, entwickelt während einiger freier Tage.

## Offizielle Projektsprache

Die offizielle Sprache des Projekts ist brasilianisches Portugiesisch; daher sind die meisten Dokumentationen und Commits in dieser Sprache verfasst.

## Jenkins CI

[![Build-Status](https://lampiao.ic.unicamp.br/jenkins/buildStatus/icon?job=Risco_5)](https://lampiao.ic.unicamp.br/jenkins/blue/organizations/jenkins/Risco_5/activity)

## Implementierung

Der Prozessor wurde mit Verilog HDL implementiert und verfügt über eine mehrphasige Implementierung ohne Pipeline.

## Software

Das Verzeichnis `software` enthält Beispiele und Tests in Assembly sowie deren entsprechende Speicherdateien. Zusätzlich gibt es ein Skript zur Umwandlung von Assemblercode in Speicherdateien. Die offizielle Firmware des Prozessors ist ebenfalls im Verzeichnis `software/firmware` verfügbar.

## Tests

Das Verzeichnis `tests` enthält verschiedene Tests, die mit [Iverilog](https://steveicarus.github.io/iverilog/) erstellt wurden. Alle Tests in diesem Verzeichnis sind mit Iverilog kompatibel.

## RISCO 5-Familie:

- Baby RISCO 5 - RV16I: Noch in spekulativer Phase
- Pequeno RISCO 5 - RV32I: [https://github.com/JN513/Pequeno-Risco-5/](https://github.com/JN513/Pequeno-Risco-5/)
- RISCO 5 - RV32I: [https://github.com/JN513/Risco-5](https://github.com/JN513/Risco-5)
- Grande RISCO 5 - RV32I: [https://github.com/JN513/Grande-Risco-5](https://github.com/JN513/Grande-Risco-5)
- RISCO 5 Bodybuilder - RV64I: Noch in spekulativer Phase

## Fragen und Vorschläge

Die offizielle Dokumentation finden Sie unter: [https://jn513.github.io/Risco-5/](https://jn513.github.io/Risco-5/). Bei Fragen oder Vorschlägen nutzen Sie gerne den [ISSUES](https://github.com/JN513/Risco-5/issues)-Abschnitt auf GitHub. Beiträge sind willkommen und alle [Pull-Anfragen](https://github.com/JN513/Risco-5/pulls) werden geprüft und wenn möglich zusammengeführt.

## Beitrag

Wenn Sie zum Projekt beitragen möchten, zögern Sie nicht, dies zu tun. Die Datei [CONTRIBUTING.md](https://github.com/JN513/Risco-5/blob/main/CONTRIBUTING.md) enthält die erforderlichen Anweisungen.

## Lizenz

Dieses Projekt ist unter der Lizenz [CERN-OHL-P-2.0](https://github.com/JN513/Risco-5/blob/main/LICENSE) lizenziert, die uneingeschränkte Nutzung ermöglicht. Die Software ist unter der [MIT-Lizenz](https://github.com/JN513/Risco-5/blob/main/LICENSE-MIT) und die Dokumentation unter [CC BY-SA 4.0](https://github.com/JN513/Risco-5/blob/main/LICENSE-CC) lizenziert.

Logo-Autor: [Mateus Luck](https://www.instagram.com/mateusluck/)

---
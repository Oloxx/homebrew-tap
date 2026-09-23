# Homebrew tap de drop

Fórmula de [drop](https://github.com/Oloxx/drop), transferencia de archivos P2P cifrada de
extremo a extremo, para macOS (Apple Silicon e Intel) y Linux (x64 y arm64).

```bash
brew install oloxx/tap/drop
```

Para actualizar, `brew upgrade drop`, no `drop update`: el binario es de Homebrew.

Sin avisos de Gatekeeper: Homebrew descarga sin marcar el archivo como bajado de Internet.

## Cómo se mantiene

`Formula/drop.rb` no se edita a mano. `scripts/update.mjs` lo genera a partir de la última release
de `Oloxx/drop`, y **solo después de comprobar con `minisign` la firma de su `SHA256SUMS`** con la
clave pública del proyecto:

```
RWQqNnfqvCrj+eavJ9njz2vCoHaC8YnLqjsvNBMndz3hBroQLpou7+Kp
```

El workflow `Actualizar y probar` lo ejecuta cada seis horas, hace commit si hay versión nueva e
instala la fórmula de verdad en macOS (arm64 e Intel) y Linux antes de darla por buena.

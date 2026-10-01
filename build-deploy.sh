#!/bin/bash
# Arma la carpeta lista para subir al hosting (DreamHost).
# Uso:  ./build-deploy.sh
# Resultado: ../Dr-Jonathan-deploy/  y  ../Dr-Jonathan-deploy.zip
set -euo pipefail
cd "$(dirname "$0")"
OUT="../Dr-Jonathan-deploy"
rm -rf "$OUT" "$OUT.zip"
mkdir -p "$OUT"

rsync -a \
  --exclude='/.git' --exclude='/.gitignore' --exclude='.DS_Store' --exclude='/.thumbnail' \
  --exclude='/archive' --exclude='/brand' --exclude='/screenshots' --exclude='/uploads' \
  --exclude='/Revision-*.pdf' --exclude='/htaccess.txt' --exclude='/build-deploy.sh' \
  --exclude='/imgs/hospital.jpg' --exclude='/imgs/doc.jpg' \
  ./ "$OUT/"

cp htaccess.txt "$OUT/.htaccess"
(cd "$OUT" && zip -qr "../Dr-Jonathan-deploy.zip" . -x '.DS_Store')

echo "Paquete listo: $OUT"
echo "Archivos: $(find "$OUT" -type f | wc -l | tr -d ' ')   Tamaño: $(du -sh "$OUT" | cut -f1)"

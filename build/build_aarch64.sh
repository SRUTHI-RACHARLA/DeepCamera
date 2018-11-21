#!/usr/bin/env bash

rm -rf build dist runtime
mkdir runtime
pyinstaller classifier_server.spec
mv dist/classifier runtime/
pyinstaller embedding.spec
cp -rf dist/embedding/* runtime/
rm -rf dist/embedding
pyinstaller face_detector.spec
cp -rf dist/worker/* runtime/
rm -rf dist/worker
pyinstaller parameter_server.spec
cp -rf dist/param/* runtime/
rm -rf dist/param

mkdir -p runtime/data/faces
mkdir runtime/faces/default_data
mkdir runtime/image
cp ../src/embedding/data/data.sqlite ./runtime/data/
cp ../src/embedding/data/params.ini ./runtime/data/
cp ../src/embedding/faces/default_data/default_face.png ./runtime/faces/default_data/
cp ../src/embedding/image/Mike*.png ./runtime/image
cp -rf ../src/embedding/pages ./runtime/
cp -rf ../src/embedding/migrations ./runtime/

cp -rf ../model ./runtime/
cp -rf ../src/face_detection/model/* ./runtime/model/

cp scripts/*_aarch64.sh runtime/
chmod +x runtime/*.sh
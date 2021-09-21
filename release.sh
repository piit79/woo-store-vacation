#!/bin/bash -e

name=woo-store-vacation
version=$(git describe --tags)
release=$name-$version

export PATH=$(pwd)/vendor/bin:$(pwd)/node_modules/.bin:$PATH

echo "Creating release $version"
echo "Performing code checks..."
composer lint:wpcs
composer lint:php

echo "Copying files..."
mkdir -p $release/$name
cp -a assets languages woo-store-vacation.php woo-store-vacation-config.php.sample uninstall.php index.php wpml-config.xml readme.txt LICENSE $release/$name

cd $release
echo "Packing ZIP..."
zip -r ../$release.zip $name
echo
echo "Packing tarball..."
tar -czvf ../$release.tar.gz $name
echo
echo "Cleaning up..."
rm -rf $name
cd ..
rmdir $release

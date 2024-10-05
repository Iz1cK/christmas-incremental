# Remove old packages folders
if (Test-Path -Path "Packages" -PathType Container) {
	Remove-Item -Path "Packages" -Recurse -Force
}

# Install packages
wally install

if (-Not (Test-Path -Path "Packages" -PathType Container)) {
	New-Item -Path "Packages" -ItemType Directory
}

# Sourcemap generation
rojo sourcemap --output sourcemap.json default.project.json

# Export the types
wally-package-types --sourcemap sourcemap.json Packages/

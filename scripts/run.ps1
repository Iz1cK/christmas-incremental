# Remove old packages folders
if (Test-Path -Path "Build" -PathType Container) {
	Remove-Item -Path "Build" -Recurse -Force
}

if (-Not (Test-Path -Path "Build" -PathType Container)) {
	New-Item -Path "Build" -ItemType Directory
}

# Build generation
rojo build --output Build/Main.rbxl
Build/Main.rbxl
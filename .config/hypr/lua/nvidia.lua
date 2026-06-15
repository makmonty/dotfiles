-- Nvidia specific config
hl.env("LIBVA_DRIVER_NAME", "nvidia")
hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")
-- hl.env("GBM_BACKEND", "nvidia-drm")
hl.env("NVD_BACKEND", "direct")
-- Electron
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "auto")

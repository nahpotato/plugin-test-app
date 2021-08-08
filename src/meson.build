libpta_sources = [
  'pta-app.vala',
  'pta-app-window.vala',
  'pta-extension.vala',
]

libpta_deps = [
  dependency('gtk4', version: '>=4.2'),
  dependency('libadwaita-1', version: '>=1.0'),
  dependency('libpeas-1.0', version: '>=1.0'),
]

gnome = import('gnome')

libpta_sources += gnome.compile_resources(
  'plugin_test_app-resources',
  'plugin_test_app.gresource.xml',
)

libpta = library(
  'pta',
  libpta_sources,
  vala_header: 'pta.h',
  vala_vapi: 'pta-0.0.vapi',
  vala_gir: 'Pta-0.0.gir',
  dependencies: libpta_deps,
  install: true,
)

g_ir_compiler = find_program('g-ir-compiler')

custom_target(
  'Pta-0.0.typelib',
  command: [
    g_ir_compiler,
    '--shared-library',
    libpta.full_path(),
    '--output',
    '@OUTPUT@',
    meson.current_build_dir() / 'Pta-0.0.gir',
  ],
  output: 'Pta-0.0.typelib',
  depends: libpta,
  install: true,
  install_dir: get_option('prefix') / get_option('libdir') / 'girepository-1.0',
)

pta_dep = declare_dependency(
  link_with: libpta,
  dependencies: libpta_deps,
  include_directories: include_directories('.')
)

executable(
  'plugin-test-app',
  'plugin-test-app.vala',
  dependencies: pta_dep,
  install: true,
)

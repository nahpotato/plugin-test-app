/* vala-extension.vala
 *
 * Copyright 2021 Nahuel Gomez Castro
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

public class ValaExtension : Object, Pta.Extension {
  public Pta.AppWindow app_window { get; set; }

  Gtk.Button _button;

  void activate () {
    _button = new Gtk.Button.with_label ("Say Hello");
    _button.clicked.connect (() => _button.label = "Hello World!");
    _app_window.buttons.append (_button);
  }

  void deactivate () {
    _app_window.buttons.remove (_button);
  }
}

[ModuleInit]
public void peas_register_types (TypeModule module) {
  var obj_module = (Peas.ObjectModule) module;
  obj_module.register_extension_type (
      typeof (Pta.Extension), typeof (ValaExtension));
}

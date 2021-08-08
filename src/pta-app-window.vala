/* pta-app-window.vala
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

[GtkTemplate (ui = "/ar/com/nahuelgomez/PluginTestApp/app-window.ui")]
public class Pta.AppWindow : Gtk.ApplicationWindow {
  Peas.ExtensionSet _exts;

  [GtkChild]
  public unowned Gtk.Box buttons { get; }

  public AppWindow (App app) {
    Object (application: app);
  }

  construct {
    var engine = Peas.Engine.get_default ();

    engine.add_search_path ("/app/lib/plugin-test-app/plugins", null);

    engine.enable_loader ("python3");

    _exts = new Peas.ExtensionSet (
        engine, typeof (Pta.Extension), "app-window", this);

    _exts.extension_added.connect (
        (_, ext) => ((Pta.Extension) ext).activate ());
    _exts.extension_removed.connect (
        (_, ext) => ((Pta.Extension) ext).deactivate ());

    foreach (var plugin in engine.get_plugin_list ())
      engine.try_load_plugin (plugin);
  }
}

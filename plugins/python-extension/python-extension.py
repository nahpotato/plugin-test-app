# python-extension.py
#
# Copyright 2021 Nahuel Gomez Castro
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
# SPDX-License-Identifier: GPL-3.0-or-later

import gi
gi.require_version('Gtk', '4.0')
gi.require_version('Peas', '1.0')
gi.require_version('Pta', '0.0')

from gi.repository import GObject, Gtk, Peas, Pta

class PythonExtension(GObject.Object, Pta.Extension):
    app_window = GObject.Property(type=Pta.AppWindow)

    def do_activate(self):
        self._button = Gtk.Button(label='Quit')
        self._button.connect('clicked', self.app_window.props.application.quit())

        self.app_window.props.buttons.append(self._button)

    def do_deactivate(self):
        self.app_window.props.buttons.remove(self._button)

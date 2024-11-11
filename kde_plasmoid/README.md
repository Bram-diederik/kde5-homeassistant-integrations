this is a edited kde5 widget to show a website with out controls
ideal to show a home assistant panel on your kde desktop.

dont use to many because it can slow things down.


edit `org.kde.plasma.hass/contents/config/main.xml` with your url. (and use kiosk hacs
and copy the org.kde.plasma.hass code to /usr/share/plasma/plasmoids/

if you want to use multiple widgets edit `org.kde.plasma.hass/metadata.json` with a diffrent id.

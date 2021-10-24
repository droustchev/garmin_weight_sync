import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;

class WeightSyncMenuDelegate extends WatchUi.Menu2InputDelegate {

    function initialize() {
        Menu2InputDelegate.initialize();
    }

    function onSelect(item as MenuItem) as Void {
        var id = item.getId() as String;
        if (id.equals("manual")) {
            System.println("manual selected");
        } else if (id.equals("sync")) {
            System.println("sync selected");
        }
    }

}
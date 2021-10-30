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
            var view = new $.ActivityView();
            WatchUi.pushView(view, new $.ActivityDelegate(view), WatchUi.SLIDE_LEFT);
        } else if (id.equals("sync")) {
            System.println("sync selected");
        }
    }

}
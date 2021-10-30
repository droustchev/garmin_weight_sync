import Toybox.ActivityRecording;
import Toybox.Graphics;
import Toybox.WatchUi;

class ActivityDelegate extends WatchUi.BehaviorDelegate {
    private var _view as ActivityView;

    public function initialize(view as ActivityView) {
        BehaviorDelegate.initialize();
        _view = view;
    }

    public function onMenu() as Boolean {
        if (Toybox has :ActivityRecording) {
            if (!_view.isSessionRecording()) {
                _view.startRecording();
            } else {
                _view.stopRecording();
            }
        }
        return true;
    }
}

class ActivityView extends WatchUi.View {

    private var _session as Session?;
    private var _weightField as FitContributor.Field?;

    function initialize() {
        View.initialize();
    }

    // Load your resources here
    function onLayout(dc as Dc) as Void {
        setLayout(Rez.Layouts.MainLayout(dc));
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() as Void {
    }

    // Update the view
    function onUpdate(dc as Dc) as Void {
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_WHITE);
        dc.clear();
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        dc.fillRectangle(0, 0, dc.getWidth(), dc.getHeight());
        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_WHITE);
        dc.drawText(dc.getWidth() / 2, 0, Graphics.FONT_XTINY, "M:" + System.getSystemStats().usedMemory, Graphics.TEXT_JUSTIFY_CENTER);

        if (Toybox has :ActivityRecording) {
            // Draw the instructions
            if (!isSessionRecording()) {
                dc.setColor(Graphics.COLOR_BLUE, Graphics.COLOR_WHITE);
                dc.drawText(dc.getWidth() / 2, dc.getHeight() / 2, Graphics.FONT_MEDIUM, "Press Menu to\nStart Recording", Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);
            } else {
                var x = dc.getWidth() / 2;
                var y = dc.getFontHeight(Graphics.FONT_XTINY);
                dc.setColor(Graphics.COLOR_RED, Graphics.COLOR_WHITE);
                dc.drawText(x, y, Graphics.FONT_MEDIUM, "Recording...", Graphics.TEXT_JUSTIFY_CENTER);
                y += dc.getFontHeight(Graphics.FONT_MEDIUM);
                dc.setColor(Graphics.COLOR_BLUE, Graphics.COLOR_WHITE);
                var weightField = _weightField;
                weightField.setData(87.8);
                System.println("Data Recorded");
                dc.drawText(x, y, Graphics.FONT_MEDIUM, "Press Menu again\nto Stop and Save\nthe Recording", Graphics.TEXT_JUSTIFY_CENTER);
            }
        } else {
            // tell the user this sample doesn't work
            dc.setColor(Graphics.COLOR_RED, Graphics.COLOR_WHITE);
            dc.drawText(dc.getWidth() / 2, dc.getWidth() / 2, Graphics.FONT_MEDIUM, "This product doesn't\nhave FIT Support", Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);
        }
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() as Void {
    }

    public function isSessionRecording() as Boolean {
        var session = _session;
        if (session != null) {
            return session.isRecording();
        }
        return false;
    }

    public function startRecording() as Void {
        var session = ActivityRecording.createSession({:name=>"Withings", :sport=>ActivityRecording.SPORT_GENERIC});
        var weightField = session.createField("weight", 0, FitContributor.DATA_TYPE_FLOAT, {:mesgType => FitContributor.MESG_TYPE_SESSION, :units => "kg", :nativeNum => 0});
        _session = session;
        _weightField = weightField;
        session.start();
        System.println("Session Started");
        WatchUi.requestUpdate();
    }

    public function stopRecording() as Void {
        var session = _session;
        if ((Toybox has :ActivityRecording) && isSessionRecording() && (session != null)) {
            session.stop();
            session.save();
            System.println("Session Saved");
            _session = null;
            WatchUi.requestUpdate();
        }
    }

}
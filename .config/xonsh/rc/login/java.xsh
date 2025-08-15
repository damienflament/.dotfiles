""" Applications Java. """

java_options = {
   "awt.useSystemAAFontSettings":   "on",
   "swing.aatext":                  "true",

   #"swing.defaultlaf":              "com.sun.java.swing.plaf.gtk.GTKLookAndFeel",
   #"swing.crossplatformlaf":        "com.sun.java.swing.plaf.gtk.GTKLookAndFeel",
   "jdk.gtk.version":               "3",
}

$JAVA_TOOL_OPTIONS = " ".join(map(
    lambda i: f"-D{i[0]}={i[1]}",
    java_options.items()
))

del java_options

$_JAVA_AWT_WM_NONREPARENTING = 1

using Gtk;
using Posix;

/* move all files from one place to another */


void println (string str) {
    Posix.stdout.printf ("%s\n", str);
}


public void on_window1_destroy (Window source) {
    /* When window close signal received  @TODO!!!*/
    println ("\nexit\n");
    Gtk.main_quit ();
}

int main (string[] args) {     
    Gtk.init (ref args);

    var builder = new Builder ();
    /* Getting the glade file */
    builder.add_from_file ("window.ui");
    builder.connect_signals (null);

    var window = builder.get_object ("window1") as Window;
    var save_button = builder.get_object ("save") as Button;
    var close_button = builder.get_object ("close") as Button;
    var fin = builder.get_object ("file_in") as FileChooserButton;
    var fout = builder.get_object ("file_out") as FileChooserButton;

    /* thats another way to do something when signal received */
    save_button.clicked.connect (() => {
        /* move from a to b */
        var regex = new Regex("(file://)");
       string str = "";
        var command_builder = new StringBuilder();
        command_builder.append("cp -rf ");
        command_builder.append(fin.get_uri());
        command_builder.append("/* ");
        command_builder.append(fout.get_uri());
        command_builder.append("/");
        str = command_builder.str;
        
        str = str.replace("file://", "");
        
        println (str);
        Posix.system(str);
    });

    close_button.clicked.connect (() => {
        println ("\nexit\n");
        Gtk.main_quit ();
    });
    
    window.show_all ();
    Gtk.main ();

    return 0;
}

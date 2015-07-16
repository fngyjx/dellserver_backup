#!/bin/bash
## Followings are output of perldoc -t -q command
#Found in /usr/lib/perl5/5.8.8/pod/perlfaq3.pod
##  Can I write useful Perl programs on the command line?
##    Yes. Read perlrun for more information. Some examples follow. (These
##    assume standard Unix shell quoting rules.)

        # sum first and last fields
        perl -lane 'print $F[0] + $F[-1]' *

        # identify text files
        perl -le 'for(@ARGV) {print if -f && -T _}' *

        # remove (most) comments from C program
        perl -0777 -pe 's{/\*.*?\*/}{}gs' foo.c

        # make file a month younger than today, defeating reaper daemons
        perl -e '$X=24*60*60; utime(time(),time() + 30 * $X,@ARGV)' *

        # find first unused uid
        perl -le '$i++ while getpwuid($i); print $i'

        # display reasonable manpath
        echo $PATH | perl -nl -072 -e 's![^/+]*$!man!&&-d&&!$s{$_}++&&push@m,$_;END{print"@m"}'

##    OK, the last one was actually an Obfuscated Perl Contest entry. :-)

exit 0;
__END__

Found in /usr/lib/perl5/5.8.8/pod/perlfaq8.pod
  How can I open a pipe both to and from a command?
    The IPC::Open2 module (part of the standard perl distribution) is an
    easy-to-use approach that internally uses pipe(), fork(), and exec() to
    do the job. Make sure you read the deadlock warnings in its
    documentation, though (see IPC::Open2). See "Bidirectional Communication
    with Another Process" in perlipc and "Bidirectional Communication with
    Yourself" in perlipc

    You may also use the IPC::Open3 module (part of the standard perl
    distribution), but be warned that it has a different order of arguments
    from IPC::Open2 (see IPC::Open3).

  Why can't I get the output of a command with system()?
    You're confusing the purpose of system() and backticks (``). system()
    runs a command and returns exit status information (as a 16 bit value:
    the low 7 bits are the signal the process died from, if any, and the
    high 8 bits are the actual exit value). Backticks (``) run a command and
    return what it sent to STDOUT.

        $exit_status   = system("mail-users");
        $output_string = `ls`;

  How can I capture STDERR from an external command?
    There are three basic ways of running external commands:

        system $cmd;                # using system()
        $output = `$cmd`;           # using backticks (``)
        open (PIPE, "cmd |");       # using open()

    With system(), both STDOUT and STDERR will go the same place as the
    script's STDOUT and STDERR, unless the system() command redirects them.
    Backticks and open() read only the STDOUT of your command.

    You can also use the open3() function from IPC::Open3. Benjamin Goldberg
    provides some sample code:

    To capture a program's STDOUT, but discard its STDERR:

        use IPC::Open3;
        use File::Spec;
        use Symbol qw(gensym);
        open(NULL, ">", File::Spec->devnull);
        my $pid = open3(gensym, \*PH, ">&NULL", "cmd");
        while( <PH> ) { }
        waitpid($pid, 0);

    To capture a program's STDERR, but discard its STDOUT:

        use IPC::Open3;
        use File::Spec;
        use Symbol qw(gensym);
        open(NULL, ">", File::Spec->devnull);
        my $pid = open3(gensym, ">&NULL", \*PH, "cmd");
        while( <PH> ) { }
        waitpid($pid, 0);

    To capture a program's STDERR, and let its STDOUT go to our own STDERR:

        use IPC::Open3;
        use Symbol qw(gensym);
        my $pid = open3(gensym, ">&STDERR", \*PH, "cmd");
        while( <PH> ) { }
        waitpid($pid, 0);

    To read both a command's STDOUT and its STDERR separately, you can
    redirect them to temp files, let the command run, then read the temp
    files:

        use IPC::Open3;
        use Symbol qw(gensym);
        use IO::File;
        local *CATCHOUT = IO::File->new_tmpfile;
        local *CATCHERR = IO::File->new_tmpfile;
        my $pid = open3(gensym, ">&CATCHOUT", ">&CATCHERR", "cmd");
        waitpid($pid, 0);
        seek $_, 0, 0 for \*CATCHOUT, \*CATCHERR;
        while( <CATCHOUT> ) {}
        while( <CATCHERR> ) {}

    But there's no real need for *both* to be tempfiles... the following
    should work just as well, without deadlocking:

        use IPC::Open3;
        use Symbol qw(gensym);
        use IO::File;
        local *CATCHERR = IO::File->new_tmpfile;
        my $pid = open3(gensym, \*CATCHOUT, ">&CATCHERR", "cmd");
        while( <CATCHOUT> ) {}
        waitpid($pid, 0);
        seek CATCHERR, 0, 0;
        while( <CATCHERR> ) {}

    And it'll be faster, too, since we can begin processing the program's
    stdout immediately, rather than waiting for the program to finish.

    With any of these, you can change file descriptors before the call:

        open(STDOUT, ">logfile");
        system("ls");

    or you can use Bourne shell file-descriptor redirection:

        $output = `$cmd 2>some_file`;
        open (PIPE, "cmd 2>some_file |");

    You can also use file-descriptor redirection to make STDERR a duplicate
    of STDOUT:

        $output = `$cmd 2>&1`;
        open (PIPE, "cmd 2>&1 |");

    Note that you *cannot* simply open STDERR to be a dup of STDOUT in your
    Perl program and avoid calling the shell to do the redirection. This
    doesn't work:

        open(STDERR, ">&STDOUT");
        $alloutput = `cmd args`;  # stderr still escapes

    This fails because the open() makes STDERR go to where STDOUT was going
    at the time of the open(). The backticks then make STDOUT go to a
    string, but don't change STDERR (which still goes to the old STDOUT).

    Note that you *must* use Bourne shell (sh(1)) redirection syntax in
    backticks, not csh(1)! Details on why Perl's system() and backtick and
    pipe opens all use the Bourne shell are in the versus/csh.whynot article
    in the "Far More Than You Ever Wanted To Know" collection in
    http://www.cpan.org/misc/olddoc/FMTEYEWTK.tgz . To capture a command's
    STDERR and STDOUT together:

        $output = `cmd 2>&1`;                       # either with backticks
        $pid = open(PH, "cmd 2>&1 |");              # or with an open pipe
        while (<PH>) { }                            #    plus a read

    To capture a command's STDOUT but discard its STDERR:

        $output = `cmd 2>/dev/null`;                # either with backticks
        $pid = open(PH, "cmd 2>/dev/null |");       # or with an open pipe
        while (<PH>) { }                            #    plus a read

    To capture a command's STDERR but discard its STDOUT:

        $output = `cmd 2>&1 1>/dev/null`;           # either with backticks
        $pid = open(PH, "cmd 2>&1 1>/dev/null |");  # or with an open pipe
        while (<PH>) { }                            #    plus a read

    To exchange a command's STDOUT and STDERR in order to capture the STDERR
    but leave its STDOUT to come out our old STDERR:

        $output = `cmd 3>&1 1>&2 2>&3 3>&-`;        # either with backticks
        $pid = open(PH, "cmd 3>&1 1>&2 2>&3 3>&-|");# or with an open pipe
        while (<PH>) { }                            #    plus a read

    To read both a command's STDOUT and its STDERR separately, it's easiest
    to redirect them separately to files, and then read from those files
    when the program is done:

        system("program args 1>program.stdout 2>program.stderr");

    Ordering is important in all these examples. That's because the shell
    processes file descriptor redirections in strictly left to right order.

        system("prog args 1>tmpfile 2>&1");
        system("prog args 2>&1 1>tmpfile");

    The first command sends both standard out and standard error to the
    temporary file. The second command sends only the old standard output
    there, and the old standard error shows up on the old standard out.

  Is there a way to hide perl's command line from programs such as "ps"?
    First of all note that if you're doing this for security reasons (to
    avoid people seeing passwords, for example) then you should rewrite your
    program so that critical information is never given as an argument.
    Hiding the arguments won't make your program completely secure.

    To actually alter the visible command line, you can assign to the
    variable $0 as documented in perlvar. This won't work on all operating
    systems, though. Daemon programs like sendmail place their state there,
    as in:

        $0 = "orcus [accepting connections]";

Found in /usr/lib/perl5/5.8.8/pod/perlfaq9.pod
  My CGI script runs from the command line but not the browser.  (500 Server Error)
    Several things could be wrong. You can go through the "Troubleshooting
    Perl CGI scripts" guide at

            http://www.perl.org/troubleshooting_CGI.html

    If, after that, you can demonstrate that you've read the FAQs and that
    your problem isn't something simple that can be easily answered, you'll
    probably receive a courteous and useful reply to your question if you
    post it on comp.infosystems.www.authoring.cgi (if it's something to do
    with HTTP or the CGI protocols). Questions that appear to be Perl
    questions but are really CGI ones that are posted to comp.lang.perl.misc
    are not so well received.

    The useful FAQs, related documents, and troubleshooting guides are
    listed in the CGI Meta FAQ:

            http://www.perl.org/CGI_MetaFAQ.html


Return-path: <wsa@the-dreams.de>
From: Wolfram Sang <wsa@the-dreams.de>
To: linux-watchdog@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>,
	linux-renesas-soc@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>,
	Robin Gong <b38343@freescale.com>
Subject: [PATCH 0/7] watchdog: add pretimeout support
Date: Wed, 25 May 2016 15:32:24 +0200
Message-Id: <1464183151-4912-1-git-send-email-wsa@the-dreams.de>
List-ID: <linux-watchdog@vger.kernel.org>

Okay, here is my approach of adding pretimeout support to the watchdog core. It
is based on work of Vladimir Zapolskiy and Robin Gong (Thanks!) yet rebased
(quite some core changes since then) and reworked significantly. Check the
patch descriptions for changes. I also added pretimeout support to the softdog
because the board in question did not have hardware support for pretimeouts.

Note that in this series the userspace governor is not included. I will send
out an RFC series with it after this one. I expect more discussion on my
approach there while I think these patches could be ready to go. They work fine
here, so the rest may done incrementally?

Here is a q'n'd patch for the busybox 'watchdog' command for easier testing:

Index: b/miscutils/watchdog.c
===================================================================
--- a/miscutils/watchdog.c
+++ b/miscutils/watchdog.c
@@ -10,11 +10,12 @@
  */
 
 //usage:#define watchdog_trivial_usage
-//usage:       "[-t N[ms]] [-T N[ms]] [-F] DEV"
+//usage:       "[-t N[ms]] [-T N[ms]] [-P N[ms]] [-F] DEV"
 //usage:#define watchdog_full_usage "\n\n"
 //usage:       "Periodically write to watchdog device DEV\n"
 //usage:     "\n	-T N	Reboot after N seconds if not reset (default 60)"
 //usage:     "\n	-t N	Reset every N seconds (default 30)"
+//usage:     "\n	-P N	Pretimeout warning N seconds before reboot (default 0)"
 //usage:     "\n	-F	Run in foreground"
 //usage:     "\n"
 //usage:     "\nUse 500ms to specify period in milliseconds"
@@ -26,6 +27,7 @@
 #define OPT_FOREGROUND  (1 << 0)
 #define OPT_STIMER      (1 << 1)
 #define OPT_HTIMER      (1 << 2)
+#define OPT_PTIMER      (1 << 3)
 
 static void watchdog_shutdown(int sig UNUSED_PARAM)
 {
@@ -50,11 +52,13 @@ int watchdog_main(int argc, char **argv)
 	unsigned opts;
 	unsigned stimer_duration; /* how often to restart */
 	unsigned htimer_duration = 60000; /* reboots after N ms if not restarted */
+	unsigned ptimer_duration = 0; /* pre-timeout notification N ms before reboot */
 	char *st_arg;
 	char *ht_arg;
+	char *pt_arg;
 
 	opt_complementary = "=1"; /* must have exactly 1 argument */
-	opts = getopt32(argv, "Ft:T:", &st_arg, &ht_arg);
+	opts = getopt32(argv, "Ft:T:P:", &st_arg, &ht_arg, &pt_arg);
 
 	/* We need to daemonize *before* opening the watchdog as many drivers
 	 * will only allow one process at a time to do so.  Since daemonizing
@@ -88,6 +92,10 @@ int watchdog_main(int argc, char **argv)
 	}
 # endif
 	ioctl_or_warn(3, WDIOC_SETTIMEOUT, &htimer_duration);
+	if (opts & OPT_PTIMER) {
+		ptimer_duration = xatou_sfx(pt_arg, suffixes) / 1000;
+		ioctl_or_warn(3, WDIOC_SETPRETIMEOUT, &ptimer_duration);
+	}
 #endif
 
 #if 0



Please test, review, comment, apply...

Thanks,

   Wolfram

Vladimir Zapolskiy (2):
  watchdog: pretimeout: add panic pretimeout governor
  watchdog: pretimeout: add noop pretimeout governor

Wolfram Sang (5):
  watchdog: add watchdog pretimeout framework
  watchdog: documentation: squash paragraphs about 'no set_timeout'
  watchdog: add WDIOC_SETPRETIMEOUT and WDIOC_GETPRETIMEOUT
  fs: compat_ioctl: add pretimeout functions for watchdogs
  watchdog: softdog: implement pretimeout support

 Documentation/watchdog/watchdog-kernel-api.txt |  24 ++-
 drivers/watchdog/Kconfig                       |  52 +++++
 drivers/watchdog/Makefile                      |   9 +-
 drivers/watchdog/pretimeout_noop.c             |  47 +++++
 drivers/watchdog/pretimeout_panic.c            |  47 +++++
 drivers/watchdog/softdog.c                     |  20 +-
 drivers/watchdog/watchdog_dev.c                |  61 +++++-
 drivers/watchdog/watchdog_pretimeout.c         | 269 +++++++++++++++++++++++++
 drivers/watchdog/watchdog_pretimeout.h         |  41 ++++
 fs/compat_ioctl.c                              |   2 +
 include/linux/watchdog.h                       |  21 ++
 11 files changed, 586 insertions(+), 7 deletions(-)
 create mode 100644 drivers/watchdog/pretimeout_noop.c
 create mode 100644 drivers/watchdog/pretimeout_panic.c
 create mode 100644 drivers/watchdog/watchdog_pretimeout.c
 create mode 100644 drivers/watchdog/watchdog_pretimeout.h

-- 
2.8.1

Return-path: <Julia.Lawall@lip6.fr>
From: Julia Lawall <Julia.Lawall@lip6.fr>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: kernel-janitors@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] watchdog: constify watchdog_ops structures
Date: Thu,  1 Sep 2016 19:35:26 +0200
Message-Id: <1472751326-22897-3-git-send-email-Julia.Lawall@lip6.fr>
In-Reply-To: <1472751326-22897-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1472751326-22897-1-git-send-email-Julia.Lawall@lip6.fr>
List-ID: <linux-watchdog@vger.kernel.org>

Check for watchdog_ops structures that are only stored in the ops field of
a watchdog_device structure.  This field is declared const, so watchdog_ops
structures that have this property can be declared as const also.

The semantic patch that makes this change is as follows:
(http://coccinelle.lip6.fr/)

// <smpl>
@r disable optional_qualifier@
identifier i;
position p;
@@
static struct watchdog_ops i@p = { ... };

@ok@
identifier r.i;
struct watchdog_device e;
position p;
@@
e.ops = &i@p;

@bad@
position p != {r.p,ok.p};
identifier r.i;
struct watchdog_ops e;
@@
e@i@p

@depends on !bad disable optional_qualifier@
identifier r.i;
@@
static
+const
 struct watchdog_ops i = { ... };
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 drivers/watchdog/bcm7038_wdt.c  |    2 +-
 drivers/watchdog/cadence_wdt.c  |    2 +-
 drivers/watchdog/kempld_wdt.c   |    2 +-
 drivers/watchdog/rn5t618_wdt.c  |    2 +-
 drivers/watchdog/softdog.c      |    2 +-
 drivers/watchdog/w83627hf_wdt.c |    2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/watchdog/bcm7038_wdt.c b/drivers/watchdog/bcm7038_wdt.c
index 4245b65..e238df4 100644
--- a/drivers/watchdog/bcm7038_wdt.c
+++ b/drivers/watchdog/bcm7038_wdt.c
@@ -107,7 +107,7 @@ static struct watchdog_info bcm7038_wdt_info = {
 				WDIOF_MAGICCLOSE
 };
 
-static struct watchdog_ops bcm7038_wdt_ops = {
+static const struct watchdog_ops bcm7038_wdt_ops = {
 	.owner		= THIS_MODULE,
 	.start		= bcm7038_wdt_start,
 	.stop		= bcm7038_wdt_stop,
diff --git a/drivers/watchdog/cadence_wdt.c b/drivers/watchdog/cadence_wdt.c
index 4dda902..a4e05e43 100644
--- a/drivers/watchdog/cadence_wdt.c
+++ b/drivers/watchdog/cadence_wdt.c
@@ -269,7 +269,7 @@ static struct watchdog_info cdns_wdt_info = {
 };
 
 /* Watchdog Core Ops */
-static struct watchdog_ops cdns_wdt_ops = {
+static const struct watchdog_ops cdns_wdt_ops = {
 	.owner = THIS_MODULE,
 	.start = cdns_wdt_start,
 	.stop = cdns_wdt_stop,
diff --git a/drivers/watchdog/kempld_wdt.c b/drivers/watchdog/kempld_wdt.c
index 5bf931c..8e302d0 100644
--- a/drivers/watchdog/kempld_wdt.c
+++ b/drivers/watchdog/kempld_wdt.c
@@ -430,7 +430,7 @@ static struct watchdog_info kempld_wdt_info = {
 			WDIOF_PRETIMEOUT
 };
 
-static struct watchdog_ops kempld_wdt_ops = {
+static const struct watchdog_ops kempld_wdt_ops = {
 	.owner		= THIS_MODULE,
 	.start		= kempld_wdt_start,
 	.stop		= kempld_wdt_stop,
diff --git a/drivers/watchdog/rn5t618_wdt.c b/drivers/watchdog/rn5t618_wdt.c
index d1c1227..0805ee2 100644
--- a/drivers/watchdog/rn5t618_wdt.c
+++ b/drivers/watchdog/rn5t618_wdt.c
@@ -136,7 +136,7 @@ static struct watchdog_info rn5t618_wdt_info = {
 	.identity	= DRIVER_NAME,
 };
 
-static struct watchdog_ops rn5t618_wdt_ops = {
+static const struct watchdog_ops rn5t618_wdt_ops = {
 	.owner          = THIS_MODULE,
 	.start          = rn5t618_wdt_start,
 	.stop           = rn5t618_wdt_stop,
diff --git a/drivers/watchdog/softdog.c b/drivers/watchdog/softdog.c
index b067edf..1ae469e 100644
--- a/drivers/watchdog/softdog.c
+++ b/drivers/watchdog/softdog.c
@@ -92,7 +92,7 @@ static struct watchdog_info softdog_info = {
 	.options = WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING | WDIOF_MAGICCLOSE,
 };
 
-static struct watchdog_ops softdog_ops = {
+static const struct watchdog_ops softdog_ops = {
 	.owner = THIS_MODULE,
 	.start = softdog_ping,
 	.stop = softdog_stop,
diff --git a/drivers/watchdog/w83627hf_wdt.c b/drivers/watchdog/w83627hf_wdt.c
index 09e8003..ef2ecaf 100644
--- a/drivers/watchdog/w83627hf_wdt.c
+++ b/drivers/watchdog/w83627hf_wdt.c
@@ -302,7 +302,7 @@ static struct watchdog_info wdt_info = {
 	.identity = "W83627HF Watchdog",
 };
 
-static struct watchdog_ops wdt_ops = {
+static const struct watchdog_ops wdt_ops = {
 	.owner = THIS_MODULE,
 	.start = wdt_start,
 	.stop = wdt_stop,

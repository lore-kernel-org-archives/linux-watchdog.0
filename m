Return-path: <Julia.Lawall@lip6.fr>
From: Julia Lawall <Julia.Lawall@lip6.fr>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: kernel-janitors@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Alexandre Courbot <gnurou@gmail.com>,
	linux-watchdog@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] watchdog: tegra: constify watchdog_ops structures
Date: Thu,  1 Sep 2016 19:35:25 +0200
Message-Id: <1472751326-22897-2-git-send-email-Julia.Lawall@lip6.fr>
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
 drivers/watchdog/tegra_wdt.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/tegra_wdt.c b/drivers/watchdog/tegra_wdt.c
index 9ec5760..2d53c3f 100644
--- a/drivers/watchdog/tegra_wdt.c
+++ b/drivers/watchdog/tegra_wdt.c
@@ -178,7 +178,7 @@ static const struct watchdog_info tegra_wdt_info = {
 	.identity	= "Tegra Watchdog",
 };
 
-static struct watchdog_ops tegra_wdt_ops = {
+static const struct watchdog_ops tegra_wdt_ops = {
 	.owner = THIS_MODULE,
 	.start = tegra_wdt_start,
 	.stop = tegra_wdt_stop,

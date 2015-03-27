Return-path: <wimvs@spo001.leaseweb.nl>
Date: Fri, 27 Mar 2015 08:53:26 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	James Hogan <james.hogan@imgtec.com>
Subject: [GIT PULL REQUEST] watchdog - v4.0-rc5 Fixes
Message-ID: <20150327075326.GA24918@spo001.leaseweb.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: <wimvs@spo001.leaseweb.nl>
List-ID: <linux-watchdog@vger.kernel.org>

Hi Linus,

Please pull from 'master' branch of
	git://www.linux-watchdog.org/linux-watchdog.git

It will fix the following issues:
* mtk_wdt: signedness bug in mtk_wdt_start()
* imgpdc: Fix probe NULL pointer dereference during probe and fix the default heartbeat

This will update the following files:

 imgpdc_wdt.c |    8 ++++----
 mtk_wdt.c    |    2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

with these Changes:

commit ae6ee2fd47f76db5a1cd02c23378057bd21c2c8d
Author: James Hogan <james.hogan@imgtec.com>
Date:   Fri Feb 20 23:45:45 2015 +0000

    watchdog: imgpdc: Fix default heartbeat
    
    The IMG PDC watchdog driver heartbeat module parameter has no default so
    it is initialised to zero. This results in the following warning during
    probe:
    
    imgpdc-wdt 2006000.wdt: Initial timeout out of range! setting max timeout
    
    The module parameter description implies that the default value should
    be PDC_WDT_DEF_TIMEOUT, which isn't yet used, so initialise it to that.
    
    Also tweak the heartbeat module parameter description for consistency.
    
    Fixes: 93937669e9b5 ("watchdog: ImgTec PDC Watchdog Timer Driver")
    Signed-off-by: James Hogan <james.hogan@imgtec.com>
    Cc: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
    Cc: Naidu Tellapati <Naidu.Tellapati@imgtec.com>
    Cc: Jude Abraham <Jude.Abraham@imgtec.com>
    Cc: linux-watchdog@vger.kernel.org
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit a629c08fdb98ebb184d745553af9dda4f05941bf
Author: James Hogan <james.hogan@imgtec.com>
Date:   Fri Feb 20 23:45:44 2015 +0000

    watchdog: imgpdc: Fix probe NULL pointer dereference
    
    The IMG PDC watchdog probe function calls pdc_wdt_stop() prior to
    watchdog_set_drvdata(), causing a NULL pointer dereference when
    pdc_wdt_stop() retrieves the struct pdc_wdt_dev pointer using
    watchdog_get_drvdata() and reads the register base address through it.
    
    Fix by moving the watchdog_set_drvdata() call earlier, to where various
    other pdc_wdt->wdt_dev fields are initialised.
    
    Fixes: 93937669e9b5 ("watchdog: ImgTec PDC Watchdog Timer Driver")
    Signed-off-by: James Hogan <james.hogan@imgtec.com>
    Cc: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
    Cc: Naidu Tellapati <Naidu.Tellapati@imgtec.com>
    Cc: Jude Abraham <Jude.Abraham@imgtec.com>
    Cc: linux-watchdog@vger.kernel.org
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 9ffd906d9a6e50c958bd99971d762a426a12a36a
Author: Dan Carpenter <dan.carpenter@oracle.com>
Date:   Wed Feb 11 13:26:21 2015 +0300

    watchdog: mtk_wdt: signedness bug in mtk_wdt_start()
    
    "ret" should be signed for the error handling to work correctly.  This
    doesn't matter much in real life since mtk_wdt_set_timeout() always
    succeeds.
    
    Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
    Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

For completeness, I added the overal diff below.

Greetings,
Wim.

================================================================================
diff --git a/drivers/watchdog/imgpdc_wdt.c b/drivers/watchdog/imgpdc_wdt.c
index c8def68..0deaa4f 100644
--- a/drivers/watchdog/imgpdc_wdt.c
+++ b/drivers/watchdog/imgpdc_wdt.c
@@ -42,10 +42,10 @@
 #define PDC_WDT_MIN_TIMEOUT		1
 #define PDC_WDT_DEF_TIMEOUT		64
 
-static int heartbeat;
+static int heartbeat = PDC_WDT_DEF_TIMEOUT;
 module_param(heartbeat, int, 0);
-MODULE_PARM_DESC(heartbeat, "Watchdog heartbeats in seconds. "
-	"(default = " __MODULE_STRING(PDC_WDT_DEF_TIMEOUT) ")");
+MODULE_PARM_DESC(heartbeat, "Watchdog heartbeats in seconds "
+	"(default=" __MODULE_STRING(PDC_WDT_DEF_TIMEOUT) ")");
 
 static bool nowayout = WATCHDOG_NOWAYOUT;
 module_param(nowayout, bool, 0);
@@ -191,6 +191,7 @@ static int pdc_wdt_probe(struct platform_device *pdev)
 	pdc_wdt->wdt_dev.ops = &pdc_wdt_ops;
 	pdc_wdt->wdt_dev.max_timeout = 1 << PDC_WDT_CONFIG_DELAY_MASK;
 	pdc_wdt->wdt_dev.parent = &pdev->dev;
+	watchdog_set_drvdata(&pdc_wdt->wdt_dev, pdc_wdt);
 
 	ret = watchdog_init_timeout(&pdc_wdt->wdt_dev, heartbeat, &pdev->dev);
 	if (ret < 0) {
@@ -232,7 +233,6 @@ static int pdc_wdt_probe(struct platform_device *pdev)
 	watchdog_set_nowayout(&pdc_wdt->wdt_dev, nowayout);
 
 	platform_set_drvdata(pdev, pdc_wdt);
-	watchdog_set_drvdata(&pdc_wdt->wdt_dev, pdc_wdt);
 
 	ret = watchdog_register_device(&pdc_wdt->wdt_dev);
 	if (ret)
diff --git a/drivers/watchdog/mtk_wdt.c b/drivers/watchdog/mtk_wdt.c
index a87f6df..938b987 100644
--- a/drivers/watchdog/mtk_wdt.c
+++ b/drivers/watchdog/mtk_wdt.c
@@ -133,7 +133,7 @@ static int mtk_wdt_start(struct watchdog_device *wdt_dev)
 	u32 reg;
 	struct mtk_wdt_dev *mtk_wdt = watchdog_get_drvdata(wdt_dev);
 	void __iomem *wdt_base = mtk_wdt->wdt_base;
-	u32 ret;
+	int ret;
 
 	ret = mtk_wdt_set_timeout(wdt_dev, wdt_dev->timeout);
 	if (ret < 0)

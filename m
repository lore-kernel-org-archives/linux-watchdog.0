Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from ns1.pc-advies.be ([83.149.101.17]:57678 "EHLO
	spo001.leaseweb.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755856Ab2EDMn1 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 4 May 2012 08:43:27 -0400
Date: Fri, 4 May 2012 14:43:25 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>
Cc: Thomas Mingarelli <thomas.mingarelli@hp.com>,
	Marc Vertes <marc.vertes@sigfox.com>
Subject: [PATCH] watchdog: Use module_pci_driver
Message-ID: <20120504124325.GU3074@spo001.leaseweb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

This patch converts the PCI watchdog drivers so that they use the
module_pci_driver() macro. This makes the code smaller and simpler.

Signed-off-by: Wim Van Sebroeck <wim@iguana.be>
Cc: Thomas Mingarelli <thomas.mingarelli@hp.com>
Cc: Marc Vertes <marc.vertes@sigfox.com>

diff --git a/drivers/watchdog/hpwdt.c b/drivers/watchdog/hpwdt.c
index 9f13b89..b993c8b 100644
--- a/drivers/watchdog/hpwdt.c
+++ b/drivers/watchdog/hpwdt.c
@@ -855,16 +855,6 @@ static struct pci_driver hpwdt_driver =3D {
 	.remove =3D __devexit_p(hpwdt_exit),
 };
=20
-static void __exit hpwdt_cleanup(void)
-{
-	pci_unregister_driver(&hpwdt_driver);
-}
-
-static int __init hpwdt_init(void)
-{
-	return pci_register_driver(&hpwdt_driver);
-}
-
 MODULE_AUTHOR("Tom Mingarelli");
 MODULE_DESCRIPTION("hp watchdog driver");
 MODULE_LICENSE("GPL");
@@ -887,5 +877,4 @@ MODULE_PARM_DESC(priority, "The hpwdt driver handles =
NMIs first or last"
 		" (default =3D 0/Last)\n");
 #endif /* !CONFIG_HPWDT_NMI_DECODING */
=20
-module_init(hpwdt_init);
-module_exit(hpwdt_cleanup);
+module_pci_driver(hpwdt_driver);
diff --git a/drivers/watchdog/i6300esb.c b/drivers/watchdog/i6300esb.c
index 738032a..276877d 100644
--- a/drivers/watchdog/i6300esb.c
+++ b/drivers/watchdog/i6300esb.c
@@ -492,19 +492,7 @@ static struct pci_driver esb_driver =3D {
 	.shutdown       =3D esb_shutdown,
 };
=20
-static int __init watchdog_init(void)
-{
-	return pci_register_driver(&esb_driver);
-}
-
-static void __exit watchdog_cleanup(void)
-{
-	pci_unregister_driver(&esb_driver);
-	pr_info("Watchdog Module Unloaded\n");
-}
-
-module_init(watchdog_init);
-module_exit(watchdog_cleanup);
+module_pci_driver(esb_driver);
=20
 MODULE_AUTHOR("Ross Biro and David H=E4rdeman");
 MODULE_DESCRIPTION("Watchdog driver for Intel 6300ESB chipsets");
diff --git a/drivers/watchdog/pcwd_pci.c b/drivers/watchdog/pcwd_pci.c
index c891399..ee6900d 100644
--- a/drivers/watchdog/pcwd_pci.c
+++ b/drivers/watchdog/pcwd_pci.c
@@ -707,6 +707,7 @@ static int __devinit pcipcwd_card_init(struct pci_dev=
 *pdev,
 		goto err_out_disable_device;
 	}
=20
+	spin_lock_init(&pcipcwd_private.io_lock);
 	pcipcwd_private.pdev =3D pdev;
 	pcipcwd_private.io_addr =3D pci_resource_start(pdev, 0);
=20
@@ -814,22 +815,7 @@ static struct pci_driver pcipcwd_driver =3D {
 	.remove		=3D __devexit_p(pcipcwd_card_exit),
 };
=20
-static int __init pcipcwd_init_module(void)
-{
-	spin_lock_init(&pcipcwd_private.io_lock);
-
-	return pci_register_driver(&pcipcwd_driver);
-}
-
-static void __exit pcipcwd_cleanup_module(void)
-{
-	pci_unregister_driver(&pcipcwd_driver);
-
-	pr_info("Watchdog Module Unloaded\n");
-}
-
-module_init(pcipcwd_init_module);
-module_exit(pcipcwd_cleanup_module);
+module_pci_driver(pcipcwd_driver);
=20
 MODULE_AUTHOR("Wim Van Sebroeck <wim@iguana.be>");
 MODULE_DESCRIPTION("Berkshire PCI-PC Watchdog driver");
diff --git a/drivers/watchdog/via_wdt.c b/drivers/watchdog/via_wdt.c
index 465e082..5603e31 100644
--- a/drivers/watchdog/via_wdt.c
+++ b/drivers/watchdog/via_wdt.c
@@ -202,6 +202,9 @@ static int __devinit wdt_probe(struct pci_dev *pdev,
 		goto err_out_release;
 	}
=20
+	if (timeout < 1 || timeout > WDT_TIMEOUT_MAX)
+		timeout =3D WDT_TIMEOUT;
+
 	wdt_dev.timeout =3D timeout;
 	watchdog_set_nowayout(&wdt_dev, nowayout);
 	if (readl(wdt_mem) & VIA_WDT_FIRED)
@@ -250,20 +253,7 @@ static struct pci_driver wdt_driver =3D {
 	.remove		=3D __devexit_p(wdt_remove),
 };
=20
-static int __init wdt_init(void)
-{
-	if (timeout < 1 || timeout > WDT_TIMEOUT_MAX)
-		timeout =3D WDT_TIMEOUT;
-	return pci_register_driver(&wdt_driver);
-}
-
-static void __exit wdt_exit(void)
-{
-	pci_unregister_driver(&wdt_driver);
-}
-
-module_init(wdt_init);
-module_exit(wdt_exit);
+module_pci_driver(wdt_driver);
=20
 MODULE_AUTHOR("Marc Vertes");
 MODULE_DESCRIPTION("Driver for watchdog timer on VIA chipset");
diff --git a/drivers/watchdog/wdt_pci.c b/drivers/watchdog/wdt_pci.c
index 1c888c7..e32654e 100644
--- a/drivers/watchdog/wdt_pci.c
+++ b/drivers/watchdog/wdt_pci.c
@@ -739,39 +739,7 @@ static struct pci_driver wdtpci_driver =3D {
 	.remove		=3D __devexit_p(wdtpci_remove_one),
 };
=20
-
-/**
- *	wdtpci_cleanup:
- *
- *	Unload the watchdog. You cannot do this with any file handles open.
- *	If your watchdog is set to continue ticking on close and you unload
- *	it, well it keeps ticking. We won't get the interrupt but the board
- *	will not touch PC memory so all is fine. You just have to load a new
- *	module in xx seconds or reboot.
- */
-
-static void __exit wdtpci_cleanup(void)
-{
-	pci_unregister_driver(&wdtpci_driver);
-}
-
-
-/**
- *	wdtpci_init:
- *
- *	Set up the WDT watchdog board. All we have to do is grab the
- *	resources we require and bitch if anyone beat us to them.
- *	The open() function will actually kick the board off.
- */
-
-static int __init wdtpci_init(void)
-{
-	return pci_register_driver(&wdtpci_driver);
-}
-
-
-module_init(wdtpci_init);
-module_exit(wdtpci_cleanup);
+module_pci_driver(wdtpci_driver);
=20
 MODULE_AUTHOR("JP Nollmann, Alan Cox");
 MODULE_DESCRIPTION("Driver for the ICS PCI-WDT500/501 watchdog cards");
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

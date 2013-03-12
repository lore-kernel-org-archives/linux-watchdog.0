Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
        Randy Dunlap <rdunlap@infradead.org>,
        David Dajun Chen <dchen@diasemi.com>, Wim Van Sebroeck <wim@iguana.be>,
        linux-watchdog@vger.kernel.org
Subject: [ 009/100] watchdog: da9055_wdt needs to select WATCHDOG_CORE
Date: Tue, 12 Mar 2013 15:30:54 -0700
Message-Id: <20130312223123.927810409@linuxfoundation.org>
In-Reply-To: <20130312223122.884099393@linuxfoundation.org>
References: <20130312223122.884099393@linuxfoundation.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
List-ID: <linux-watchdog@vger.kernel.org>

3.8-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Randy Dunlap <rdunlap@infradead.org>

commit 12a5c05cb143105d989abf728a8c769830670e54 upstream.

DA9055_WATCHDOG (introduced in v3.8) needs to select WATCHDOG_CORE so that it will
build cleanly.  Fixes these build errors:

da9055_wdt.c:(.text+0xe9bc7): undefined reference to `watchdog_unregister_device'
da9055_wdt.c:(.text+0xe9f4b): undefined reference to `watchdog_register_device'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: David Dajun Chen <dchen@diasemi.com>
Signed-off-by: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/watchdog/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -79,6 +79,7 @@ config DA9052_WATCHDOG
 config DA9055_WATCHDOG
 	tristate "Dialog Semiconductor DA9055 Watchdog"
 	depends on MFD_DA9055
+	select WATCHDOG_CORE
 	help
 	  If you say yes here you get support for watchdog on the Dialog
 	  Semiconductor DA9055 PMIC.

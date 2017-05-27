Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-qt0-f194.google.com ([209.85.216.194]:33453 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754703AbdE0BXQ (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 26 May 2017 21:23:16 -0400
From: Murilo Opsfelder Araujo <mopsfelder@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: linux-watchdog@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@iguana.be>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Murilo Opsfelder Araujo <mopsfelder@gmail.com>
Subject: [PATCH] drivers/watchdog/Kconfig: Update CONFIG_WATCHDOG_RTAS dependencies
Date: Fri, 26 May 2017 22:22:56 -0300
Message-Id: <20170527012256.6005-1-mopsfelder@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

drivers/watchdog/wdrtas.c uses symbols defined in arch/powerpc/kernel/rta=
s.c,
which are exported iff CONFIG_PPC_RTAS is selected. Building wdrtas.c wit=
hout
setting CONFIG_PPC_RTAS throws the following errors:

    ERROR: ".rtas_token" [drivers/watchdog/wdrtas.ko] undefined!
    ERROR: "rtas_data_buf" [drivers/watchdog/wdrtas.ko] undefined!
    ERROR: "rtas_data_buf_lock" [drivers/watchdog/wdrtas.ko] undefined!
    ERROR: ".rtas_get_sensor" [drivers/watchdog/wdrtas.ko] undefined!
    ERROR: ".rtas_call" [drivers/watchdog/wdrtas.ko] undefined!

This was identified during a randconfig build where CONFIG_WATCHDOG_RTAS=3D=
m and
CONFIG_PPC_RTAS was not set. Logs are here:

    http://kisskb.ellerman.id.au/kisskb/buildresult/12982152/

This patch fixes the issue by selecting CONFIG_PPC_RTAS when
CONFIG_WATCHDOG_RTAS is set.

Signed-off-by: Murilo Opsfelder Araujo <mopsfelder@gmail.com>
---
 drivers/watchdog/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 8b9049d..5d872145 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -1689,6 +1689,7 @@ config MEN_A21_WDT
 config WATCHDOG_RTAS
 	tristate "RTAS watchdog"
 	depends on PPC_RTAS || (PPC64 && COMPILE_TEST)
+	select PPC_RTAS
 	help
 	  This driver adds watchdog support for the RTAS watchdog.
=20
--=20
2.9.4

--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

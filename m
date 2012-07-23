Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:35985 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751872Ab2GWJOP (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 23 Jul 2012 05:14:15 -0400
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
To: Grant Likely <grant.likely@secretlab.ca>,
	Arnd Bergmann <arnd@arndb.de>,
	Rob Herring <rob.herring@calxeda.com>,
	Wim Van Sebroeck <wim@iguana.be>
Cc: kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 17/25] watchdog/mpc8xxx: add a const qualifier
Date: Mon, 23 Jul 2012 11:13:22 +0200
Message-Id: <1343034810-3386-18-git-send-email-u.kleine-koenig@pengutronix.de>
In-Reply-To: <1343034810-3386-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1343034810-3386-1-git-send-email-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

From: Arnd Bergmann <arnd@arndb.de>

This prepares *of_device_id.data becoming const. Without this change
the following warning would occur:

	drivers/watchdog/mpc8xxx_wdt.c: In function 'mpc8xxx_wdt_probe':
	drivers/watchdog/mpc8xxx_wdt.c:203:11: warning: assignment discards 'con=
st' qualifier from pointer target type [enabled by default]

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
[ukl: split Arnd's patch by driver and add changelog]
Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
---
 drivers/watchdog/mpc8xxx_wdt.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/mpc8xxx_wdt.c b/drivers/watchdog/mpc8xxx_wd=
t.c
index 40f7bf1..e6a038a 100644
--- a/drivers/watchdog/mpc8xxx_wdt.c
+++ b/drivers/watchdog/mpc8xxx_wdt.c
@@ -193,7 +193,7 @@ static int __devinit mpc8xxx_wdt_probe(struct platfor=
m_device *ofdev)
 	int ret;
 	const struct of_device_id *match;
 	struct device_node *np =3D ofdev->dev.of_node;
-	struct mpc8xxx_wdt_type *wdt_type;
+	const struct mpc8xxx_wdt_type *wdt_type;
 	u32 freq =3D fsl_get_sys_freq();
 	bool enabled;
=20
--=20
1.7.10.4

--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

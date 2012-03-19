Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from nat28.tlf.novell.com ([130.57.49.28]:26567 "EHLO
	nat28.tlf.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754210Ab2CSJai convert rfc822-to-8bit (ORCPT
	<rfc822;groupwise-linux-watchdog@vger.kernel.org:6:1>);
	Mon, 19 Mar 2012 05:30:38 -0400
Message-Id: <4F670AC9020000780007934F@nat28.tlf.novell.com>
Date: Mon, 19 Mar 2012 09:30:33 +0000
From: "Jan Beulich" <JBeulich@suse.com>
To: <wim@iguana.be>, "Konrad Rzeszutek Wilk" <konrad.wilk@oracle.com>
Cc: "Ian Campbell" <ian.campbell@citrix.com>,
	"Wouter de Geus" <benv-xensource.com@junerules.com>,
	"xen-devel" <xen-devel@lists.xen.org>,
	<linux-watchdog@vger.kernel.org>
Subject: [PATCH] watchdog/xen: don't unconditionally enable the
 watchdog during resume
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

This was found to be a problem particularly after guest migration.

Signed-off-by: Jan Beulich <jbeulich@suse.com>
Reported-by: Wouter de Geus <benv-xensource.com@junerules.com>
Reported-by: Ian Campbell <Ian.Campbell@citrix.com>
Tested-by: Wouter de Geus <benv-xensource.com@junerules.com>

---
 drivers/watchdog/xen_wdt.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

--- 3.3/drivers/watchdog/xen_wdt.c
+++ 3.3-xen-watchdog-resume/drivers/watchdog/xen_wdt.c
@@ -299,11 +299,18 @@ static void xen_wdt_shutdown(struct plat
=20
 static int xen_wdt_suspend(struct platform_device *dev, pm_message_t sta=
te)
 {
-	return xen_wdt_stop();
+	typeof(wdt.id) id =3D wdt.id;
+	int rc =3D xen_wdt_stop();
+
+	wdt.id =3D id;
+	return rc;
 }
=20
 static int xen_wdt_resume(struct platform_device *dev)
 {
+	if (!wdt.id)
+		return 0;
+	wdt.id =3D 0;
 	return xen_wdt_start();
 }
=20



--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

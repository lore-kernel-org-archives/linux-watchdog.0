Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:47934 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757146Ab3CZH05 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 26 Mar 2013 03:26:57 -0400
From: "Kim, Milo" <Milo.Kim@ti.com>
To: "wim@iguana.be" <wim@iguana.be>
CC: "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] watchdog: softdog: remove replaceable ping operation
Date: Tue, 26 Mar 2013 07:26:49 +0000
Message-ID: <A874F61F95741C4A9BA573A70FE3998F82E49607@DQHE02.ent.ti.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

In watchdog_ping(), 'start' is called automatically when 'ping' function =
call
is not configured.
Softdog driver has same handling in both cases - start and ping, so 'ping=
' OPS
can be removed.

Signed-off-by: Milo(Woogyom) Kim <milo.kim@ti.com>
---
 drivers/watchdog/softdog.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/watchdog/softdog.c b/drivers/watchdog/softdog.c
index fe83beb..b68b1e5 100644
--- a/drivers/watchdog/softdog.c
+++ b/drivers/watchdog/softdog.c
@@ -152,7 +152,6 @@ static struct watchdog_ops softdog_ops =3D {
 	.owner =3D THIS_MODULE,
 	.start =3D softdog_ping,
 	.stop =3D softdog_stop,
-	.ping =3D softdog_ping,
 	.set_timeout =3D softdog_set_timeout,
 };
=20
--=20
1.7.9.5


Best Regards,
Milo


--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

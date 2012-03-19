Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from nat28.tlf.novell.com ([130.57.49.28]:60550 "EHLO
	nat28.tlf.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757066Ab2CSJcc convert rfc822-to-8bit (ORCPT
	<rfc822;groupwise-linux-watchdog@vger.kernel.org:4:1>);
	Mon, 19 Mar 2012 05:32:32 -0400
Message-Id: <4F670B3C020000780007935F@nat28.tlf.novell.com>
Date: Mon, 19 Mar 2012 09:32:28 +0000
From: "Jan Beulich" <JBeulich@suse.com>
To: <wim@iguana.be>, "Konrad Rzeszutek Wilk" <konrad.wilk@oracle.com>
Cc: "xen-devel" <xen-devel@lists.xen.org>,
	<linux-watchdog@vger.kernel.org>
Subject: [PATCH] watchdog/xen: don't clear is_active when
 xen_wdt_stop() failed
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

xen_wdt_release() shouldn't clear is_active even when the watchdog
didn't get stopped (which by itself shouldn't happen, but let's return
a proper error in this case rather than adding a BUG() upon hypercall
failure).

Signed-off-by: Jan Beulich <jbeulich@suse.com>

---
 drivers/watchdog/xen_wdt.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

--- 3.3/drivers/watchdog/xen_wdt.c
+++ 3.3-xen-watchdog-release/drivers/watchdog/xen_wdt.c
@@ -131,16 +131,18 @@ static int xen_wdt_open(struct inode *in
=20
 static int xen_wdt_release(struct inode *inode, struct file *file)
 {
+	int err =3D 0;
+
 	if (expect_release)
-		xen_wdt_stop();
+		err =3D xen_wdt_stop();
 	else {
 		printk(KERN_CRIT PFX
 		       "unexpected close, not stopping watchdog!\n");
 		xen_wdt_kick();
 	}
-	is_active =3D false;
+	is_active =3D err;
 	expect_release =3D false;
-	return 0;
+	return err;
 }
=20
 static ssize_t xen_wdt_write(struct file *file, const char __user *data,



--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

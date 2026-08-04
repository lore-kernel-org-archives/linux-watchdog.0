Received: from mail.renesp.com.br (mail.renesp.com.br [45.231.133.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD2C3E51F8
	for <linux-watchdog@vger.kernel.org>; Tue,  4 Aug 2026 10:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.231.133.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785840020; cv=none; b=a+D/4t1oOtOdyGKTNZlD3T4sG6xw5/Brbfe9wMe2jweZ5cgarFBRJofmPzv6kbu+5Jq9cfrG62k97x/nHM2ciSh6k1KZlcm3UwiWtQhVuGDYk7eL2l5OT77BbnRgiJ2A5xbXYhWAyXZ/R9piHvy7aPAES9f4D1XDdXIszOzspSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785840020; c=relaxed/simple;
	bh=5Bg7a+29Hy//wiFKZjCIFOWP/O99tbwnWW6Wo2geZQs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BUDJTPqQxQNJPSWFEgdSmQ8nWhwOS8qjzt5PNbsz+SE0wHk4IxmE+LuWk6Sa3TMS6JlFtyeFXUfSb9MtPZWLvi56CMYVBBOradKPz34MAbghJahGxxcFT23OXqAjg9C11SFVGdDhrB+TnIWj2GbEEKqAKAc4t6G1Q6wga9zjjdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=renesp.com.br; spf=pass smtp.mailfrom=renesp.com.br; dkim=pass (1024-bit key) header.d=renesp.com.br header.i=@renesp.com.br header.b=ZGBw+jku; dkim=fail (1024-bit key) header.d=tempos-project.org header.i=@tempos-project.org header.b=Yyb2YsqO reason="signature verification failed"; dkim=fail (1024-bit key) header.d=renesp.com.br header.i=@renesp.com.br header.b=Rr3hujOO reason="signature verification failed"; arc=none smtp.client-ip=45.231.133.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=renesp.com.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesp.com.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesp.com.br header.i=@renesp.com.br header.b="ZGBw+jku";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=tempos-project.org header.i=@tempos-project.org header.b="Yyb2YsqO";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=renesp.com.br header.i=@renesp.com.br header.b="Rr3hujOO"
Received: from renesp.vps (renesp.com.br [127.0.0.1])
	by mail.renesp.com.br (Postfix) with ESMTP id 4hDqnB58lHz3xQy
	for <linux-watchdog@vger.kernel.org>; Tue,  4 Aug 2026 07:40:14 -0300 (-03)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=renesp.com.br;
	s=2021; t=1785840014;
	bh=5Bg7a+29Hy//wiFKZjCIFOWP/O99tbwnWW6Wo2geZQs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZGBw+jkuLbgvrdHzyehoqxeKWf6Rf/4EOAvQDNLXd9S7CaYhpDKmzkGWg9LQCxGzE
	 C5TqRRPEwVJxQzDfjKUK1oBKqGCKW4aHDz1F6Gq0Vc1Qnl4Xo7O1z7rb/Ngfr6EqJD
	 zRLYFUjgwm5w5qQqTGjE+GjoiCBtJDC2tFGz/SiE=
Authentication-Results: renesp.vps (amavisd-new); dkim=pass (1024-bit key)
	reason="pass (just generated, assumed good)"
	header.d=tempos-project.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
	tempos-project.org; h=content-transfer-encoding:content-type
	:mime-version:references:in-reply-to:x-mailer:message-id:date
	:subject:to:from; s=dkim; t=1785840013; x=1788432014; bh=5Bg7a+2
	9Hy//wiFKZjCIFOWP/O99tbwnWW6Wo2geZQs=; b=Yyb2YsqOWa4OtZ9NMzau95F
	15d0K+yvGwUgmsGl+jyXJ/VQkUqXsQ0Zi7u3Aj54J2zNn/aINrmq0W2dyQifuXBx
	LFHXzPnmCPa8m2zSvxPhdNttzUJaayCZIxM/HbgV4Iqr7Fdgl5g1koWaE3mgsTuJ
	+rDxRAhuRa70CDkyUAVnzbQ+gpx11IU1KgyZLoJ4USbIwRbfrVb9uJfRYkKJlQfr
	12rpgdfVAOlyqzi368PwonkTsJYVxpDbg9uOswqQb5HN0Po2ozcjNjewKTedaTOy
	Rx0dqgP/Oe+0t600Yj4OCZc78mRbE3CuvFr8pOt43xtKZYdNFMIElJKMpE0J19w=
	=
X-Virus-Scanned: Debian amavisd-new at renesp.vps
X-Spam-Flag: NO
X-Spam-Score: 3.71
X-Spam-Level: ***
Authentication-Results: renesp.vps (amavisd-new); dkim=fail (1024-bit key)
	reason="fail (body has been altered)" header.d=renesp.com.br
Received: from mail.renesp.com.br ([127.0.0.1])
	by renesp.vps (renesp.vps [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id jMbSKaPbvcTM for <linux-watchdog@vger.kernel.org>;
	Tue,  4 Aug 2026 07:40:13 -0300 (-03)
Received: from rsp-x1 (unknown [212.86.61.58])
	by mail.renesp.com.br (Postfix) with ESMTPSA id 4hDqn82Vpyz3wq1;
	Tue,  4 Aug 2026 07:40:12 -0300 (-03)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=renesp.com.br;
	s=2021; t=1785840013;
	bh=0yGG/ospRkCuwPnBxoSNM7ShgDypnodO9KbsEPK0rEc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Rr3hujOO7dbxxTSrkjo9HmoB3yxmS2SJ/lyWrk1E2zo9Lsawtg4ZdO5gDwIaotfRf
	 ++HWmsLZqx+d5aTkbX7xWiLtp+DAsM1smtOLp4ObJwT+IoVSCBXqirKrmuUl9pggQl
	 y2LWQ9HF8/ouvt+QuLAfywcrfdP0NZDIFISUlLOI=
From: =?UTF-8?q?Ren=C3=AA=20de=20Souza=20Pinto?= <rene@renesp.com.br>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-watchdog@vger.kernel.org (open list:WATCHDOG DEVICE DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Cc: =?UTF-8?q?Ren=C3=AA=20de=20Souza=20Pinto?= <rene@renesp.com.br>
Subject: [PATCH v2] watchdog: wdat_wdt: map registers that fall inside ACPI NVS
Date: Tue,  4 Aug 2026 12:39:57 +0200
Message-ID: <20260804103958.3684195-1-rene@renesp.com.br>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260804092337.3556947-1-rene@renesp.com.br>
References: <20260804092337.3556947-1-rene@renesp.com.br>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Some firmwares describe WDAT registers inside memory ranges marked as
ACPI NVS in the E820 map, failing with -EBUSY during probe, leaving the
hardware watchdog unserviced and triggering periodic system resets.

This issue was observed on a OnLogic Karbon 524 device (when watchdog is
enabled in BIOS):

wdat_wdt wdat_wdt: error -EBUSY: can't request region for resource [mem 0=
x63df7a98]
wdat_wdt wdat_wdt: probe with driver wdat_wdt failed with error -16

Check whether the region falls inside ACPI NVS before requesting it and,
if so, map it without reservation.

Signed-off-by: Ren=C3=AA de Souza Pinto <rene@renesp.com.br>
---
 drivers/watchdog/wdat_wdt.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/watchdog/wdat_wdt.c b/drivers/watchdog/wdat_wdt.c
index dd3c2d69c9df..55ea16e73652 100644
--- a/drivers/watchdog/wdat_wdt.c
+++ b/drivers/watchdog/wdat_wdt.c
@@ -7,7 +7,9 @@
  */
=20
 #include <linux/acpi.h>
+#include <linux/io.h>
 #include <linux/ioport.h>
+#include <linux/mm.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/pm.h>
@@ -309,6 +311,29 @@ static struct watchdog_ops wdat_wdt_ops =3D {
 	.set_timeout =3D wdat_wdt_set_timeout,
 };
=20
+static void __iomem *wdat_wdt_map_mem(struct device *dev, struct resourc=
e *res)
+{
+	resource_size_t size =3D resource_size(res);
+	void *addr;
+
+	/* Map memory region without reserving it if it falls inside ACPI NVS *=
/
+	if (region_intersects(res->start, size, IORESOURCE_MEM,
+			      IORES_DESC_ACPI_NV_STORAGE) =3D=3D REGION_INTERSECTS) {
+		dev_warn(dev, "%pR is inside ACPI NVS, mapping without reservation\n",
+			 res);
+
+		addr =3D devm_memremap(dev, res->start, size, MEMREMAP_WB);
+		if (IS_ERR(addr)) {
+			dev_err(dev, "failed to map resource %pR\n", res);
+			return IOMEM_ERR_PTR(PTR_ERR(addr));
+		}
+
+		return (void __iomem __force *)addr;
+	}
+
+	return devm_ioremap_resource(dev, res);
+}
+
 static int wdat_wdt_probe(struct platform_device *pdev)
 {
 	struct device *dev =3D &pdev->dev;
@@ -362,7 +387,7 @@ static int wdat_wdt_probe(struct platform_device *pde=
v)
=20
 		res =3D &pdev->resource[i];
 		if (resource_type(res) =3D=3D IORESOURCE_MEM) {
-			reg =3D devm_ioremap_resource(dev, res);
+			reg =3D wdat_wdt_map_mem(dev, res);
 			if (IS_ERR(reg)) {
 				ret =3D PTR_ERR(reg);
 				goto out_put_table;
--=20
2.53.0


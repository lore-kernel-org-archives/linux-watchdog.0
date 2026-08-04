Received: from mail.renesp.com.br (mail.renesp.com.br [45.231.133.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3637943CE4D
	for <linux-watchdog@vger.kernel.org>; Tue,  4 Aug 2026 09:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.231.133.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785835778; cv=none; b=dRQE71X+HVCeMsYVA5anIwRBqdokRXbxldI0tw5wRhaepwXTSiLmB7tJtjPAGPC/aeDFtza6aRNcr5aW67YlvE63iNoayyyBjMS/n111UFko3A032HXaeKP8KcgqDkIzQNOJ+neBS9vawJUVsqK4Z+4pngVsq33ySROoo9Ct8ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785835778; c=relaxed/simple;
	bh=vLC6sslm0qTVX+YlXDzk6GkiBKUVBBOBdoUk+Urw0Jc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WgZ9K/MmNeq/pHPT/B1/ePRWQoh+Nq4gE525liz2Fo/SDPGqDlHNa7e4i3dm1YrXy11iwlH29BIraH+Pybk+XCyOygT8A2T641EuXoYkBbm5+yl+UdOqERBwnGPIxT8/wYEp6enSXS4dXc5QJYCpRpKLrkOA1p7o3aRSqh86Zlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=renesp.com.br; spf=pass smtp.mailfrom=renesp.com.br; dkim=pass (1024-bit key) header.d=renesp.com.br header.i=@renesp.com.br header.b=itnVwPgV; dkim=fail (1024-bit key) header.d=tempos-project.org header.i=@tempos-project.org header.b=wAXOzVcL reason="signature verification failed"; dkim=fail (1024-bit key) header.d=renesp.com.br header.i=@renesp.com.br header.b=U0efjVcb reason="signature verification failed"; arc=none smtp.client-ip=45.231.133.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=renesp.com.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesp.com.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesp.com.br header.i=@renesp.com.br header.b="itnVwPgV";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=tempos-project.org header.i=@tempos-project.org header.b="wAXOzVcL";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=renesp.com.br header.i=@renesp.com.br header.b="U0efjVcb"
Received: from renesp.vps (renesp.com.br [127.0.0.1])
	by mail.renesp.com.br (Postfix) with ESMTP id 4hDp5d0fybz3xQy
	for <linux-watchdog@vger.kernel.org>; Tue,  4 Aug 2026 06:24:21 -0300 (-03)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=renesp.com.br;
	s=2021; t=1785835461;
	bh=vLC6sslm0qTVX+YlXDzk6GkiBKUVBBOBdoUk+Urw0Jc=;
	h=From:To:Cc:Subject:Date:From;
	b=itnVwPgVqmA9QMVoSMyV3gDleJC+HJxOQ/hBfOQ8aYfIdaB7pq5VIc9GfyBLSSZX4
	 9Vmwt2xqynlW7DOplngYFmphgb4l5iAVJ55T8WuJ3lmAmclcq0v8da7mzw9ITo0Q5Y
	 zAOK3COaWz3VKoWhXviVEspXcP5iWmfUTRVP1Z/s=
Authentication-Results: renesp.vps (amavisd-new); dkim=pass (1024-bit key)
	reason="pass (just generated, assumed good)"
	header.d=tempos-project.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
	tempos-project.org; h=content-transfer-encoding:content-type
	:mime-version:x-mailer:message-id:date:subject:to:from; s=dkim;
	 t=1785835460; x=1788427461; bh=vLC6sslm0qTVX+YlXDzk6GkiBKUVBBOB
	doUk+Urw0Jc=; b=wAXOzVcL2F+1WikbJSsl+rgjNaw95++3H68Kx27lNM3cOXzk
	VAcHKuROomjNE9yydEEgMCElufA8D/YTtbrIPmkYtFRiAeox5Hz5z+hSBWG55tHU
	QossZWghxklDMsFHeCGOzv8rLYtDIMPxpwvUYdoEOx5uDhF1lRYJ2QsFh3M5RiPu
	rgM7dQE/ikkxkkO+3GqJ6M0OYvnw3JOhhtsOstYwxXjO5JseEyPqNfBlaLm7kOv7
	ThKw+N9DtJqQPLkUZky6KXPK/VAN51ijo5zGM1ZjIG51SF3y9cGHcv25TiS6yWdb
	h7TuliUxFSpcOh5zyn9rf9PRr3PCc/zDAeLocw==
X-Virus-Scanned: Debian amavisd-new at renesp.vps
X-Spam-Flag: NO
X-Spam-Score: 3.71
X-Spam-Level: ***
Authentication-Results: renesp.vps (amavisd-new); dkim=fail (1024-bit key)
	reason="fail (body has been altered)" header.d=renesp.com.br
Received: from mail.renesp.com.br ([127.0.0.1])
	by renesp.vps (renesp.vps [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id uDxmVqtKxALW for <linux-watchdog@vger.kernel.org>;
	Tue,  4 Aug 2026 06:24:20 -0300 (-03)
Received: from rsp-x1 (unknown [212.86.61.58])
	by mail.renesp.com.br (Postfix) with ESMTPSA id 4hDp5Z5C55z3wqs;
	Tue,  4 Aug 2026 06:24:18 -0300 (-03)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=renesp.com.br;
	s=2021; t=1785835460;
	bh=yYxFpLYa49jUtmtIu7iRYDbXhf+DJvoksilbW0xqnBc=;
	h=From:To:Cc:Subject:Date:From;
	b=U0efjVcbjdv1uv6Bk4dQiStw1hkiEdiKI/EzacRKiO+nr+PUolGfCKk6jnyujDp/u
	 6wnFxlrEu34NspRix1BdzQzpZdmF8QFY7nBEm+AHCUY5phg4IvJHb6q5MJC/VS/NMS
	 MnZODPT3wUI2UBBoZ8LZa2uDr7qg7LzrSjYR+jOE=
From: =?UTF-8?q?Ren=C3=AA=20de=20Souza=20Pinto?= <rene@renesp.com.br>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-watchdog@vger.kernel.org (open list:WATCHDOG DEVICE DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Cc: =?UTF-8?q?Ren=C3=AA=20de=20Souza=20Pinto?= <rene@renesp.com.br>
Subject: [PATCH] watchdog: wdat_wdt: map registers that fall inside ACPI NVS
Date: Tue,  4 Aug 2026 11:23:37 +0200
Message-ID: <20260804092337.3556947-1-rene@renesp.com.br>
X-Mailer: git-send-email 2.53.0
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

This commit fixes this issue by falling back to devm_memremap() when
devm_ioremap_resource() fails with -EBUSY on an ACPI NVS region.

Signed-off-by: Ren=C3=AA de Souza Pinto <rene@renesp.com.br>
---
 drivers/watchdog/wdat_wdt.c | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/drivers/watchdog/wdat_wdt.c b/drivers/watchdog/wdat_wdt.c
index dd3c2d69c9df..a56224cf8d22 100644
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
@@ -309,6 +311,33 @@ static struct watchdog_ops wdat_wdt_ops =3D {
 	.set_timeout =3D wdat_wdt_set_timeout,
 };
=20
+static void __iomem *wdat_wdt_map_mem(struct device *dev, struct resourc=
e *res)
+{
+	resource_size_t size =3D resource_size(res);
+	void __iomem *reg;
+	void *addr;
+
+	/* Try standard reservation + ioremap first */
+	reg =3D devm_ioremap_resource(dev, res);
+	if (!IS_ERR(reg) || PTR_ERR(reg) !=3D -EBUSY)
+		return reg;
+
+	/* If busy, check if conflict is due to ACPI NVS memory */
+	if (region_intersects(res->start, size, IORESOURCE_MEM,
+			      IORES_DESC_ACPI_NV_STORAGE) !=3D REGION_INTERSECTS)
+		return reg; /* Real conflict, return -EBUSY */
+
+	dev_warn(dev, "%pR is inside ACPI NVS, mapping without reservation\n", =
res);
+
+	addr =3D devm_memremap(dev, res->start, size, MEMREMAP_WB);
+	if (IS_ERR(addr)) {
+		dev_err(dev, "failed to map resource %pR\n", res);
+		return IOMEM_ERR_PTR(PTR_ERR(addr));
+	}
+
+	return (void __iomem __force *)addr;
+}
+
 static int wdat_wdt_probe(struct platform_device *pdev)
 {
 	struct device *dev =3D &pdev->dev;
@@ -362,7 +391,7 @@ static int wdat_wdt_probe(struct platform_device *pde=
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


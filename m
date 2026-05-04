Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F18C3E4C7B;
	Mon,  4 May 2026 18:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777917746; cv=none; b=GxKJoFGFm+/8azoNRUEKW/+pYJ/ARBoSOUrgNouPfKxg64zOpgCZodQw4Xeke4EhWg7B5hQNZOgcypY7G45ygsg/Plo9wzif0GnTk8mbVGlMemNXrh0xQKZyi++tRhr9IIoWKzEZ7Oo54E33mCYyW3mRC9O+jUCXoklPbZgGaiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777917746; c=relaxed/simple;
	bh=0BI2URTMc/P7NCL99eOZ7SYEHC+QibMLWmOFBGG4/DQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZYyAvLkNp1/2hPQIclVb++/2tXUe6nzGGsHbUsk8zXdMe2cHXGXLktldjBxYjX8CsGkV3qetPdI55yrS7etJOsATxGb1YFDiXYnN3Chbf0iXzp2rK892kK0xNchRQD/4gNMa695VeUvgP3JXpIJ/RXtm7OB00zTCT9KMY/u9c+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=squebb.ca; spf=pass smtp.mailfrom=squebb.ca; dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b=XUaWTF5Q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PNoz60Ng; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squebb.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b="XUaWTF5Q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PNoz60Ng"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id C127CEC0353;
	Mon,  4 May 2026 14:02:23 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 04 May 2026 14:02:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1777917743; x=
	1778004143; bh=H1Ub4obagX3MQgrpnYM6yE/N7GVlP/Fad+jKC/1DgZo=; b=X
	UaWTF5Qiv6URsdUhG24t89kR9y131JgCSSrz2mSgzXH8NjYfGYXsh66lr7g01Wvr
	h8qvHSUYVjA8+A4yRxd40K5rg54izwmAp57IT8l2nTI9gUKlWMiCdCE7XA/WLpYi
	fxAaPHi+/JsIn8yV9Z0ujKCCN79mXnIySHKiNvV/pum+ywzBJ40/pqIXjs5CqlNY
	4A13Rlm6oU6zRCYIDZLhuH/PJFqqmjRb3XDc7dCnyGvJKIXpKVjbYXZsBOYT7vJY
	0jA/Mb3YLcI1+0ndNePsPQNvNo+LH6HlJTL8iuVW6MRqaQ/LoHOOtetzwjFAY2Sy
	32yAsIzgGmscBIKZu69Mg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1777917743; x=1778004143; bh=H
	1Ub4obagX3MQgrpnYM6yE/N7GVlP/Fad+jKC/1DgZo=; b=PNoz60Ng2b8jcF1nG
	KrNLzSA1l98UhccSu/hW/PaWYtKuCEUvEoSWFa/dLZShWBFBD5tjuVZWbg7GbcCo
	pFoEBd3gKEaAbKn74SrlduiWuhng6mkzoGCJMCcEUnw9REsI8TVE/GEClwbeCEDZ
	Tn6mUxpz0sX1xeGH5CToqeW6MTjiX+96DFJaX+KWfdB0AB0u7XVrOzGbcofjsLiI
	ZZgSihsLh7C0Y7oTWeJmr70tOUWH5zEr+KSvc7/7LiCSeQTEOgVng+Q2eRxMSemH
	xI1S3b82s6ygKIkaD23QmfvrJDHzN+3iOMt8xOmHdcf+d/2eZBfmqeWcg9V9LJfd
	Pw1gw==
X-ME-Sender: <xms:L9_4aV9Ig7UEwOJs9ZYrT9HgYyPSDBcLCmRP6luLjsjuNqF8kc1jKQ>
    <xme:L9_4abNUINuCz9GCcgmRYdA58gqta231QYpeJgXP9PuJHTHPSxWf5v2l1Kx-EgNzh
    YkY147flvCudUyPR8VX99Y0OzenX03GKqFcsNEgidUZYjr_BYL3Tik>
X-ME-Received: <xmr:L9_4aTGf9txXI_Bxpvbfa1jmWUqXa14at3ahNLM5hCO0XVbtk3ZhuJEy4zDPMCviK3SH3wopQQ9OjOh6pVBc7KveQ8A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdelleehudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecuogetfedtuddqtdduucdludehmdenucfjughrpefhvfevuf
    ffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforghrkhcurfgvrghrshhonhcu
    oehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssgdrtggrqeenucggtffrrghtth
    gvrhhnpeduleekvdfftdetieeutdefveefffdufeehkeeitefgtdeifeffudfhgeehfffh
    jeenucffohhmrghinhepshgrshhhihhkohdruggvvhenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmphgvrghrshhonhdqlhgvnhhovhhosehs
    qhhuvggssgdrtggrpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprh
    gtphhtthhopehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssgdrtggrpdhrtghp
    thhtohepfihimheslhhinhhugidqfigrthgthhguohhgrdhorhhgpdhrtghpthhtoheplh
    hinhhugiesrhhovggtkhdquhhsrdhnvghtpdhrtghpthhtoheplhhinhhugidqfigrthgt
    hhguohhgsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkh
    gvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:L9_4aZQnMOsB_gNoW_1fNgKExR6ZabAMJKeQ9vULE0OBRTtt1PwbwA>
    <xmx:L9_4aQsauZH-Lo3zYFzCK49C5jBnWRpj3fWRobddS4IGNfcLGJ-6Xg>
    <xmx:L9_4aRI6y9xhYYX5GqzxfFStgnaZVONPcIBpGjjapGu5t6Sn34Ts9g>
    <xmx:L9_4aVlADwZmJSvda2oNeg9pTielXCn1O8kl2gr6jMniNU5DtNqQ6w>
    <xmx:L9_4aUZChrrZPeIJjALnxil7q_EtBDNvhC0Wj77dPa7X8EmlAHpDpeC6>
Feedback-ID: ibe194615:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 May 2026 14:02:22 -0400 (EDT)
From: Mark Pearson <mpearson-lenovo@squebb.ca>
To: mpearson-lenovo@squebb.ca
Cc: wim@linux-watchdog.org,
	linux@roeck-us.net,
	linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] watchdog: lenovo_se10_wdt: Fix use-after-free and resource leak risk
Date: Mon,  4 May 2026 14:01:42 -0400
Message-ID: <20260504180159.999189-1-mpearson-lenovo@squebb.ca>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <mpearson-lenovo@squebb.ca>
References: <mpearson-lenovo@squebb.ca>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Review by sashiko.dev highlighted potential use after free and resource
leak instances.

Set se10_pdev to null to prevent use after free

Remove DMI call back and instead directly call
se10_create_platform_device. Handle error cases appropriately

Link: https://sashiko.dev/#/patchset/20260428124954.1193450-1-mpearson-lenovo%40squebb.ca

Signed-off-by: Mark Pearson <mpearson-lenovo@squebb.ca>
---
 drivers/watchdog/lenovo_se10_wdt.c | 32 ++++++++++++++----------------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/drivers/watchdog/lenovo_se10_wdt.c b/drivers/watchdog/lenovo_se10_wdt.c
index 99ff01af4124..503e220263f9 100644
--- a/drivers/watchdog/lenovo_se10_wdt.c
+++ b/drivers/watchdog/lenovo_se10_wdt.c
@@ -224,7 +224,7 @@ static struct platform_driver se10_wdt_driver = {
 	.probe  = se10_wdt_probe,
 };
 
-static int se10_create_platform_device(const struct dmi_system_id *id)
+static int se10_create_platform_device(void)
 {
 	int err;
 
@@ -233,9 +233,10 @@ static int se10_create_platform_device(const struct dmi_system_id *id)
 		return -ENOMEM;
 
 	err = platform_device_add(se10_pdev);
-	if (err)
+	if (err) {
 		platform_device_put(se10_pdev);
-
+		se10_pdev = NULL;
+	}
 	return err;
 }
 
@@ -246,7 +247,6 @@ static const struct dmi_system_id se10_dmi_table[] __initconst = {
 			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
 			DMI_MATCH(DMI_PRODUCT_NAME, "12NH"),
 		},
-		.callback = se10_create_platform_device,
 	},
 	{
 		.ident = "LENOVO-SE10",
@@ -254,7 +254,6 @@ static const struct dmi_system_id se10_dmi_table[] __initconst = {
 			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
 			DMI_MATCH(DMI_PRODUCT_NAME, "12NJ"),
 		},
-		.callback = se10_create_platform_device,
 	},
 	{
 		.ident = "LENOVO-SE10",
@@ -262,7 +261,6 @@ static const struct dmi_system_id se10_dmi_table[] __initconst = {
 			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
 			DMI_MATCH(DMI_PRODUCT_NAME, "12NK"),
 		},
-		.callback = se10_create_platform_device,
 	},
 	{
 		.ident = "LENOVO-SE10",
@@ -270,7 +268,6 @@ static const struct dmi_system_id se10_dmi_table[] __initconst = {
 			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
 			DMI_MATCH(DMI_PRODUCT_NAME, "12NL"),
 		},
-		.callback = se10_create_platform_device,
 	},
 	{
 		.ident = "LENOVO-SE10",
@@ -278,7 +275,6 @@ static const struct dmi_system_id se10_dmi_table[] __initconst = {
 			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
 			DMI_MATCH(DMI_PRODUCT_NAME, "12NM"),
 		},
-		.callback = se10_create_platform_device,
 	},
 	{
 		.ident = "LENOVO-SE10-G2",
@@ -286,7 +282,6 @@ static const struct dmi_system_id se10_dmi_table[] __initconst = {
 			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
 			DMI_MATCH(DMI_PRODUCT_NAME, "13LJ"),
 		},
-		.callback = se10_create_platform_device,
 	},
 	{
 		.ident = "LENOVO-SE10-G2",
@@ -294,7 +289,6 @@ static const struct dmi_system_id se10_dmi_table[] __initconst = {
 			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
 			DMI_MATCH(DMI_PRODUCT_NAME, "13LK"),
 		},
-		.callback = se10_create_platform_device,
 	},
 	{
 		.ident = "LENOVO-SE10-G2",
@@ -302,7 +296,6 @@ static const struct dmi_system_id se10_dmi_table[] __initconst = {
 			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
 			DMI_MATCH(DMI_PRODUCT_NAME, "13S1"),
 		},
-		.callback = se10_create_platform_device,
 	},
 	{
 		.ident = "LENOVO-SE10-G2",
@@ -310,7 +303,6 @@ static const struct dmi_system_id se10_dmi_table[] __initconst = {
 			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
 			DMI_MATCH(DMI_PRODUCT_NAME, "13S2"),
 		},
-		.callback = se10_create_platform_device,
 	},
 	{
 		.ident = "LENOVO-SE10-G2",
@@ -318,7 +310,6 @@ static const struct dmi_system_id se10_dmi_table[] __initconst = {
 			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
 			DMI_MATCH(DMI_PRODUCT_NAME, "13S3"),
 		},
-		.callback = se10_create_platform_device,
 	},
 	{
 		.ident = "LENOVO-SE10-G2",
@@ -326,7 +317,6 @@ static const struct dmi_system_id se10_dmi_table[] __initconst = {
 			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
 			DMI_MATCH(DMI_PRODUCT_NAME, "13S4"),
 		},
-		.callback = se10_create_platform_device,
 	},
 	{
 		.ident = "LENOVO-SE10-G2",
@@ -334,7 +324,6 @@ static const struct dmi_system_id se10_dmi_table[] __initconst = {
 			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
 			DMI_MATCH(DMI_PRODUCT_NAME, "13S5"),
 		},
-		.callback = se10_create_platform_device,
 	},
 	{
 		.ident = "LENOVO-SE10-G2",
@@ -342,7 +331,6 @@ static const struct dmi_system_id se10_dmi_table[] __initconst = {
 			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
 			DMI_MATCH(DMI_PRODUCT_NAME, "13S6"),
 		},
-		.callback = se10_create_platform_device,
 	},
 	{}
 };
@@ -350,10 +338,20 @@ MODULE_DEVICE_TABLE(dmi, se10_dmi_table);
 
 static int __init se10_wdt_init(void)
 {
+	int err;
+
 	if (!dmi_check_system(se10_dmi_table))
 		return -ENODEV;
 
-	return platform_driver_register(&se10_wdt_driver);
+	err = platform_driver_register(&se10_wdt_driver);
+	if (err)
+		return err;
+
+	err = se10_create_platform_device();
+	if (err)
+		platform_driver_unregister(&se10_wdt_driver);
+
+	return err;
 }
 
 static void __exit se10_wdt_exit(void)
-- 
2.43.0


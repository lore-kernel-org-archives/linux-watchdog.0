Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3279243E4B1;
	Tue, 28 Apr 2026 12:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777380604; cv=none; b=El9+b3fpdfpOF9z9/1f0n3VejLYHg7gii4PPy1aM40a39mhNaJHEz2oxXLe+Kb3rwLnFB4r8zw1IlqMjU3BBnSrsnxxQp1UwnfmoNJlJVScT9CZk+xcNPW0PchTV0TVGdKlZ94jeqdFF+MdF4k6RjgzoTKxmpYyooHrAmSSyH48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777380604; c=relaxed/simple;
	bh=b1HxMZvYfURLMrPVglyF9BSZKCjP2scSbALbKd4J/GI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QVNONXdKsbhYTyPHHSRHuW4c2ewauVsusBEXATz0OSpm9qiPXin4T28o0K4IfMzg0mQN2uvry2M4+emyNklzDW/d9WrRk79MWgo3OHOz/oW4WfseRBJPhew5uEOZbUu6TuMGMF+6JrDw6Fkv6n8sPdWC1krtPflIu1W53HTi+wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=squebb.ca; spf=pass smtp.mailfrom=squebb.ca; dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b=DhFWNImr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RuoNjg37; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squebb.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b="DhFWNImr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RuoNjg37"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B9D3A7A0064;
	Tue, 28 Apr 2026 08:49:58 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 28 Apr 2026 08:49:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1777380598; x=
	1777466998; bh=MchoJJuD23DJTgD8pjsY1udsCA7FOyF37PpdsskLNUQ=; b=D
	hFWNImr3XYG0KKJ9jdCweCw2ZHWi9xL8tK6LqsW4EePpxkNAKgu3cIPZZFRPqjKG
	0xD5DXwCklcF7fkXYyw+kZNdzsN+8qvktz1gXqbbbfE/hm/nPKlnZQUpCKrw97LH
	AdKL7p2QBUC4MNget7PaOzb68p3b7z5s0ZHfEpQmRyrLjrYJGgtV3iwUKAXKK5wL
	4TsqQkhk33YodpokPC0neFZQdOLk/Rmvh/Ze43XYvejVtF4HxvlQnAesU/d9EUEh
	ICKdvijJ8IOeTRsLvnzhwxdl0McdxllofSoyi7h8LKCzqH1FmoCQjrsIZIIFcNEm
	ubIiYEPktrwsslVFpBw3A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1777380598; x=1777466998; bh=M
	choJJuD23DJTgD8pjsY1udsCA7FOyF37PpdsskLNUQ=; b=RuoNjg37FTwn/ke58
	BST/WR5G2mztGHH53Ri/DFwdhcgBF7DdMm7dUjV9Z0ht1Re70XocgkU1qerVAHGX
	xs2/yt3fL0CfcVk19UHl7eW7RJtnaFQYw6t4iQZjFEPRN63uc1GL4yfPZYvi+ZEw
	JA+hQv+45qQqn1vtyWwDjlbUoL69NijqWCuKGKYhMVvDrOImJZ3jjdQmEAB1VLBK
	4Krw3KY4m1yCz2MrRcGX9J5666LlVfJZH0SY1jRa5jwhd2SkQKCNDtZPtps9hMqY
	S+pYZb2/0nD7zn3Mh3QMo4khnQSe/L0xT+5SWul0oCNwMPToI80+yd8DxNkeiR3H
	75NVw==
X-ME-Sender: <xms:9azwaS0pkFqF8U5IctnjL4U5Bg64dapauNrhfr9pyAl1gMQ8fmKXgg>
    <xme:9azwaWkgfZUjCmKDTuE2Do0kwtIb3arSyh69gsZGxOgCki2N1bHA3fFiAnQu6uDsy
    xWRS93v0sO_BwDkZyOEnIt_U-be5-hDcL13VHdxFQl11c0BenP9zF7n>
X-ME-Received: <xmr:9azwaa_fRjUPKhZDaCw8A_4GlPAIcTcmcq8-OzQySeM4wfttVUbaXKNMCZycyMOZJy2eycdBN3IZ7M6KBY6M4udRvdQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdekudeitdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecuogetfedtuddqtdduucdludehmdenucfjughrpefhvfevuf
    ffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforghrkhcurfgvrghrshhonhcu
    oehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssgdrtggrqeenucggtffrrghtth
    gvrhhnpeeftddvjeefleffvefhgfejjeehudetteeigeeugfekhffhgeejudeuteehgfdv
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmph
    gvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssgdrtggrpdhnsggprhgtphhtthhopeeh
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmphgvrghrshhonhdqlhgvnhhovh
    hosehsqhhuvggssgdrtggrpdhrtghpthhtohepfihimheslhhinhhugidqfigrthgthhgu
    ohhgrdhorhhgpdhrtghpthhtoheplhhinhhugiesrhhovggtkhdquhhsrdhnvghtpdhrtg
    hpthhtoheplhhinhhugidqfigrthgthhguohhgsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorh
    hg
X-ME-Proxy: <xmx:9azwaTrRdFcTmqXjJnlQLriPrt7TNQ8noXFbkzKGTbHYG8cXPpdrVw>
    <xmx:9azwabl5aLRtO7UQ2DgR-p6YauEw22kmJC_Prg6CoMrVe1Ye0oCKJQ>
    <xmx:9azwaShL1UnIf0E_PDZkPOOQuoSFf4PIRnMqI7h_XAOj4ddsM3D5iw>
    <xmx:9azwabdK-lJba-9dTPKdsR8CfwklQ6aYevFqiMNiFt6Avvhy7R-1gg>
    <xmx:9qzwaRzDfrt0SQ9toCCtUrzLeaGBW3DhhecmxbM4axy9daHDL1lSjXEw>
Feedback-ID: ibe194615:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Apr 2026 08:49:57 -0400 (EDT)
From: Mark Pearson <mpearson-lenovo@squebb.ca>
To: mpearson-lenovo@squebb.ca
Cc: wim@linux-watchdog.org,
	linux@roeck-us.net,
	linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] watchdog: lenovo_se10_wdt: Add support for SE10 Gen 2 platform
Date: Tue, 28 Apr 2026 08:49:44 -0400
Message-ID: <20260428124954.1193450-1-mpearson-lenovo@squebb.ca>
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

The Lenovo SE10 Gen 2 platform uses a watchdog chip from the same family.
Watchdog functionality is the same, so update the driver with the new chip
ID.

Add the Gen 2 MTM's to enable support on the platform.

Tested on SE10 G2.

Signed-off-by: Mark Pearson <mpearson-lenovo@squebb.ca>
---
 drivers/watchdog/lenovo_se10_wdt.c | 66 +++++++++++++++++++++++++++++-
 1 file changed, 65 insertions(+), 1 deletion(-)

diff --git a/drivers/watchdog/lenovo_se10_wdt.c b/drivers/watchdog/lenovo_se10_wdt.c
index cd0500e5080b..99ff01af4124 100644
--- a/drivers/watchdog/lenovo_se10_wdt.c
+++ b/drivers/watchdog/lenovo_se10_wdt.c
@@ -178,7 +178,7 @@ static int se10_wdt_probe(struct platform_device *pdev)
 		return -EBUSY;
 
 	chip_id = get_chipID();
-	if (chip_id != 0x5632) {
+	if (chip_id != 0x5632 && chip_id != 0x5652) {
 		release_region(CFG_PORT, CFG_SIZE);
 		return -ENODEV;
 	}
@@ -280,6 +280,70 @@ static const struct dmi_system_id se10_dmi_table[] __initconst = {
 		},
 		.callback = se10_create_platform_device,
 	},
+	{
+		.ident = "LENOVO-SE10-G2",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "13LJ"),
+		},
+		.callback = se10_create_platform_device,
+	},
+	{
+		.ident = "LENOVO-SE10-G2",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "13LK"),
+		},
+		.callback = se10_create_platform_device,
+	},
+	{
+		.ident = "LENOVO-SE10-G2",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "13S1"),
+		},
+		.callback = se10_create_platform_device,
+	},
+	{
+		.ident = "LENOVO-SE10-G2",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "13S2"),
+		},
+		.callback = se10_create_platform_device,
+	},
+	{
+		.ident = "LENOVO-SE10-G2",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "13S3"),
+		},
+		.callback = se10_create_platform_device,
+	},
+	{
+		.ident = "LENOVO-SE10-G2",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "13S4"),
+		},
+		.callback = se10_create_platform_device,
+	},
+	{
+		.ident = "LENOVO-SE10-G2",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "13S5"),
+		},
+		.callback = se10_create_platform_device,
+	},
+	{
+		.ident = "LENOVO-SE10-G2",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "13S6"),
+		},
+		.callback = se10_create_platform_device,
+	},
 	{}
 };
 MODULE_DEVICE_TABLE(dmi, se10_dmi_table);
-- 
2.43.0


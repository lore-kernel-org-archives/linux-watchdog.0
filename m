Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=44.202.169.37
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793923030;
	b=aEuwl/MAtFLJfPNnKpnebjUr5ku5LgnZ8x41hCWUMJkAkqjhI6Tm0+zCvVub2ODSW/UA
	 L0KHrTnj3U+hEln/hL0V4j9mz9Q2eLq429sbs6cVkTKxxkT+bKGYbHnmpuWdLjCvIKUe2
	 Ylx1mF2oy1HmORqYT4uOw+iDnPEfB2DJEFC/XtrkImDC9QnZR033zpOqjwBWlmB3NPz2E
	 4I1WncAqtiD+kyl8QYWdURAxdnVzRwugPSYsJNfQ5SIYWfY0L2iIToFKUIJYnc/tajuWm
	 MwBYo3OeqZINw5qhHOHmv1c+BPunNh7IFuUPjkMvLKk5lN3QGpJmYdstA6Tycy3pTtQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793923030;
	h=DMARC-Filter:Received:Received:X-Authority-Analysis:DKIM-Signature:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-BWhitelist:X-Source-IP:X-Source-L:X-Exim-ID:
	 X-Source:X-Source-Args:X-Source-Dir:X-Source-Sender:X-Source-Auth:
	 X-Email-Count:X-Org:X-Source-Cap:X-Local-Domain:X-CMAE-Envelope;
	bh=jUdl3P7orTkYUi8VWpIFaNT1DoqVI6m8mJ1qiolLWeU=;
	b=ZrzwaKPH62GrvPtkmt6rmcun76pNifwzMyYgZLOhky3cYHKgyJm3lNtSXDbj4zyN6+mT
	 YTI6EufivflnwNnalBemPiljBIkae+VXDZg3oAamHcLBfHXALq4adlbAtBSVYSb3S2x8X
	 GzJJccPiXIE0yunR4VvMTERENCSWLfpVmMWHJ7+5kMP7qinFYMRuC4LxYaB7i4NhUjMXk
	 zKguzW33zZX5/oxf+zPZsWu5gV+VNrER3BCcWKbjk1gwarpLhwAntW/OSehG5SNDTUoC3
	 edJEIMvkCo+BSWNJs8/fyXjlTFrPHUuEDmEI7+jSwTsqnRbMBv56EJShoPVgJle1OKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=roeck-us.net;
	spf=fail smtp.mailfrom=roeck-us.net;
	dkim=pass header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=IQPizzVT;
	arc=none smtp.remote-ip=44.202.169.37
Received: from omta038.useast.a.cloudfilter.net (omta038.useast.a.cloudfilter.net [44.202.169.37])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9724606A31B
	for <linux-watchdog@vger.kernel.org>; Thu,  5 Nov 2026 23:57:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B9724606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=IQPizzVT
Received: from eig-obgw-6001b.ext.cloudfilter.net ([10.0.30.143])
	by cmsmtp with ESMTPS
	id OwZJxGm4sJFmFP7KOxg1A6; Thu, 05 Nov 2026 23:57:09 +0000
Received: from 162-215-252-36.unifiedlayer.com ([208.91.199.152])
	by cmsmtp with ESMTPS
	id P7KOxkboGmASCP7KOxc6kc; Thu, 05 Nov 2026 23:57:08 +0000
X-Authority-Analysis: v=2.4 cv=XJkwSRhE c=1 sm=1 tr=0 ts=6aed17d4
 a=QNED+QcLUkoL9qulTODnwA==:117 a=2cfIYNtKkjgZNaOwnGXpGw==:17
 a=zJRp6_cAMcgA:10 a=M0FbrtG7MMAA:10 a=c92rfblmAAAA:8 a=_jlGtV7tAAAA:8
 a=FdDBW6wVl6SQ9AgihE4A:9 a=GvGzcOZaWPEFPQC_NcjD:22 a=nlm17XC03S6CtCLSeiRr:22
 a=KPbNTLLc3YvdawN95zVk:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=roeck-us.net; s=default; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=jUdl3P7orTkYUi8VWpIFaNT1DoqVI6m8mJ1qiolLWeU=; b=IQPizzVTHxRZhMl8p+gWytT20t
	OsMFsQs5shPO2mmGzSNFDEM+5krsqKN27qZfElnFNv1Lkx0ulLDkqHsdoonLaJFu6i2sEA81PW3DG
	rz1EdMXGAPoRPtSjVdPvO81m0tKw6Hy7oh9f7L14Q6p5/PB+cvkqzWi4J86Q2cVPA/5EXBnb8aLnT
	yrLPhO5LPW5vV7K+J3gsWJDkrrOhHGDmToQdKRjz5AlrZ9M1EBkREab+Ci3fhd7I1B+4PanKkHOn7
	tpMa5pRpDTkzI/1yHoN2pXmhAI3PaseQSlU7ymAuFybMKhTrn0RUNEZxg9902eHMBaB5zXfILMDYe
	wtAEvOTQ==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:33334 helo=server.roeck-us.net)
	by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <linux@roeck-us.net>)
	id 1xP7KN-00000001AmN-3W2t;
	Fri, 06 Nov 2026 05:27:07 +0530
From: Guenter Roeck <linux@roeck-us.net>
To: linux-watchdog@vger.kernel.org
Cc: Guenter Roeck <linux@roeck-us.net>,
	Sashiko <sashiko@sashiko.dev>
Subject: [PATCH] watchdog: sp5100_tco: Use release_mem_region() for EFCH MMIO resource
Date: Thu,  5 Nov 2026 15:57:05 -0800
Message-ID: <20261105235705.2405271-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.45.2
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-BWhitelist: no
X-Source-IP: 108.223.40.66
X-Source-L: No
X-Exim-ID: 1xP7KN-00000001AmN-3W2t
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net (server.roeck-us.net) [108.223.40.66]:33334
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 51
X-Org: HG=direseller_whb_net_legacy;ORG=directi;
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfDuDaC8Jljp6JqS7zcrJzUEHQ2KbL8s2U95YhZX5Pr6RjYodXqKuwicbzjzrB401OVdlv8uHRGrrdt9ow64OZwaxq0nqrPUKeU2dD4W2C7bQzweeuVIq
 swKXxbBPFtHUsVRY3EBZA5nrOvKMx8boVkemTLFb/n3lkGR7SyGEnBRMEM+kNGHdZSbb1b3+CR8RH/7JCBPTsGkYwoP6ZG1aNJeI+uMSIUrFufsHPp2VFwd9

sp5100_tco_setupdevice_mmio() reserves the EFCH power management MMIO
region using request_mem_region_muxed(), which sets IORESOURCE_MUXED and
places concurrent requesters of the same region (such as i2c-piix4) to
sleep in TASK_UNINTERRUPTIBLE on muxed_resource_wait.

However, on exit, sp5100_tco_setupdevice_mmio() releases the region by
calling release_resource() and kfree() instead of release_mem_region().
Unlike __release_region(), release_resource() only unlinks the resource
from the tree without checking IORESOURCE_MUXED or waking up
muxed_resource_wait, leaving any task that contended on the muxed region
sleeping in TASK_UNINTERRUPTIBLE.

Replace release_resource() and kfree() with release_mem_region(), and
drop the now-unused struct resource pointer variable.

Fixes: 0578fff4aae5 ("Watchdog: sp5100_tco: Add initialization using EFCH MMIO")
Reported-by: Sashiko <sashiko@sashiko.dev>
Link: https://sashiko.dev/#/bug/linux-5038b175-de57-4915-a10c-03b16bad7c01
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/sp5100_tco.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/watchdog/sp5100_tco.c b/drivers/watchdog/sp5100_tco.c
index 14d4bffface4..385313fd1e88 100644
--- a/drivers/watchdog/sp5100_tco.c
+++ b/drivers/watchdog/sp5100_tco.c
@@ -407,16 +407,13 @@ static int sp5100_tco_setupdevice_mmio(struct device *dev,
 	struct sp5100_tco *tco = watchdog_get_drvdata(wdd);
 	const char *dev_name = SB800_DEVNAME;
 	u32 mmio_addr = 0, alt_mmio_addr = 0;
-	struct resource *res;
 	void __iomem *addr;
 	int ret;
 	u32 val;
 
-	res = request_mem_region_muxed(EFCH_PM_ACPI_MMIO_PM_ADDR,
-				       EFCH_PM_ACPI_MMIO_PM_SIZE,
-				       "sp5100_tco");
-
-	if (!res) {
+	if (!request_mem_region_muxed(EFCH_PM_ACPI_MMIO_PM_ADDR,
+				      EFCH_PM_ACPI_MMIO_PM_SIZE,
+				      "sp5100_tco")) {
 		dev_err(dev,
 			"Memory region 0x%08x already in use\n",
 			EFCH_PM_ACPI_MMIO_PM_ADDR);
@@ -467,8 +464,8 @@ static int sp5100_tco_setupdevice_mmio(struct device *dev,
 	if (addr)
 		iounmap(addr);
 
-	release_resource(res);
-	kfree(res);
+	release_mem_region(EFCH_PM_ACPI_MMIO_PM_ADDR,
+			   EFCH_PM_ACPI_MMIO_PM_SIZE);
 
 	return ret;
 }
-- 
2.45.2


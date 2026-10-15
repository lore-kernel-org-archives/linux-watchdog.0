Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE29D45D923;
	Thu, 15 Oct 2026 06:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792046422; cv=none; b=ZBmtWClD2UfhImkLEHyweWNqsfAoS7KT4uNz+0qKFQkBSsspDdnvpowt29iQKVx76/a4D8xEchj+z1z+JpFtOP69EEi/jiPjd8Z9nZ8MsS5nRWYGctVJVfoiUEXD5KedFtFtqOABDLsij60xyCUmqvmjEB/SBLsfVSiZcMhGBRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792046422; c=relaxed/simple;
	bh=MKobunclOIQv11lpqz95lEbwsBSJiQXTtnEgI/bO11M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lGj8fUHSP5jTszw5WlMOQSbgr79hu2APNPFrbso99Ino0qRFoypb4lHrfZ4dFqIDDOgDQlVY6mky8vM81ME6beje/f3XiK6A7LuD+kN+kfJi154xs+7aqtHwasVCIkYh5Y0hY8ZmrlVT5R1MvUSUJgZ+w8l3w6CROW1sq0TqDyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=isrc.iscas.ac.cn; spf=pass smtp.mailfrom=isrc.iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=isrc.iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isrc.iscas.ac.cn
Received: from shanyun-openeuler-01.cloud.onecloud.io (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowABXwDpnc9Bq6gxxCw--.3876S2;
	Thu, 15 Oct 2026 14:32:14 +0800 (CST)
From: Qiwen Gong <qiwen.neosys@isrc.iscas.ac.cn>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-watchdog@vger.kernel.org,
	Zwane Mwaikambo <zwanem@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	Qiwen Gong <qiwen.neosys@isrc.iscas.ac.cn>
Subject: [PATCH] watchdog: sc1200wdt: add missing MODULE_DEVICE_TABLE()
Date: Thu, 15 Oct 2026 06:25:56 +0000
Message-Id: <20261015062556.3362356-1-qiwen.neosys@isrc.iscas.ac.cn>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowABXwDpnc9Bq6gxxCw--.3876S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtF4fXrWkCr18XFWfWF1ftFb_yoWDGFbEka
	4UZr9xurnYkryFka1UJwn5ur1I9w4qqF4jgr48ta93J3s2yw1DuFZxZrn5Ja4Yq3y8ZF1U
	Cw1kXF1UCFy5KjkaLaAFLSUrUUUUbb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb4xFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Jr0_
	Gr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr
	1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1q6rW5McIj6I8E87Iv67AKxVW8Jr0_Cr1UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_
	JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8
	JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0JU6HqcUUU
	UU=
X-CM-SenderInfo: ptlzv04oqh0211v6x21ufox2xfdvhtffof0/

Add MODULE_DEVICE_TABLE(pnp, scl200wdt_pnp_devices) beside the
existing table.  

Built with CONFIG_COMPILE_TEST=y and CONFIG_PNP=y.  modinfo of
sc1200wdt.ko shows pnp:dNSC0800* and acpi*:NSC0800:* only after this
change. 

Found by comparing the id_table with module-alias publication.

Signed-off-by: Qiwen Gong <qiwen.neosys@isrc.iscas.ac.cn>
---
 drivers/watchdog/sc1200wdt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/watchdog/sc1200wdt.c b/drivers/watchdog/sc1200wdt.c
index 1d3300c98d43..0dddd18d11aa 100644
--- a/drivers/watchdog/sc1200wdt.c
+++ b/drivers/watchdog/sc1200wdt.c
@@ -342,6 +342,7 @@ static const struct pnp_device_id scl200wdt_pnp_devices[] = {
 	{ .id = "NSC0800" },
 	{ }
 };
+MODULE_DEVICE_TABLE(pnp, scl200wdt_pnp_devices);
 
 static int scl200wdt_pnp_probe(struct pnp_dev *dev,
 					const struct pnp_device_id *dev_id)

base-commit: 24a19b953e2a3d0ea5a8c4951a0ab8f32720c907
-- 
2.33.0


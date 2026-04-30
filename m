Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1FA6423A68;
	Thu, 30 Apr 2026 15:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777563818; cv=none; b=YPXJhDsOQ5T7mDtW3f60oIvZMgNhgt5yTM8bNIAShjCqyShWA3KWcu7/8pR5UJE52hOTpC4Ya+FvvQ0sN1fcgpFdXe8hBMa6GjCJzKuH7KUfJVOxoxZ0CWOKkT44TN46E0HWLOL1db4jC7bhIfuBM0SjCexC4Eb/VRItErTJI6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777563818; c=relaxed/simple;
	bh=XzPQg8uzIzpuaNB9NppZBAapr/7eZdS900Nu8vyypD8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=acoJS3NfWl2ja0XO7PNHQzukY/4oyLYQ1Yot6VJt3llteNJn2ihEsxflzabeNSmGPV/eJm+1IQJrihoSYlkkCzNu5ZxY5TWTuY3Nd4AmpFvHccWLGmBHIxGgtdshFNCc4vm91mgRKcQm+C4j59NgxCjIXeQDDm1SFG2wp2I5mS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=FvmiBQvN; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="FvmiBQvN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=jz
	p+h4KafoOcPPk0Iroo+60EOPfusciQ1mk47M4Rwkg=; b=FvmiBQvNUjpBTOlpMC
	T2AVftbvrnJ7GehRpHxiIdeJPnzICA9NHly2P5KryF7j3gTZewxAkJt3EJCLYq3N
	vFtcNhTKVAAJ8SqYc3QJxJZChKh8sKiM7ySmUzRbr4fjSaD5AX8xsQSFSlvobE6W
	aWZULA5f3a1oIqCbTfuUVgLfk=
Received: from zhb.. (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgCXnvNqePNpymQDCA--.4210S2;
	Thu, 30 Apr 2026 23:42:35 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: sander@svanheule.net,
	wim@linux-watchdog.org,
	linux@roeck-us.net
Cc: linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH] watchdog: realtek_otto: Use FIELD_MODIFY()
Date: Thu, 30 Apr 2026 23:42:30 +0800
Message-Id: <20260430154230.34218-1-18255117159@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PygvCgCXnvNqePNpymQDCA--.4210S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7urW7uF4fKF4fZr4rJw13urg_yoW8WFW5pF
	45Jrs2g3Z8tF1j9Fy29FsrZw18Ca92grn2qr45G393uFnIyrn8tayrK395KFWxJFW8XFW2
	9F1rJ348Ga98Aw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRQTmcUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbCxAuPM2nzeGv+wgAA3G

Use FIELD_MODIFY() to remove open-coded bit manipulation.
No functional change intended.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/watchdog/realtek_otto_wdt.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/watchdog/realtek_otto_wdt.c b/drivers/watchdog/realtek_otto_wdt.c
index 2c30ddd574c5..cf4841583721 100644
--- a/drivers/watchdog/realtek_otto_wdt.c
+++ b/drivers/watchdog/realtek_otto_wdt.c
@@ -149,11 +149,9 @@ static int otto_wdt_determine_timeouts(struct watchdog_device *wdev, unsigned in
 		|| phase2_ticks > OTTO_WDT_PHASE_TICKS_MAX);
 
 	v = ioread32(ctrl->base + OTTO_WDT_REG_CTRL);
-
-	v &= ~(OTTO_WDT_CTRL_PRESCALE | OTTO_WDT_CTRL_PHASE1 | OTTO_WDT_CTRL_PHASE2);
-	v |= FIELD_PREP(OTTO_WDT_CTRL_PHASE1, phase1_ticks - 1);
-	v |= FIELD_PREP(OTTO_WDT_CTRL_PHASE2, phase2_ticks - 1);
-	v |= FIELD_PREP(OTTO_WDT_CTRL_PRESCALE, prescale);
+	FIELD_MODIFY(OTTO_WDT_CTRL_PHASE1, &v, phase1_ticks - 1);
+	FIELD_MODIFY(OTTO_WDT_CTRL_PHASE2, &v, phase2_ticks - 1);
+	FIELD_MODIFY(OTTO_WDT_CTRL_PRESCALE, &v, prescale);
 
 	iowrite32(v, ctrl->base + OTTO_WDT_REG_CTRL);
 
@@ -279,8 +277,7 @@ static int otto_wdt_probe_reset_mode(struct otto_wdt_ctrl *ctrl)
 		return -EINVAL;
 
 	v = ioread32(ctrl->base + OTTO_WDT_REG_CTRL);
-	v &= ~OTTO_WDT_CTRL_RST_MODE;
-	v |= FIELD_PREP(OTTO_WDT_CTRL_RST_MODE, mode);
+	FIELD_MODIFY(OTTO_WDT_CTRL_RST_MODE, &v, mode);
 	iowrite32(v, ctrl->base + OTTO_WDT_REG_CTRL);
 
 	return 0;

base-commit: 3b3bea6d4b9c162f9e555905d96b8c1da67ecd5b
-- 
2.34.1


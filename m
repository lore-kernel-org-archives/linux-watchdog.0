Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A31A8201025;
	Mon, 12 Oct 2026 00:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791766026; cv=none; b=l0k2W+wEn1Wk9fOiT+tJnQd0zS68ba0PNVTsF2lZG19idfiFe9STdi0fcNmpUoJjAkX6TK54yO2uGM15zw+Xb4Tfy3WcNMW2qNu3OMtONsz936rkmZGhiUzU3qvnB/Ow4Ukkzg2yAmKfijiXYLQtUq33+L3zaUV30XeSK5SyD0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791766026; c=relaxed/simple;
	bh=dZk5fmXgsz+r5VIo/VmzrOjb6rsRx0hZ8V/toBGnvCU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nyohYgxxAxwM7+RNWt2rxhT8dJX1iK1sYHIGGw3L22cFLRBzVApi94QtZXZoV04Q6cCzs0rj9xbCuAbfl1RVpnciDPptXRXll6f3MErg5v2m/L/X3uuth6SlW8hxN34QN1Srkg4WFcGpvGM/wZijUti+1dkcQ/gbIL3rga1Xy7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MErjxKul; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MErjxKul"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 569FDC2BCFB;
	Mon, 12 Oct 2026 00:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1791766026;
	bh=dZk5fmXgsz+r5VIo/VmzrOjb6rsRx0hZ8V/toBGnvCU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=MErjxKuljRPpVF1FwC4skFlgBZb2m8ObU1gSy8u04zoBPPbgSgPsZyn9nssFNvZJ8
	 lN2GRjADqL7tzWO60/OYJwm3dMwU6B2YTM5NuWuYsvosDMB0IwuJEWwjL8slyOExvq
	 kTBCaEj0jA2PW7CPkD8ZgFUZdfGz2M4C5/AN9P/1Zrzemwc8r6xtvRyV1fNlwsUeGk
	 c3++p+TSHLc7qenjYuVSN59UhGDyZu2s+G9TIGcOLuB8VYYWNEQDFuZwoBsyXelc6v
	 QCb92C1fpEzYY1G5GT70Neehy7GVt9EZcEdy7va6EQmHy8KZXTGRMQcp6bwyx4ZIID
	 86KFmJb5u6f/w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4594DCA9ECF;
	Mon, 12 Oct 2026 00:47:06 +0000 (UTC)
From: Igor Velkov via B4 Relay <devnull+iav.iav.lv@kernel.org>
Date: Mon, 12 Oct 2026 03:46:57 +0300
Subject: [PATCH v2 2/2] watchdog: orion_wdt: stop the watchdog during
 system suspend
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-orion-wdt-suspend-v2-2-f13cf71443ba@iav.lv>
References: <20261012-orion-wdt-suspend-v2-0-f13cf71443ba@iav.lv>
In-Reply-To: <20261012-orion-wdt-suspend-v2-0-f13cf71443ba@iav.lv>
To: Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>
Cc: Chris Packham <chris.packham@alliedtelesis.co.nz>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, 
 linux-watchdog@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Igor Velkov <iav@iav.lv>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1912; i=iav@iav.lv;
 h=from:subject:message-id;
 bh=m0WVQELV++t0yRnZ+K7WZ1EmeGKm+T8Z3+Ko29NWjxU=;
 b=owGbwMvMwCVmNH1q96v4SmbG02pJDFln9Dj8o4y27ZLirOXWYRE658n9V6DD4MUXfdOdGfxT9
 f8Uy1t2lLIwiHExyIopskw4pHErY8nVv/4e5g9g5rAygQxh4OIUgImsCmf4n11+iK0naaZnYdxd
 lvrjOee/W3FYnQzyvSZwf+OarB3ZcQz/k2ODV3Os3uX6q9XbT2/Gh17hDlmXXIHrRvff/X7r+qu
 eDwA=
X-Developer-Key: i=iav@iav.lv; a=openpgp;
 fpr=90C228DA68A4D5FD4F4837E03297958BEA5F7903
X-Endpoint-Received: by B4 Relay for iav@iav.lv/default with auth_id=1060
X-Original-From: Igor Velkov <iav@iav.lv>
Reply-To: iav@iav.lv

From: Igor Velkov <iav@iav.lv>

The watchdog timer keeps counting across system suspend while the
userspace that pings it is frozen, so it expires and resets the system.
On a Kobol Helios4 (Armada 388) with a 60 s timeout the board resets
47-61 s into s2idle, whether the watchdog daemon or systemd's
RuntimeWatchdogSec holds the device.

Stop the timer on suspend and restart it on resume when it is active or
running in hardware, as sp805_wdt does. orion_wdt_start() reloads the
counter, so userspace gets a full timeout after resume.

Assisted-by: LLM
Signed-off-by: Igor Velkov <iav@iav.lv>
---
 drivers/watchdog/orion_wdt.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/watchdog/orion_wdt.c b/drivers/watchdog/orion_wdt.c
index ef64e3730001..c65042dc2329 100644
--- a/drivers/watchdog/orion_wdt.c
+++ b/drivers/watchdog/orion_wdt.c
@@ -671,6 +671,29 @@ static void orion_wdt_shutdown(struct platform_device *pdev)
 	orion_wdt_stop(wdt_dev);
 }
 
+static int orion_wdt_suspend(struct device *dev)
+{
+	struct watchdog_device *wdt_dev = dev_get_drvdata(dev);
+
+	if (watchdog_active(wdt_dev) || watchdog_hw_running(wdt_dev))
+		return orion_wdt_stop(wdt_dev);
+
+	return 0;
+}
+
+static int orion_wdt_resume(struct device *dev)
+{
+	struct watchdog_device *wdt_dev = dev_get_drvdata(dev);
+
+	if (watchdog_active(wdt_dev) || watchdog_hw_running(wdt_dev))
+		return orion_wdt_start(wdt_dev);
+
+	return 0;
+}
+
+static DEFINE_SIMPLE_DEV_PM_OPS(orion_wdt_pm_ops, orion_wdt_suspend,
+				orion_wdt_resume);
+
 static struct platform_driver orion_wdt_driver = {
 	.probe		= orion_wdt_probe,
 	.remove		= orion_wdt_remove,
@@ -678,6 +701,7 @@ static struct platform_driver orion_wdt_driver = {
 	.driver		= {
 		.name	= "orion_wdt",
 		.of_match_table = orion_wdt_of_match_table,
+		.pm	= pm_sleep_ptr(&orion_wdt_pm_ops),
 	},
 };
 

-- 
2.43.0



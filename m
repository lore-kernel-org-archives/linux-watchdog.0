Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=35.89.44.35
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793905541;
	b=EozoLEcu15TPdjwfVJIl6tSEObGfx3oHm0owfkwAkrF2cWB7w4DaPNEPc1ZsUK77Km+Y
	 mk9kO7xcAcnv+1sNbrrMZVdaY/9mbjipu73apfSO+EWH5aG0fIFhM3JYSDnKumgP0QnB5
	 ng5JVj09905pVFCf/dO+Kvo4IsetXfF/3IHgh4/Q2ixTlHYJ8ZKYSuPvAAPffLrxxzODi
	 K2OHD6OvMYYRvoD1lCUqHPihHJxnXXL2zbXB/2hO6+nk/DnICIIzB285GjN1xXke02dt5
	 Q3oXLbCqQ8U/xAFR6sGutIgQ6AfLQqXwG8+WYJaEy9cZcAO8JJHxm+Ly3Ff7knYN94Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793905541;
	h=DMARC-Filter:Received:Received:X-Authority-Analysis:DKIM-Signature:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-BWhitelist:
	 X-Source-IP:X-Source-L:X-Exim-ID:X-Source:X-Source-Args:X-Source-Dir:
	 X-Source-Sender:X-Source-Auth:X-Email-Count:X-Org:X-Source-Cap:
	 X-Local-Domain:X-CMAE-Envelope;
	bh=AGJ5VTxKY/KS6/5nndvnqEsgjUjAbBsiay3o+sKINto=;
	b=o830emu7hKeR70cxOhtJL8Ubvi8DtyGUU/8TdXT3iDwb8J05ZB6txzYNK9OTPGG64e/F
	 Jsf8iSHzl9+Cu/55yUCWyXCKlueIobf8LJoC7xeDKrOrQ98NQRKQIpUn07pwkBAW9v/e0
	 Kqvpv9kk+XQh3xYKaIBrC1mx2E8G8jmJ2EbmvEJSJQdaYMM5jtPrBePlPyof8RrHDg5Zs
	 rdRXupBdb4cNUZuLHkI3siWrPZTXPW2j1XUh5HVduKEu6qfPooLl6AVxw7wxPzc0nwBVC
	 fCwF7tMAydW0JLcMi6VKWcFHd1KLy4gRIyu+hUlywXuu4qno4i4Q7GwduaHhsCIN05g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=roeck-us.net;
	spf=fail smtp.mailfrom=roeck-us.net;
	dkim=pass header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=AE6JZuh4;
	arc=none smtp.remote-ip=35.89.44.35
Received: from omta36.uswest2.a.cloudfilter.net (omta36.uswest2.a.cloudfilter.net [35.89.44.35])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377F1606A328
	for <linux-watchdog@vger.kernel.org>; Thu,  5 Nov 2026 19:05:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 377F1606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=AE6JZuh4
Received: from eig-obgw-6003b.ext.cloudfilter.net ([10.0.30.175])
	by cmsmtp with ESMTPS
	id Oz3YxZRU3RiNxP2mFxtxCv; Thu, 05 Nov 2026 19:05:35 +0000
Received: from 162-215-252-36.unifiedlayer.com ([208.91.199.152])
	by cmsmtp with ESMTPS
	id P2mExAuzxVqSeP2mExSN1r; Thu, 05 Nov 2026 19:05:34 +0000
X-Authority-Analysis: v=2.4 cv=eLETjGp1 c=1 sm=1 tr=0 ts=6aecd37e
 a=QNED+QcLUkoL9qulTODnwA==:117 a=2cfIYNtKkjgZNaOwnGXpGw==:17
 a=zJRp6_cAMcgA:10 a=M0FbrtG7MMAA:10 a=Bq6zwJu1AAAA:8 a=VwQbUJbxAAAA:8
 a=_jlGtV7tAAAA:8 a=CJDYlvsNdJ4W8PfXJ5AA:9 a=KQ6X2bKhxX7Fj2iT9C4S:22
 a=nlm17XC03S6CtCLSeiRr:22 a=KPbNTLLc3YvdawN95zVk:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=roeck-us.net; s=default; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:
	List-Archive; bh=AGJ5VTxKY/KS6/5nndvnqEsgjUjAbBsiay3o+sKINto=; b=AE6JZuh4AeY3
	DILUadUkLWFOYvulyL+BNznUgComz38UMeJIcKE44b/1Mdd4OzJi7exzsAMHdyo4WsKNZrIzo5JiL
	1iesZNAt+soZHKIjxWAoXsaMci9wwVMIOscQGvABpMVfnhYlAnFZ8rtyNbfXoX+zt5/a9iz2QyzQD
	Zp3drNCFHuZw1IBIUg+r3Xnxpgl5Q3p4q/oNjwMqYKhgXzoEGFYjJAzcAPd4YcDizaZVWc8bybHAB
	E/145mkY03e+dsfr1iFWWz0mmTpuZJlLd9bIOahJhBDykUGO1owt+OtxzbHeJk+8UVY/DFwaw0AQt
	P0GCfC0em9mX2scvVc5Xuw==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:52482 helo=server.roeck-us.net)
	by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <linux@roeck-us.net>)
	id 1xP2mD-00000003PHr-37vE;
	Fri, 06 Nov 2026 00:35:33 +0530
From: Guenter Roeck <linux@roeck-us.net>
To: linux-watchdog@vger.kernel.org
Cc: Tzung-Bi Shih <tzungbi@kernel.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Xingyu Wu <xingyu.wu@starfivetech.com>,
	Ziv Xu <ziv.xu@starfivetech.com>
Subject: [PATCH v2 2/8] watchdog: starfive-wdt: Balance pm_runtime_enable() on probe error paths
Date: Thu,  5 Nov 2026 11:05:23 -0800
Message-ID: <20261105190530.2371854-3-linux@roeck-us.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20261105190530.2371854-1-linux@roeck-us.net>
References: <20261105190530.2371854-1-linux@roeck-us.net>
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
X-Exim-ID: 1xP2mD-00000003PHr-37vE
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net (server.roeck-us.net) [108.223.40.66]:52482
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 12
X-Org: HG=direseller_whb_net_legacy;ORG=directi;
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfCuOCv+1eREU5QjGiZDWqntOQNuSXRKcn9k36L2GPgXvMUUxoSAEEPvTmkQJ8NlH0Eodr5oCH+Z/fCtQywEBTQbQgB/sZbq/Dc76W3s8I1RdIPqvyIEI
 yS20sb+h/whiBwarG9zgyGcQnJzSppeFynq4qSSz0/JE9yEl1ax2ELirseC/BhxQgBCYgzbNpfcFJjCK+X1TF+8Wt9Ol3KTOnNr9a1Sto4BUK8QOJFTrqIvx

In starfive_wdt_probe(), pm_runtime_enable() is called before attempting
to resume the device via pm_runtime_resume_and_get() or enable its clocks
via starfive_wdt_enable_clock(). If either call fails, probe returns
directly without calling pm_runtime_disable(), leaving the runtime PM
disable_depth counter unbalanced (and triggering "Unbalanced
pm_runtime_enable!" warnings on deferred probe retries).

Add an err_disable_pm error label and jump to it so pm_runtime_disable()
is called on these error paths.

Fixes: db728ea9c7be ("drivers: watchdog: Add StarFive Watchdog driver")
Cc: Xingyu Wu <xingyu.wu@starfivetech.com>
Cc: Ziv Xu <ziv.xu@starfivetech.com>
Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Add Reviewed-by: tag

 drivers/watchdog/starfive-wdt.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/starfive-wdt.c b/drivers/watchdog/starfive-wdt.c
index ab6920b8d7d8..4724fccbfe63 100644
--- a/drivers/watchdog/starfive-wdt.c
+++ b/drivers/watchdog/starfive-wdt.c
@@ -454,12 +454,12 @@ static int starfive_wdt_probe(struct platform_device *pdev)
 	if (pm_runtime_enabled(&pdev->dev)) {
 		ret = pm_runtime_resume_and_get(&pdev->dev);
 		if (ret < 0)
-			return ret;
+			goto err_disable_pm;
 	} else {
 		/* runtime PM is disabled but clocks need to be enabled */
 		ret = starfive_wdt_enable_clock(wdt);
 		if (ret)
-			return ret;
+			goto err_disable_pm;
 	}
 
 	ret = starfive_wdt_reset_init(&pdev->dev);
@@ -516,6 +516,7 @@ static int starfive_wdt_probe(struct platform_device *pdev)
 	watchdog_unregister_device(&wdt->wdd);
 err_exit:
 	starfive_wdt_disable_clock(wdt);
+err_disable_pm:
 	pm_runtime_disable(&pdev->dev);
 
 	return ret;
-- 
2.45.2


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=35.89.44.35
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793810699;
	b=n7LkqF1PqiQ7udh7ys0vdpyfL47skRYjhtTUggSnE0htfL8wSBlQUVAdQqKnWwGAijeR
	 rmzdCL/l+OMLTdVtff58TQsLQRbILzzjx9TmNY9gQCbL0ahEWcYxuu40kTQkAvMGWzoV9
	 /yFL1+QLzpBcn1k2k56/JMEaG8k+yc/dN2JCkn38Jsnz+eiOa1lYJDQsyGM6//haTPqq3
	 WAkoQDw3CtHdiEWQpS1xSxvbry1yehLSL8wDGakmwIIALY3Y5AW97JTWKeuwbEaPapllq
	 vYNwBS80xu7eQJtP2Q0+gnRcg+YbWSAgaKEcO2iBM6KVB30g6534DypXIJ5e+EAgEhg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793810699;
	h=DMARC-Filter:Received:Received:X-Authority-Analysis:DKIM-Signature:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-BWhitelist:X-Source-IP:X-Source-L:X-Exim-ID:
	 X-Source:X-Source-Args:X-Source-Dir:X-Source-Sender:X-Source-Auth:
	 X-Email-Count:X-Org:X-Source-Cap:X-Local-Domain:X-CMAE-Envelope;
	bh=21K2JMse8AZ6VNNyPvUiy9N+/eWviexEi8svsXhUiXw=;
	b=krw28b1qbNh7Zkeh9jF1X8aTSI9xvVDTDX3O2JfcagShc41bdYCG1OAYL79rb7puvW5C
	 Uylh8tQ93coGOdrG6r1U9DzSLR53FbJ5iQCL12ld3DA5IJx8GJdnOaQUR1kTM7JLFc0mB
	 PRrIOouSWUeRB+WWP4GKvbNMG88YG48Bio07N1+NH48qq5U1ScD4tAc6tqRI0QcBlDCpl
	 Mvm3/oSc21VwUAKYkuE9wAbyLR4MKWPFRw6O8IIuC92HNWXGsHb16dNOehftnS/R1xEZ1
	 6wtp6rnkYkK17DgujzxcE3TuuCHN2A1XmDf54riZLjD4+Vy4x1Gpfpf0r/2xJakkz0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=roeck-us.net;
	spf=fail smtp.mailfrom=roeck-us.net;
	dkim=pass header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=iI8VKDIC;
	arc=none smtp.remote-ip=35.89.44.35
Received: from omta36.uswest2.a.cloudfilter.net (omta36.uswest2.a.cloudfilter.net [35.89.44.35])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D881606A326
	for <linux-watchdog@vger.kernel.org>; Wed,  4 Nov 2026 16:44:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3D881606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=iI8VKDIC
Received: from eig-obgw-5002b.ext.cloudfilter.net ([10.0.29.226])
	by cmsmtp with ESMTPS
	id OZBMxTbCVRiNxOe6VxiN45; Wed, 04 Nov 2026 16:44:51 +0000
Received: from 162-215-252-36.unifiedlayer.com ([208.91.199.152])
	by cmsmtp with ESMTPS
	id Oe6Sx0Fhagk6fOe6SxWwhU; Wed, 04 Nov 2026 16:44:48 +0000
X-Authority-Analysis: v=2.4 cv=KM9aDEFo c=1 sm=1 tr=0 ts=6aeb6103
 a=QNED+QcLUkoL9qulTODnwA==:117 a=2cfIYNtKkjgZNaOwnGXpGw==:17
 a=zJRp6_cAMcgA:10 a=M0FbrtG7MMAA:10 a=Bq6zwJu1AAAA:8 a=_VcdFb62RPCj1aWXlFYA:9
 a=KQ6X2bKhxX7Fj2iT9C4S:22 a=KPbNTLLc3YvdawN95zVk:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=roeck-us.net; s=default; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=21K2JMse8AZ6VNNyPvUiy9N+/eWviexEi8svsXhUiXw=; b=iI8VKDICG12vVU3Eu9uGzhP/zy
	91M9f5ogea1Hpjh92zdTtpGsjO1JHIXhxmok4I/zcOdZpdR9Z/7abSNjbwsZp7kroLVngsscszzEg
	7eK8pirsKjSKIvjiFDzj3QsjTNZllshdJ4W7EeESqGZakq1wIsee+y4IjSO33OID/qyZz8yyw2qzl
	GiwpujF4ZdtdtTAFbqJw1b+28ZiyMt2Tt6HU/2u+Z8fW4IzCMQFMFmqTTtFmALqrY19O6GyE3xgRU
	8EdjtGi6CbBrRowMyiDCt+xcQ6XagEYpdDTm26L6plrJNXzK0G9J0ley4/dKYc1rcx0WWlSVC3CrN
	hpuxtDTg==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:41144 helo=server.roeck-us.net)
	by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <linux@roeck-us.net>)
	id 1xOe6R-00000002bxn-2sHX;
	Wed, 04 Nov 2026 22:14:47 +0530
From: Guenter Roeck <linux@roeck-us.net>
To: linux-watchdog@vger.kernel.org
Cc: Guenter Roeck <linux@roeck-us.net>,
	Xingyu Wu <xingyu.wu@starfivetech.com>,
	Ziv Xu <ziv.xu@starfivetech.com>
Subject: [PATCH 0/5] watchdog: starfive-wdt: Fix runtime PM and unclocked register access bugs
Date: Wed,  4 Nov 2026 08:44:40 -0800
Message-ID: <20261104164445.3209560-1-linux@roeck-us.net>
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
X-Exim-ID: 1xOe6R-00000002bxn-2sHX
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net (server.roeck-us.net) [108.223.40.66]:41144
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 29
X-Org: HG=direseller_whb_net_legacy;ORG=directi;
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfAamuNDjDn7TfWo6tcO8BnPPShq5txq8fkYVRl0EiJiwcwaHrK6OUQc8utkALc3RxwswSWvpQjgX0UdnlApM2yIQEcTETJEAdYvRZWjpoG/7dY7lf0c3
 QvGLRwEdJ08uUleiCXDVfDWAFnResP6d8z81Q1L2BG6hrLI+9Se2+JiBQ/UTHr7t2GeBlBhlFtQsbIevqP5XH3ub/8DB3kD1s2uYBF1kZXKC/x0XFPAyCPg7

The StarFive watchdog driver (drivers/watchdog/starfive-wdt.c) gates its
APB and core clocks via runtime PM callbacks, but has several runtime PM
reference-counting, ordering, and unclocked MMIO access bugs across
probe, remove, start/stop, shutdown, and system sleep paths:

1. In starfive_wdt_pm_start(), if starfive_wdt_start() fails after
   pm_runtime_resume_and_get() succeeds, the acquired runtime PM
   reference is leaked because the watchdog core does not call the stop
   callback when start fails.
2. In starfive_wdt_probe(), early returns on pm_runtime_resume_and_get()
   or starfive_wdt_enable_clock() failure bypass pm_runtime_disable(),
   leaving the runtime PM disable_depth counter unbalanced.
3. When runtime PM has suspended an idle watchdog and gated its clocks,
   starfive_wdt_remove(), starfive_wdt_shutdown(), starfive_wdt_suspend(),
   and starfive_wdt_resume() unconditionally read and write hardware
   registers, causing unclocked MMIO bus faults. In addition,
   starfive_wdt_pm_stop() propagates non-zero idle return codes from
   pm_runtime_put_sync() as errors to watchdog_stop().
4. Probe error paths after pm_runtime_resume_and_get() disable clocks
   manually without releasing the runtime PM reference (and without
   stopping an early_enable watchdog if registration fails), and
   starfive_wdt_remove() never drops the active runtime PM reference
   retained when watchdog_hw_running() is still set (e.g. early_enable).
5. In starfive_wdt_probe(), watchdog_register_device() is called before
   pm_runtime_put_sync() drops the probe-time reference, and non-zero
   idle return values such as -EAGAIN (triggered if userspace opens
   /dev/watchdog immediately upon registration) are treated as fatal
   probe errors.

These bugs have been reported by Sashiko.

This 5-patch series fixes each of these issues cleanly in sequence.

Note on tooling and testing:
This series was generated with an AI coding assistant (Jetski / Gemini)
following analysis of reported runtime PM and lifecycle bugs in
starfive-wdt.c. All patches were build-tested with make allmodconfig and
make W=1 with zero warnings, verified with scripts/checkpatch.pl
--strict, and validated against a state-machine simulation harness
covering runtime PM, clock gating, and concurrent open paths; they were
not tested on physical StarFive JH7100/JH7110 hardware.

Guenter Roeck (5):
  watchdog: starfive-wdt: Drop runtime PM reference if starting watchdog
    fails
  watchdog: starfive-wdt: Balance pm_runtime_enable() on probe error
    paths
  watchdog: starfive-wdt: Avoid unclocked register access in remove and
    PM paths
  watchdog: starfive-wdt: Fix runtime PM usage count leaks in probe and
    remove
  watchdog: starfive-wdt: Drop runtime PM reference before registering
    watchdog

 drivers/watchdog/starfive-wdt.c | 75 +++++++++++++++++++++------------
 1 file changed, 48 insertions(+), 27 deletions(-)

Cc: Xingyu Wu <xingyu.wu@starfivetech.com>
Cc: Ziv Xu <ziv.xu@starfivetech.com>
-- 
2.56.0

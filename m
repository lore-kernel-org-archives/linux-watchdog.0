Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=35.89.44.39
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793905539;
	b=ydcT5NnOA5uXDp6z3nvY7bDmvmkxHZOtiimL+UwfrpPSwUZREGNNskaCFRu+xBpDzSuo
	 0gRbJRseAAujATb0WDiu6JWdSb59fiXthOQ+9Z3Pmn14sKTi2HvVYX0hN4KqGujxFE6nh
	 1n2UitZcSos+1sb3xrsSrB9drWcsBcR4JkTgVpMcKPBKQKRbJTGI1O9RFa2Usp4F/0eBl
	 yur0EjvPdFGQ0rQNQMZupFjF4mGewpAHl18qMnMk2NGG9gsALuZhCJ868cuuzOraGXQq/
	 EeigDbvkDUuDJ/s5uk6Gr2/PamIV4IDYl/JH2aNrftNONMbUseekJSfYhd/VLdJRE8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793905539;
	h=DMARC-Filter:Received:Received:X-Authority-Analysis:DKIM-Signature:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-BWhitelist:X-Source-IP:X-Source-L:X-Exim-ID:
	 X-Source:X-Source-Args:X-Source-Dir:X-Source-Sender:X-Source-Auth:
	 X-Email-Count:X-Org:X-Source-Cap:X-Local-Domain:X-CMAE-Envelope;
	bh=0S6/EHc+RILuWKvhlqRji0oAkDLriqX8k9cQvYYQQvY=;
	b=XUN9KRuMYqZE9BK7x0+MvQm/3/VzoY5qKbTVoX7pnB5Veb+HOydUy2AzygfMmiK8Cqvi
	 lA1VPBdFPnb7NOmKYSCRfPCN09+T1E3iM8O+jddBlvj0LuAIuV0m58uAlYOXPWevpJEBf
	 roLKW7ABqH9xFquLeh+TdY4MRx+zf0ttXlrzwQTz/cS5Q7DNizPkzfYNqTTRqGUkwdpCK
	 Ur+4WLMnOLHP8G/EZkopmMdvUe2khbOr74anCXob1tLxtJ6aWYdKzBAu3ZsKhlOc9dqUJ
	 IgrCpOE7lvq4FyfIePsc3VIE9IAbTVjBzL+5nCeluyQ/4ml34cMTcLCA4el07bhA3TA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=roeck-us.net;
	spf=fail smtp.mailfrom=roeck-us.net;
	dkim=pass header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=UZlq29W5;
	arc=none smtp.remote-ip=35.89.44.39
Received: from omta40.uswest2.a.cloudfilter.net (omta40.uswest2.a.cloudfilter.net [35.89.44.39])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63724606A31B
	for <linux-watchdog@vger.kernel.org>; Thu,  5 Nov 2026 19:05:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 63724606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=UZlq29W5
Received: from eig-obgw-6003b.ext.cloudfilter.net ([10.0.30.175])
	by cmsmtp with ESMTPS
	id P04bxxZFbyb4YP2mDxLVp9; Thu, 05 Nov 2026 19:05:33 +0000
Received: from 162-215-252-36.unifiedlayer.com ([208.91.199.152])
	by cmsmtp with ESMTPS
	id P2mCxAuvnVqSeP2mCxSMzG; Thu, 05 Nov 2026 19:05:32 +0000
X-Authority-Analysis: v=2.4 cv=eLETjGp1 c=1 sm=1 tr=0 ts=6aecd37c
 a=QNED+QcLUkoL9qulTODnwA==:117 a=2cfIYNtKkjgZNaOwnGXpGw==:17
 a=zJRp6_cAMcgA:10 a=M0FbrtG7MMAA:10 a=Bq6zwJu1AAAA:8 a=_pnMIX27wyyEhhPZk0MA:9
 a=O8hF6Hzn-FEA:10 a=KQ6X2bKhxX7Fj2iT9C4S:22 a=KPbNTLLc3YvdawN95zVk:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=roeck-us.net; s=default; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=0S6/EHc+RILuWKvhlqRji0oAkDLriqX8k9cQvYYQQvY=; b=UZlq29W5IzNFdtMgN14hNjQZfF
	ntE+2vDUA7LUi3F/DXomCiGhcgx9/J4pj5x1Ky81W8sc6aNno/+sqdCkarckZt4z34bC5040DNRFC
	OzauEVBdlLuEuGYtPfs08nF6PzjEI5Pn3hxv1OGfBP2qtLkRMYW9NIy1e187YE8qGFmdNP7xVEESU
	G54C0ItHJT45g6+MWRRjzxkUWw0kh8BGbJ3OktntNx6bSz1hSsXlB5s9B3JWcnfO4M17LgR5OFBiA
	yWZSxW7C4DZetMZsgPdTHLv9EmwBWwTIyMGBnqL9xY6ZD+SrbnC6GHzk54HcHLIkwXCDBPN4/0YrP
	9JwKPSLA==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:34122 helo=server.roeck-us.net)
	by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <linux@roeck-us.net>)
	id 1xP2mC-00000003PE2-0cXR;
	Fri, 06 Nov 2026 00:35:32 +0530
From: Guenter Roeck <linux@roeck-us.net>
To: linux-watchdog@vger.kernel.org
Cc: Tzung-Bi Shih <tzungbi@kernel.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Xingyu Wu <xingyu.wu@starfivetech.com>,
	Ziv Xu <ziv.xu@starfivetech.com>
Subject: [PATCH v2 0/8] watchdog: starfive-wdt: Fix runtime PM and unclocked register access bugs
Date: Thu,  5 Nov 2026 11:05:21 -0800
Message-ID: <20261105190530.2371854-1-linux@roeck-us.net>
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
X-Exim-ID: 1xP2mC-00000003PE2-0cXR
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net (server.roeck-us.net) [108.223.40.66]:34122
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 4
X-Org: HG=direseller_whb_net_legacy;ORG=directi;
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfKr0Cfn5bCok9fuZIliFqVXeLfwD4R4kD65yUsCDVEoa5Z8Mz0d/CYWAujLkUbRjNJKe45KdZ4hf4qzNxsD5f28rcKNIx7zSefMeQrxLPl3inUUZLMGA
 VyAP807REIqR4/Lymn2VayISLf30ZNQYbZpCotwxdGvoYKUwlo6i2Gx0ErRyGT8Uj/kb66RBhHn4s/uV4CBQIlB6lvOLU0chylVBBLvaV/1BmSBXYoQF3/Aj

The StarFive watchdog driver (drivers/watchdog/starfive-wdt.c) gates its
APB and core clocks via runtime PM callbacks, but has several runtime PM
reference-counting, ordering, and unclocked MMIO access bugs across
probe, remove, start/stop, shutdown, ioctl/sysfs, and system sleep paths:

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
   starfive_wdt_shutdown() duplicates watchdog_stop_on_reboot() (causing
   unbalanced runtime PM puts when not runtime-suspended and ignoring
   watchdog.stop_on_reboot=0), and starfive_wdt_pm_stop() propagates
   non-zero idle return codes from pm_runtime_put_sync() as errors to
   watchdog_stop().
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
6. In starfive_wdt_get_timeleft(), reading the sysfs timeleft attribute
   or issuing ioctl(WDIOC_GETTIMELEFT) while the watchdog is inactive
   reads hardware registers while clocks are gated off.
7. In starfive_wdt_probe(), omitting watchdog_stop_ping_on_suspend()
   leaves the non-freezable watchdog ping worker active across system
   suspend when early_enable=1 is used, risking unclocked MMIO in
   starfive_wdt_keepalive() after starfive_wdt_suspend() gates clocks.
8. In starfive_wdt_set_timeout(), issuing ioctl(WDIOC_SETTIMEOUT) after
   stopping the watchdog via WDIOS_DISABLECARD accesses unclocked MMIO
   registers (when runtime-suspended) or unexpectedly re-enables the
   hardware counter while inactive (when runtime PM is disabled).

This 8-patch series fixes each of these issues in sequence.

Changes in v2:
- Patch 1, 2, 4, and 5: Added Reviewed-by: tags
- Patch 3: Remove the redundant starfive_wdt_shutdown() callback instead
  of guarding it with !pm_runtime_suspended(), avoiding unbalanced
  pm_runtime_put_sync() calls when runtime suspend is forbidden or after
  watchdog_reboot_notifier() already stopped the watchdog, avoiding
  unclocked MMIO during hibernation shutdown, and respecting the
  watchdog.stop_on_reboot module parameter.
- Patch 6 (new): Return 0 in starfive_wdt_get_timeleft() when
  !watchdog_hw_running() to avoid unclocked MMIO reads.
- Patch 7 (new): Call watchdog_stop_ping_on_suspend() in
  starfive_wdt_probe() so the ping worker does not call
  starfive_wdt_keepalive() while clocks are gated during suspend.
- Patch 8 (new): Only program hardware registers in
  starfive_wdt_set_timeout() when watchdog_hw_running() is set, and
  reload the preset counter in starfive_wdt_start() when starting from
  probe or after WDIOS_DISABLECARD.

Note on tooling and testing:
This series was generated with an AI coding assistant (Jetski / Gemini)
following analysis of reported runtime PM and lifecycle bugs in
starfive-wdt.c. All patches were build-tested with make allmodconfig and
make W=1 with zero warnings, verified with scripts/checkpatch.pl
--strict, and validated against a state-machine simulation harness
covering runtime PM, clock gating, ioctl/sysfs, suspend/shutdown, and
concurrent open paths; they were not tested on physical StarFive
JH7100/JH7110 hardware.

Cc: Xingyu Wu <xingyu.wu@starfivetech.com>
Cc: Ziv Xu <ziv.xu@starfivetech.com>

Guenter Roeck (8):
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
  watchdog: starfive-wdt: Avoid unclocked MMIO read in
    starfive_wdt_get_timeleft()
  watchdog: starfive-wdt: Stop ping worker on system suspend
  watchdog: starfive-wdt: Avoid unclocked MMIO access in
    starfive_wdt_set_timeout()

 drivers/watchdog/starfive-wdt.c | 102 ++++++++++++++++++--------------
 1 file changed, 58 insertions(+), 44 deletions(-)

-- 
2.56.0

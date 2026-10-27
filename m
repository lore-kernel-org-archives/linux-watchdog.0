Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=44.202.169.35
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793116988;
	b=HG9VMbVKBc8Zp8aIaH+elEOvnp4kX8ATjGVgsw8kmZoLSfTz6zmZLy0UCKN7jBF7YJNH
	 rknnGiae28l0gwA/sQx9NKWwhX2qNiY1ZQSIXZlEp3h0BX5+LuhoNlt4e/d/msGrzWMDd
	 X3xquH/MDj2txeX6yPNJw1KbU1T++uPno2hfUtIZGYsjrtrLBNiW5BMppsoXJUG2ylyze
	 VOO6l1WZK6vk+udHV5ijhqa8wAa0nBC1auohlAeFVr4i7QAwql09j2RJ6Vh302mJ/rU4O
	 tW7DxxIn3xrRzVh/mxi5daRwGRYzfajpfM2pknU4F/qG/fU5hq6h53QTLlGPjKzqtew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793116988;
	h=DMARC-Filter:Received:Received:X-Authority-Analysis:DKIM-Signature:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-BWhitelist:X-Source-IP:X-Source-L:X-Exim-ID:
	 X-Source:X-Source-Args:X-Source-Dir:X-Source-Sender:X-Source-Auth:
	 X-Email-Count:X-Org:X-Source-Cap:X-Local-Domain:X-CMAE-Envelope;
	bh=HaMcViHs4mZAGNd/aGk/6wfB6kzUE81Ykf5QMSbmQUE=;
	b=EiYukzydRHySw0+ck1smngoS2ZTXgty6gVUDNHPKi+tnugxZsUT7VjuLvbPoku0Hg1m3
	 VsRPSNbexB5bGYOhZMDZ5RdZvQL9ZhtdbQ4ErPTFIseoyOq3rk4ICHyAXf/HC89fq497T
	 2948/1MuLpUlbFH3OOv6Ayy56DpETtE89i2AeYcIaBzKc6lIhSzyEot5W/C7y93+fy5JF
	 KSRkkgSSSfjfdseFOYmITQczGZ1m1O0gc4Tg/+yXExTLqVmMgDv3+e07EX2KbCx+kzsE1
	 5fdIB1CrnPImWUMewf+ZnbXSWE6I0gisre80aoLrUSPxfuuNpEe7xnyNq620qigpGxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=roeck-us.net;
	spf=fail smtp.mailfrom=roeck-us.net;
	dkim=pass header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=VMoUu8sQ;
	arc=none smtp.remote-ip=44.202.169.35
Received: from omta036.useast.a.cloudfilter.net (omta036.useast.a.cloudfilter.net [44.202.169.35])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC8B606A31E
	for <linux-watchdog@vger.kernel.org>; Tue, 27 Oct 2026 16:03:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1BC8B606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=VMoUu8sQ
Received: from eig-obgw-6002b.ext.cloudfilter.net ([10.0.30.203])
	by cmsmtp with ESMTPS
	id LfJqx84uLLvgbLjdixvaDI; Tue, 27 Oct 2026 16:03:06 +0000
Received: from 162-215-252-36.unifiedlayer.com ([208.91.199.152])
	by cmsmtp with ESMTPS
	id LjdhxHlW6DUqcLjdhxliY6; Tue, 27 Oct 2026 16:03:05 +0000
X-Authority-Analysis: v=2.4 cv=VN/dn8PX c=1 sm=1 tr=0 ts=6ae0cb3a
 a=QNED+QcLUkoL9qulTODnwA==:117 a=2cfIYNtKkjgZNaOwnGXpGw==:17
 a=660iZSQnnn4A:10 a=M0FbrtG7MMAA:10 a=Y2L8bdpWb0MasUv1VHAA:9
 a=KPbNTLLc3YvdawN95zVk:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=roeck-us.net; s=default; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=HaMcViHs4mZAGNd/aGk/6wfB6kzUE81Ykf5QMSbmQUE=; b=VMoUu8sQ3tzkAvYxpbN/DufH5q
	G9etzcjHHQT+5T0kt77Gr0hxpkuqQrMknPQbq/et7kTm78cDlZopY0bqluLIDRzX8qCvzyN5251Bg
	W7BJaL+NgVOSuDgjc85iCgnkD0oVXlgJwMuQcdUy6jP6pw9m5g15eBK90tyviJ9OoRiSSvKb15M4z
	f1LylgQG1wn5/DWb2+GT9NhDNusn4cIXCs2rZ0c3H2skYD0EJyUhZpgc6Xz8NsRjWhgYFrBYFMxj0
	q0PhyRDR0sbN3ef0C/hXGH2wxD5hfqzJ3TxjY2kEfS3mMy5TfMVdjL/B/wrBwxv7U7mUVQ4QMxXPE
	5ScLehTA==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:47894 helo=server.roeck-us.net)
	by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <linux@roeck-us.net>)
	id 1xLjdh-00000000cE4-024X;
	Tue, 27 Oct 2026 21:33:05 +0530
From: Guenter Roeck <linux@roeck-us.net>
To: linux-watchdog@vger.kernel.org
Cc: Tzung-Bi Shih <tzungbi@kernel.org>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v2 0/8] watchdog: core: Fix locking, lifetime, suspend, and state management bugs
Date: Tue, 27 Oct 2026 09:02:54 -0700
Message-ID: <20261027160302.2519282-1-linux@roeck-us.net>
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
X-Exim-ID: 1xLjdh-00000000cE4-024X
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net (server.roeck-us.net) [108.223.40.66]:47894
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 2
X-Org: HG=direseller_whb_net_legacy;ORG=directi;
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfEByd/m9VmQyW6pg+iPxfRbxYw4wjLY4f0gdYHXb8NXBMHJAZtlF0Cr3WO9zgqK1NwDDGZLevvYsquUtIUBdAwXIgY81X45ZFkvs7M/oYWGpNx98xYbc
 K/VLlXlI4ar5j++UckOWUs6N17Ph+1pM7NIq29v5oQMjKAbo7+MDGVqQedV4UuWyRusqWocyXufmrYy+SnBLHXLjqUHgS8GX/p/QyDlDaLFvKf960vQrkAfn

This series fixes several locking, reference counting, object lifetime,
suspend/resume, and state management bugs in the watchdog core character
device and timer handling:

1. watchdog: core: Clear wd_data pointer on errors
   Clear wdd->wd_data on all registration error paths in
   watchdog_cdev_register(), and clear wd_data->wdd under wd_data->lock
   when failing after misc_register() may have exposed the device to
   userspace, preventing dangling pointers.

2. watchdog: core: Add missing locks
   Acquire wd_data->lock in watchdog_open(), across watchdog_stop() and
   pretimeout teardown in watchdog_cdev_unregister(), and in
   watchdog_set_last_hw_keepalive(). Also protect old_wd_data with
   old_wd_data_lock to prevent races when opening or unregistering
   /dev/watchdog.

3. watchdog: core: Prevent ping worker from re-arming timer on suspend
   Introduce a _WDOG_SUSPENDED flag in wd_data->status, set under
   wd_data->lock during suspend and cleared on resume, and check it in
   watchdog_worker_should_ping(), watchdog_need_worker(), and
   __watchdog_ping() so an in-flight worker or deferred ping cannot
   re-arm wd_data->timer while suspended.

4. watchdog: core: Stop pretimeout hrtimer on suspend
   Stop the software pretimeout hrtimer in watchdog_dev_suspend(),
   prevent watchdog_hrtimer_pretimeout_start() from arming it while
   _WDOG_SUSPENDED is set, and restart it in watchdog_dev_resume() if
   the hardware watchdog is running.

5. watchdog: core: Restore WDOG_HW_RUNNING if stopping watchdog fails
   In watchdog_stop(), WDOG_HW_RUNNING is cleared before calling
   wdd->ops->stop(). Restore WDOG_HW_RUNNING if wdd->ops->stop() returns
   an error so the core continues to track the running hardware state
   and retains its module and device references.

   v2: Move restore of WDOG_HW_RUNNING to stop() error handler

6. watchdog: core: Cancel timer if cdev_device_add() fails
   Initialize wd_data and acquire running-watchdog module and device
   references prior to calling misc_register(). On registration failure
   (and in watchdog_cdev_unregister()), stop the watchdog if appropriate,
   stop the pretimeout hrtimer, release unclaimed running-watchdog
   references if the device is not open, and cancel wd_data->timer and
   wd_data->work before dropping the initial device reference.

7. watchdog: core: Fix unbalanced module_put() in watchdog_open()
   In watchdog_open(), try_module_get() is skipped when hw_running is
   true because the module reference was already taken when the running
   watchdog was registered. Guard module_put() on the watchdog_start()
   error path with !hw_running to avoid dropping a reference that
   watchdog_open() did not acquire.

8. watchdog: core: Update last_keepalive in watchdog_start()
   When starting a watchdog whose hardware is already running, set
   WDOG_ACTIVE and update wd_data->last_keepalive to started_at before
   calling __watchdog_ping() so that watchdog_get_timeleft() reports the
   correct remaining time and watchdog_update_worker() inside
   __watchdog_ping() evaluates the active state and new keepalive
   timestamp rather than a potentially expired open_deadline. If
   __watchdog_ping() fails, clear WDOG_ACTIVE and update the worker.

Disclaimer: I started this series to fix a number of bugs reported
by Sashiko in the watchdog core. After several fix-review rounds, I did
not get closer to fixing all issues reported by Sashiko; either my patches
turned out to be incomplete or buggy. I finally gave up and fed Sashiko's
review feedback into an AI engine, asking it to fix the reported problems.
It still took some 10+ rounds of review/fix, but the resulting patches
should fix at least the most critical race conditions in the watchdog core.

Given the complexity of the changes, the plan is to apply the series
during the next commit window, to be released with v7.5, and to
eventually back-port it to older kernel branches.

----------------------------------------------------------------
Guenter Roeck (8):
      watchdog: core: Clear wd_data pointer on errors
      watchdog: core: Add missing locks
      watchdog: core: Prevent ping worker from re-arming timer on suspend
      watchdog: core: Stop pretimeout hrtimer on suspend
      watchdog: core: Restore WDOG_HW_RUNNING if stopping watchdog fails
      watchdog: core: Cancel timer if cdev_device_add() fails
      watchdog: core: Fix unbalanced module_put() in watchdog_open()
      watchdog: core: Update last_keepalive in watchdog_start()

 drivers/watchdog/watchdog_core.h               |   1 +
 drivers/watchdog/watchdog_dev.c                | 155 ++++++++++++++++++-------
 drivers/watchdog/watchdog_hrtimer_pretimeout.c |   3 +-
 3 files changed, 117 insertions(+), 42 deletions(-)

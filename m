Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E1352CCC4
	for <linux-watchdog@vger.kernel.org>; Tue, 29 Sep 2026 13:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790689601; cv=none; b=GQSYg3hYbfi9AjajBtnnM/kH8yDzq9aWGsHw0MYWpuBH68JT3ZAB4iim5PzXDrb51Z7vuQmp2ApEK5tVULot7oIaD+xBs7NT8wp/JcompRCRQEONfy8ZWZGl/e8dRJhWcYlR8API3JUykgdJaeEB8+NLxNFXKPXJux4wd9bG0sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790689601; c=relaxed/simple;
	bh=+goGa9cgAcugmWRslIsM2AG16WY57Ihl3FtdZ4Nq2wA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r9TnGVGRl8LBbiWXJqbWEgWVzfe7lBfxGTzYMPim/QXaXDQqBGdAp36HZJLj8y4aZj9MD2Jllv7pxFp+90v9wKvAfee8QPC5BjxHdCcuTcYGzeot10/JslVGO0wM7UBcfufYZ/CMerinCepewf5Azg/ouHWZke8SmjqsRqyK+eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iKkkIozC; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iKkkIozC"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-396ccd4f99dso2719877a91.2
        for <linux-watchdog@vger.kernel.org>; Tue, 29 Sep 2026 06:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790689599; x=1791294399; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hhEl4jIIZa6pDYqIZ6ZUorBOR1XiEgy0Wrys/o3Ul3E=;
        b=iKkkIozCSQK81BbCyoO9kTKs+yGADvpfb2WGP2379CPqz2vZk6oLdF31w/iVZUW4bo
         mgCIbYftvI0oz4yXARFyKafq9VIXnEwnBNUI4Tf28NdyT0DOktcjpyemWjOgf5pPBnce
         TQdiFxGD9lnXkNVhMRIW2V//OrrWvL2I+ppbAGpuVN/OWw1Igt2eHBECyQwzAMQpWVw9
         DhJpbNpl80m5Lb47+HsBhhsgHk+2Yhs6APlSKxZNjQgTJf7RonR2apN+8E79ydo2EgFP
         DFEUOP+CNnVJ3oHkWaehRHdz9X5H6EkD8ksiZlLc6SkuW8/s91U6gjjWdw9HKF5LXJxx
         EIPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790689599; x=1791294399;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hhEl4jIIZa6pDYqIZ6ZUorBOR1XiEgy0Wrys/o3Ul3E=;
        b=mvKc64XFk7ZExttmx8EZJqNLHIPVQEw13W26iVJQeM9Xuji04KndUlnAkxQPRL6U7/
         /WOiLtr4mTRjklvB5dorVR7hR+q1RDJfDi6incKJdGFdvotkRgI8ZqSEq5g/r0L8H+Ue
         dX4uF/z02jhDvOst6WMZHBY8F87t0nElMFiITgL9opUnSKneqEa5DWVjUUzRMqZskGJN
         naA/IQkviF4PupyMrGDZIduiJdDjeX8YBIJbJU9CpgdQitDcNYWR3tZTZA12uXUZXpz1
         obeXJmqu+rlm5ny8qpRcHbIFfBJIlf+gNQa3LHIceo8fGj9TAS35RqT/XgcolUbx+1xn
         TblQ==
X-Gm-Message-State: AFq9FYJPQnlECIAdVEk4vi5yvjMau9sSYOScZADHPlqrP+td+BZiOsvR
	LMDzhqcQYBAqFSt3j2TZYBSKu/f/ocfwnhhzhGk38k1gygfTWLmXbj8lXtJQDG++
X-Gm-Gg: AYBFou0AnceEs1Sfy1y9g0ltedYf7ELs6RadJMSp00meQmd7PXpK75c2HkTJ8GU0sGs
	at4HRUehuMwsoJnLRwiq4K2hFszPnRqAQRWl88F8mLM88jeBLffsz0bI8LklpJGoPPXUgAbUJbl
	Hb7OcpixRp3E03eA62jChonyFzOuKGW2LL0yy8bInYK3/ybzAFiLsndLlMIMM1A74SupnBxNYuE
	MQGNqP9Usxm6aoTZoQ0R2JvwM1U/mkcOEf9rib4kxZ8bLOqg/FRNr8SflHckh4mC7+Q9BysW53f
	+2dO23NCUZ7uMCkJA2gPCno/a2uwkzUeXSBuLRJWgAf2BM6K+wPHtoRsCK3/zdXnyA6VM3UOIyY
	iQuQz92KqN5SPxWGdQvr2yeu4eCpHguD1AjOm/GY11dS8pMR10EXYXEvAlQQUsGWhH3d44l+Ssh
	cxqAyFJr+oYSRGC5FfT0bcXqrcnVCOgEKwOadTFccBMlLfMQYmgr17fVdMgDDUzBUoQiks68dOd
	udULNt/peLfpu3lt09ccqQ=
X-Received: by 2002:a17:90b:528e:b0:3a4:aa26:21c7 with SMTP id 98e67ed59e1d1-3a4aa263a98mr1317417a91.25.1790689598647;
        Tue, 29 Sep 2026 06:46:38 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a4b7209b59sm369240a91.1.2026.09.29.06.46.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 06:46:38 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: linux-watchdog@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 0/8] watchdog: core: Fix locking, lifetime, suspend, and state management bugs
Date: Tue, 29 Sep 2026 06:46:27 -0700
Message-ID: <20260929134635.2567137-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
during the next commit window, to be released with v7.4, and to
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

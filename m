Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=44.202.169.35
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793117038;
	b=y6OqHe2phq8mJDDxXv0+maX8V+64BymaDTGT7Sx5aZEF3YrR+wAKSTf4KQOh9dxbTS02
	 K/6jUCCfe+viCS6lmYe9B19Pb3QAfdQvlRFkIQ8VkswocfYnw9OYwAvQrdPct46hOruRy
	 EXhOsTuBJMLlCqD4ru5sikkDIqYdWC7okAlosnifHQhkmSuDDGBKq8dgSBWL7CRGkbwm+
	 Pdtop8dPOd2nu0Upl7vSnl6embzWkwnmjDgFhXYg7QsFRpy/1kMjT4UO/kzcJ4CV60u5K
	 BiWdT/h1CP2VeXQ6Gw7+1tlNsscdKZjPJ33H1M3HZM0oFOzlV/ezpfhKfGXYUHqTffA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793117038;
	h=DMARC-Filter:Received:Received:X-Authority-Analysis:DKIM-Signature:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-BWhitelist:X-Source-IP:X-Source-L:X-Exim-ID:
	 X-Source:X-Source-Args:X-Source-Dir:X-Source-Sender:X-Source-Auth:
	 X-Email-Count:X-Org:X-Source-Cap:X-Local-Domain:X-CMAE-Envelope;
	bh=iesxMItfnamPXWX4+0NhqIrYJhxWYzTg+x9ym+f6cnA=;
	b=sp4y6Xq7zotcMkJTmYAe52V7qsPzwQToJfuw8Al7OO1p7UoK/UZWG1vf50X8944FfN9w
	 5/T9R5KY1FmFRu3eybGqIEjm1ZYbp9pfplc9AMz1p9ntwXJzQ9h5zn+lszJyM92ykyUx+
	 UZKyIDAIJb8cJqiabmWV3AycuZpiSABbUG9PbpVU+dLd9F0YQLNMoAv27Zq1rCCpOen0W
	 o4kxP4KUe6t7L3rSSHyiUN2hH2V7q7nbOSgVpPgIejtp1+D3Mys8Vd/XC8qeavGdoUKJ1
	 tZU3jDX1eoY9RAeOTIC1xzH+CawmSdVP88f3LD+Sj/uh3lyGsNRLc2p7fNYysDbE6Hw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=roeck-us.net;
	spf=fail smtp.mailfrom=roeck-us.net;
	dkim=pass header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b="L0gFpk6/";
	arc=none smtp.remote-ip=44.202.169.35
Received: from omta036.useast.a.cloudfilter.net (omta036.useast.a.cloudfilter.net [44.202.169.35])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4FD1606A31B
	for <linux-watchdog@vger.kernel.org>; Tue, 27 Oct 2026 16:03:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E4FD1606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=L0gFpk6/
Received: from eig-obgw-6005b.ext.cloudfilter.net ([10.0.30.162])
	by cmsmtp with ESMTPS
	id LUblx6DmoLvgbLjeXxvau4; Tue, 27 Oct 2026 16:03:57 +0000
Received: from 162-215-252-36.unifiedlayer.com ([208.91.199.152])
	by cmsmtp with ESMTPS
	id LjeWxwMmluPyvLjeXxlVNd; Tue, 27 Oct 2026 16:03:57 +0000
X-Authority-Analysis: v=2.4 cv=Oc2YDgTY c=1 sm=1 tr=0 ts=6ae0cb6d
 a=QNED+QcLUkoL9qulTODnwA==:117 a=2cfIYNtKkjgZNaOwnGXpGw==:17
 a=660iZSQnnn4A:10 a=M0FbrtG7MMAA:10 a=VwQbUJbxAAAA:8 a=_jlGtV7tAAAA:8
 a=GGU18yJSoBe_Yn47p24A:9 a=nlm17XC03S6CtCLSeiRr:22 a=KPbNTLLc3YvdawN95zVk:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=roeck-us.net; s=default; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=iesxMItfnamPXWX4+0NhqIrYJhxWYzTg+x9ym+f6cnA=; b=L0gFpk6/jlQG2Vp7HoRYMt8UqZ
	FfOTf8ks2s+p3SOACXwyWqy2f+sxIAlq/GGN/rCh+fu+JNzrIL2I/kdjJgjSx5ahPpjxe6nYmxDCx
	9W4AjUXmVS9C7y24P2Jbz9qXMo4REcO8lw+W6Wj7wmMaZ/pguBwJdeOjnT0jxI5PQ7cFny9+cZjsB
	5V/YBBkIXtTdFJUsxQRxGMVVs07I93pL6lSy2ic3yxUuVbOlOZVBfid8YatVmdlLTRTZAQMVE8KnR
	0yvurfvP5sUSv0eUFeUyw3Upe8uqXTFCDJ21iVB7++ObXv/pcs4lqeBvuPEbFGrnf1sFWL/dQ45mA
	cvRyYmuA==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:51356 helo=server.roeck-us.net)
	by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <linux@roeck-us.net>)
	id 1xLjeW-00000000ciL-312H;
	Tue, 27 Oct 2026 21:33:56 +0530
From: Guenter Roeck <linux@roeck-us.net>
To: linux-watchdog@vger.kernel.org
Cc: Tzung-Bi Shih <tzungbi@kernel.org>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v2 6/8] watchdog: core: Cancel timer if cdev_device_add() fails
Date: Tue, 27 Oct 2026 09:03:51 -0700
Message-ID: <20261027160353.2519323-1-linux@roeck-us.net>
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
X-Exim-ID: 1xLjeW-00000000ciL-312H
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net (server.roeck-us.net) [108.223.40.66]:51356
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 18
X-Org: HG=direseller_whb_net_legacy;ORG=directi;
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfH97G0oU5qMGT6kDEaxb+V1VejlINfJ6B+hc7Z7U8fm+f/gjHseotVg3vLfX7vm2R+hvelDOv6SGwPEmuR8oGbqm9Eq76ILg5TISFxM1NfvJEbxak8lr
 8aq5sqLpmDL6e7Pjt5jOGrer5oPHnW19LB5daTTXemxwGdn1xcDB/LsWruRfxjaAtHRfiW6I8TXnD5584zGsVFpcbsE+wkgCjsJMrzMY215k427cmp9Uc9SW

If misc_register() exposed the device to userspace before cdev_device_add()
is called, a concurrent watchdog_open() could start the watchdog and arm
wd_data->timer as well as the pretimeout timer. Also, if the hardware
watchdog was already running, watchdog_open() expects the device and module
references to have been acquired prior to opening.

If cdev_device_add() then fails, the error path drops the device reference
but fails to stop the watchdog, cancel the timers, and stop the worker,
leaving the watchdog active and timers armed that can later fire and
dereference freed memory. Furthermore, if a concurrent watchdog_open() saw
hw_running == true before cdev_device_add() was called, it skipped taking
its own device reference, allowing put_device() on the error path to free
wd_data while the file descriptor is still open. Similarly, when
unregistering a running watchdog that is not currently open, the extra
hw_running module and device references were never released.

Fix the problem by initializing wd_data and taking the running-watchdog
references before exposing the device via misc_register(), stopping the
watchdog and canceling both the heartbeat and pretimeout timers and
stopping the worker on registration failure, and releasing unclaimed
running-watchdog references on registration failure and unregistration.

Fixes: ee142889e32f ("watchdog: Introduce WDOG_HW_RUNNING flag")
Assisted-by: LLM
Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Added Reviewed-by: tag

 drivers/watchdog/watchdog_dev.c | 91 ++++++++++++++++++++-------------
 1 file changed, 55 insertions(+), 36 deletions(-)

diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
index 47b0735ed6ac..ef2254188f7f 100644
--- a/drivers/watchdog/watchdog_dev.c
+++ b/drivers/watchdog/watchdog_dev.c
@@ -1046,6 +1046,7 @@ static const struct class watchdog_class = {
 static int watchdog_cdev_register(struct watchdog_device *wdd)
 {
 	struct watchdog_core_data *wd_data;
+	bool hw_running;
 	int err;
 
 	wd_data = kzalloc_obj(struct watchdog_core_data);
@@ -1081,46 +1082,10 @@ static int watchdog_cdev_register(struct watchdog_device *wdd)
 		      HRTIMER_MODE_REL_HARD);
 	watchdog_hrtimer_pretimeout_init(wdd);
 
-	if (wdd->id == 0) {
-		old_wd_data = wd_data;
-		watchdog_miscdev.parent = wdd->parent;
-		err = misc_register(&watchdog_miscdev);
-		if (err != 0) {
-			pr_err("%s: cannot register miscdev on minor=%d (err=%d).\n",
-				wdd->info->identity, WATCHDOG_MINOR, err);
-			if (err == -EBUSY)
-				pr_err("%s: a legacy watchdog module is probably present.\n",
-					wdd->info->identity);
-			old_wd_data = NULL;
-			wdd->wd_data = NULL;
-			put_device(&wd_data->dev);
-			return err;
-		}
-	}
-
 	/* Fill in the data structures */
 	cdev_init(&wd_data->cdev, &watchdog_fops);
 	wd_data->cdev.owner = wdd->ops->owner;
 
-	/* Add the device */
-	err = cdev_device_add(&wd_data->cdev, &wd_data->dev);
-	if (err) {
-		pr_err("watchdog%d unable to add device %d:%d\n",
-			wdd->id,  MAJOR(watchdog_devt), wdd->id);
-		if (wdd->id == 0) {
-			misc_deregister(&watchdog_miscdev);
-			mutex_lock(&old_wd_data_lock);
-			old_wd_data = NULL;
-			mutex_unlock(&old_wd_data_lock);
-		}
-		mutex_lock(&wd_data->lock);
-		wd_data->wdd = NULL;
-		wdd->wd_data = NULL;
-		mutex_unlock(&wd_data->lock);
-		put_device(&wd_data->dev);
-		return err;
-	}
-
 	/* Record time of most recent heartbeat as 'just before now'. */
 	wd_data->last_hw_keepalive = ktime_sub(ktime_get(), 1);
 	watchdog_set_open_deadline(wd_data);
@@ -1140,7 +1105,55 @@ static int watchdog_cdev_register(struct watchdog_device *wdd)
 				wdd->id);
 	}
 
+	if (wdd->id == 0) {
+		old_wd_data = wd_data;
+		watchdog_miscdev.parent = wdd->parent;
+		err = misc_register(&watchdog_miscdev);
+		if (err != 0) {
+			pr_err("%s: cannot register miscdev on minor=%d (err=%d).\n",
+				wdd->info->identity, WATCHDOG_MINOR, err);
+			if (err == -EBUSY)
+				pr_err("%s: a legacy watchdog module is probably present.\n",
+					wdd->info->identity);
+			old_wd_data = NULL;
+			goto err_clear;
+		}
+	}
+
+	/* Add the device */
+	err = cdev_device_add(&wd_data->cdev, &wd_data->dev);
+	if (err) {
+		pr_err("watchdog%d unable to add device %d:%d\n",
+			wdd->id,  MAJOR(watchdog_devt), wdd->id);
+		if (wdd->id == 0) {
+			misc_deregister(&watchdog_miscdev);
+			mutex_lock(&old_wd_data_lock);
+			old_wd_data = NULL;
+			mutex_unlock(&old_wd_data_lock);
+		}
+		goto err_clear;
+	}
+
 	return 0;
+
+err_clear:
+	mutex_lock(&wd_data->lock);
+	hw_running = watchdog_hw_running(wdd);
+	if (watchdog_active(wdd))
+		watchdog_stop(wdd);
+	watchdog_hrtimer_pretimeout_stop(wdd);
+	if (hw_running && !test_bit(_WDOG_DEV_OPEN, &wd_data->status)) {
+		module_put(wdd->ops->owner);
+		put_device(&wd_data->dev);
+	}
+	wd_data->wdd = NULL;
+	wdd->wd_data = NULL;
+	mutex_unlock(&wd_data->lock);
+
+	hrtimer_cancel(&wd_data->timer);
+	kthread_cancel_work_sync(&wd_data->work);
+	put_device(&wd_data->dev);
+	return err;
 }
 
 /**
@@ -1153,6 +1166,7 @@ static int watchdog_cdev_register(struct watchdog_device *wdd)
 static void watchdog_cdev_unregister(struct watchdog_device *wdd)
 {
 	struct watchdog_core_data *wd_data = wdd->wd_data;
+	bool hw_running;
 
 	cdev_device_del(&wd_data->cdev, &wd_data->dev);
 	if (wdd->id == 0) {
@@ -1163,6 +1177,7 @@ static void watchdog_cdev_unregister(struct watchdog_device *wdd)
 	}
 
 	mutex_lock(&wd_data->lock);
+	hw_running = watchdog_hw_running(wdd);
 	if (watchdog_active(wdd) &&
 	    test_bit(WDOG_STOP_ON_UNREGISTER, &wdd->status)) {
 		watchdog_stop(wdd);
@@ -1170,6 +1185,10 @@ static void watchdog_cdev_unregister(struct watchdog_device *wdd)
 
 	watchdog_hrtimer_pretimeout_stop(wdd);
 
+	if (hw_running && !test_bit(_WDOG_DEV_OPEN, &wd_data->status)) {
+		module_put(wdd->ops->owner);
+		put_device(&wd_data->dev);
+	}
 	wd_data->wdd = NULL;
 	wdd->wd_data = NULL;
 	mutex_unlock(&wd_data->lock);
-- 
2.45.2


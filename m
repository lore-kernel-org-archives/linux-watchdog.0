Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=35.89.44.35
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793116090;
	b=5LlPUhw6IOVR9OgnQURCWldfL7v/ETe2WwIafyCmWv5p44Wvcre3D+ZJGidN+t/QsstY
	 DmuxVQBbgJYKckOkZ1+lk4goLm/lv4W0ss+ThKBwaSiNHLLVftpS3WLy3cBFQtJsARF0R
	 oYeT1vyDgwzFENOQEouxAYqM8BVti4ajU2nUv/a8AjOAS87uF5DroCjbk5RAlT+DdZtgc
	 6ABsnE+OFhKMRla+cwNs93que86fqX56Tpefu/JXY0D/hX3nmSiURJkoyx7C9osBCvNbz
	 IcCsXi8/NpmpfmAA9OLX/Kiw2BsnksoUSaY6bvNiuKmCF1kfcvnif3yI7hOJzPrcY/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793116090;
	h=DMARC-Filter:Received:Received:X-Authority-Analysis:DKIM-Signature:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-BWhitelist:
	 X-Source-IP:X-Source-L:X-Exim-ID:X-Source:X-Source-Args:X-Source-Dir:
	 X-Source-Sender:X-Source-Auth:X-Email-Count:X-Org:X-Source-Cap:
	 X-Local-Domain:X-CMAE-Envelope;
	bh=z5bevSFeChpN1x7l1xiYXCuzmJVT1N4kPXbxg+xPYks=;
	b=Iz1FkFm1/HBZxYz1Dlsac1FYzX3cKnfWvEfjd/RINdKQHLYh4uldNL/4jqhEwHlEZygh
	 JJi81iZz2KEne8bwA9Aq9GloAPuGfjJ7k7T4TB21CKGNxKxuFYdktuq3Yo3AkB/lV/Fd/
	 5sBwnkpurOXKprFO9K4HAC4rbf4YmqNJNZPJ5yhgedzacV7akYuoHgi28bbYyzemkahTC
	 ruawNwIrcrse+pPdKfkH/1yo78un0SL63eG+Uuh1iXE3tfrp22aKGZ5Ve/qadMz0U7sIK
	 +oGtNzBXf62c9kHBD3eRr0XcBdRJU2e/528DNOTtGR7np6VkWQ1zHDpnWas1mXiWNkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=roeck-us.net;
	spf=fail smtp.mailfrom=roeck-us.net;
	dkim=pass header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=M5Q+3lWL;
	arc=none smtp.remote-ip=35.89.44.35
Received: from omta36.uswest2.a.cloudfilter.net (omta36.uswest2.a.cloudfilter.net [35.89.44.35])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0664607351E
	for <linux-watchdog@vger.kernel.org>; Tue, 27 Oct 2026 15:48:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E0664607351E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=M5Q+3lWL
Received: from eig-obgw-6001b.ext.cloudfilter.net ([10.0.30.143])
	by cmsmtp with ESMTPS
	id LhecxnvBxusRSLjPFx2nAu; Tue, 27 Oct 2026 15:48:09 +0000
Received: from 162-215-252-36.unifiedlayer.com ([208.91.199.152])
	by cmsmtp with ESMTPS
	id LjPExRLlYnXJHLjPFxItmn; Tue, 27 Oct 2026 15:48:09 +0000
X-Authority-Analysis: v=2.4 cv=JMM7s9Kb c=1 sm=1 tr=0 ts=6ae0c7b9
 a=QNED+QcLUkoL9qulTODnwA==:117 a=2cfIYNtKkjgZNaOwnGXpGw==:17
 a=660iZSQnnn4A:10 a=M0FbrtG7MMAA:10 a=VwQbUJbxAAAA:8 a=_jlGtV7tAAAA:8
 a=yKkK_wNgekeChpxbp_8A:9 a=nlm17XC03S6CtCLSeiRr:22 a=KPbNTLLc3YvdawN95zVk:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=roeck-us.net; s=default; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:
	List-Archive; bh=z5bevSFeChpN1x7l1xiYXCuzmJVT1N4kPXbxg+xPYks=; b=M5Q+3lWLZM6o
	kbRWe0LvaA5T9PFDuczbqxWAwgrx+ColaTS6bHb92q9ZpUywI78JLi4p3idY51aQkTRWMwv00bJ6J
	tnKmuz200BcgN5l3FVUXC8pfvhTc2PivetngsKZXYsPZjQOg8wU2MSJlVpb7GYWjRPz7SsIbKt86d
	ocDd2/4l7UKE/TW+akaZHqbS1csKBk3hMK0WDaL0+mlii5CaSYh0Z+lsEY1H1WOt07y/k9PNlL3a7
	Y6hwPe1xiRavf3n/WpDvCqp1A4ByrKswbsDXviBjJuQ/mHHdCBcjiznA4ASCVH7HvISBisroqsOEI
	6N4dbbYHw1x7Q61TEz/6YQ==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:37932 helo=server.roeck-us.net)
	by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <linux@roeck-us.net>)
	id 1xLjPE-00000000ThT-2mVB;
	Tue, 27 Oct 2026 21:18:08 +0530
From: Guenter Roeck <linux@roeck-us.net>
To: linux-watchdog@vger.kernel.org
Cc: Tzung-Bi Shih <tzungbi@kernel.org>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v2 2/8] watchdog: core: Add missing locks
Date: Tue, 27 Oct 2026 08:47:59 -0700
Message-ID: <20261027154805.2518806-3-linux@roeck-us.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20261027154805.2518806-1-linux@roeck-us.net>
References: <20261027154805.2518806-1-linux@roeck-us.net>
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
X-Exim-ID: 1xLjPE-00000000ThT-2mVB
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net (server.roeck-us.net) [108.223.40.66]:37932
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 46
X-Org: HG=direseller_whb_net_legacy;ORG=directi;
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfAaEKexaNkowR4hg9+vpT56wpjpi2UavATe4slgRBepXddV41OdZzgFHG/7wT7gX8Y47uQ0WE21fjrtZlS9sKok2fI8CTcAwfVkBhpn92SEYRIWBT5lN
 IgCle8Tn27XdsE6RXva1Ik2zNDZS3hbtCVqz8OXwO2HmadGWN9LGMoME7N3ND49yOot+c0VRq/B3+LPUxEXI6CSNsf+lybc2lMra/9/eqz7TngyHEN9IZBzL

Add missing locks to watchdog_open(), watchdog_cdev_unregister(), and
watchdog_set_last_hw_keepalive(). Also protect old_wd_data with its own
lock to prevent its modification while in use, acquiring wd_data->lock
before releasing old_wd_data_lock in watchdog_open() to avoid a TOCTOU
race, and keeping misc_deregister() outside old_wd_data_lock to avoid
lock ordering inversion with misc_mtx.

Fixes: b4ffb1909843 ("watchdog: Separate and maintain variables based on variable lifetime")
Assisted-by: LLM
Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Added Reviewed-by: tag

 drivers/watchdog/watchdog_dev.c | 42 ++++++++++++++++++++++++++++-----
 1 file changed, 36 insertions(+), 6 deletions(-)

diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
index ed5b35184271..50224877ff49 100644
--- a/drivers/watchdog/watchdog_dev.c
+++ b/drivers/watchdog/watchdog_dev.c
@@ -55,6 +55,7 @@
 static dev_t watchdog_devt;
 /* Reference to watchdog device behind /dev/watchdog */
 static struct watchdog_core_data *old_wd_data;
+static DEFINE_MUTEX(old_wd_data_lock);
 
 static struct kthread_worker *watchdog_kworker;
 
@@ -869,17 +870,32 @@ static int watchdog_open(struct inode *inode, struct file *file)
 	int err;
 
 	/* Get the corresponding watchdog device */
-	if (imajor(inode) == MISC_MAJOR)
+	if (imajor(inode) == MISC_MAJOR) {
+		mutex_lock(&old_wd_data_lock);
 		wd_data = old_wd_data;
-	else
+		if (!wd_data) {
+			mutex_unlock(&old_wd_data_lock);
+			return -ENODEV;
+		}
+		mutex_lock(&wd_data->lock);
+		mutex_unlock(&old_wd_data_lock);
+	} else {
 		wd_data = container_of(inode->i_cdev, struct watchdog_core_data,
 				       cdev);
+		mutex_lock(&wd_data->lock);
+	}
 
 	/* the watchdog is single open! */
-	if (test_and_set_bit(_WDOG_DEV_OPEN, &wd_data->status))
+	if (test_and_set_bit(_WDOG_DEV_OPEN, &wd_data->status)) {
+		mutex_unlock(&wd_data->lock);
 		return -EBUSY;
+	}
 
 	wdd = wd_data->wdd;
+	if (!wdd) {
+		err = -ENODEV;
+		goto out_clear;
+	}
 
 	/*
 	 * If the /dev/watchdog device is open, we don't want the module
@@ -909,6 +925,8 @@ static int watchdog_open(struct inode *inode, struct file *file)
 	 */
 	wd_data->open_deadline = KTIME_MAX;
 
+	mutex_unlock(&wd_data->lock);
+
 	/* dev/watchdog is a virtual (and thus non-seekable) filesystem */
 	return stream_open(inode, file);
 
@@ -916,6 +934,7 @@ static int watchdog_open(struct inode *inode, struct file *file)
 	module_put(wd_data->wdd->ops->owner);
 out_clear:
 	clear_bit(_WDOG_DEV_OPEN, &wd_data->status);
+	mutex_unlock(&wd_data->lock);
 	return err;
 }
 
@@ -1085,7 +1104,9 @@ static int watchdog_cdev_register(struct watchdog_device *wdd)
 			wdd->id,  MAJOR(watchdog_devt), wdd->id);
 		if (wdd->id == 0) {
 			misc_deregister(&watchdog_miscdev);
+			mutex_lock(&old_wd_data_lock);
 			old_wd_data = NULL;
+			mutex_unlock(&old_wd_data_lock);
 		}
 		mutex_lock(&wd_data->lock);
 		wd_data->wdd = NULL;
@@ -1131,9 +1152,12 @@ static void watchdog_cdev_unregister(struct watchdog_device *wdd)
 	cdev_device_del(&wd_data->cdev, &wd_data->dev);
 	if (wdd->id == 0) {
 		misc_deregister(&watchdog_miscdev);
+		mutex_lock(&old_wd_data_lock);
 		old_wd_data = NULL;
+		mutex_unlock(&old_wd_data_lock);
 	}
 
+	mutex_lock(&wd_data->lock);
 	if (watchdog_active(wdd) &&
 	    test_bit(WDOG_STOP_ON_UNREGISTER, &wdd->status)) {
 		watchdog_stop(wdd);
@@ -1141,7 +1165,6 @@ static void watchdog_cdev_unregister(struct watchdog_device *wdd)
 
 	watchdog_hrtimer_pretimeout_stop(wdd);
 
-	mutex_lock(&wd_data->lock);
 	wd_data->wdd = NULL;
 	wdd->wd_data = NULL;
 	mutex_unlock(&wd_data->lock);
@@ -1208,20 +1231,27 @@ int watchdog_set_last_hw_keepalive(struct watchdog_device *wdd,
 {
 	struct watchdog_core_data *wd_data;
 	ktime_t now;
+	int ret = 0;
 
 	if (!wdd)
 		return -EINVAL;
 
 	wd_data = wdd->wd_data;
+	if (!wd_data)
+		return -ENODEV;
+
+	mutex_lock(&wd_data->lock);
 
 	now = ktime_get();
 
 	wd_data->last_hw_keepalive = ktime_sub(now, ms_to_ktime(last_ping_ms));
 
 	if (watchdog_hw_running(wdd) && handle_boot_enabled)
-		return __watchdog_ping(wdd);
+		ret = __watchdog_ping(wdd);
 
-	return 0;
+	mutex_unlock(&wd_data->lock);
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(watchdog_set_last_hw_keepalive);
 
-- 
2.45.2


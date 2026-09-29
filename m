Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com [74.125.228.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D322452CCD6
	for <linux-watchdog@vger.kernel.org>; Tue, 29 Sep 2026 13:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790689603; cv=none; b=tuRqNfwBm26PyphqcAqK4Ildt/B6zm35/HkOJnO1V/bktqUD3AySQdy4i3EaDbwBdM5Rpr01gl1N7Fzx2Tdd5JGBE9RvCZ9CSt/55K5wg36n7w8cUCw7ts3TAeo9bxoblN+eNoX5xVKzhMq968BOHRL5Fr9nDjouor3pP1EjWm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790689603; c=relaxed/simple;
	bh=wpDlTr/QWpQupJUNMM2wALQN8Uyz1bY9/O7nko4Cg6E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DpWFqUcTLY7GpyRJCju8khu2xqRYxpU6xchewzDQxPJjvnHDrEGjOXSdPWjI3DQw7CTCO5FcNGUQUf5s5iWpXq0pQJbto3NuyP6RpSAlS92B2pYZyDkxq8D1/2zcyIz3cg56Yi3lEUIEDCZjgAdAqcnvGe61Jc5pqvufm2d9BpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dpWjgzRJ; arc=none smtp.client-ip=74.125.228.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dpWjgzRJ"
Received: by mail-pz2-f41.google.com with SMTP id d2e1a72fcca58-8631d0023daso2118753b3a.2
        for <linux-watchdog@vger.kernel.org>; Tue, 29 Sep 2026 06:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790689601; x=1791294401; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MNjMUkShSGX1g13GJX2GC8qsPlf5nslC/UppE0cymdg=;
        b=dpWjgzRJxWBt25CJ7MDPmv2EvOZlGpzhiW50HMsLTZYvPvqPTCVZ3wEFbqVH4Kxn8a
         BYq4vLqUtb81tSz4TncWVHSo5xjUdLYsJUlvYdjCjk00lfkxHel4x5yQfuE0x0ed+DRJ
         y8jg4hjtXbg0R1Rfa62Eymh78kRibVpZC+MwMweg7i0IA7hTn/MeNADYmUYRcXfbS54Q
         w4dG0Y0jzhkOQZX531X7XaYgPZSJ/Vv4NRbEVWkigWKiJUgdwOSgOjaBWcC/2AAoj/cA
         en6/laIpx+LFpYZqeVx6ySNWcQSoA+diqAi5Iop9YRT4gBclUu8wqBHO0pevWIjzy/AN
         geXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790689601; x=1791294401;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MNjMUkShSGX1g13GJX2GC8qsPlf5nslC/UppE0cymdg=;
        b=Q1+Vsh8vjkEWSaLaH7Yn3DYCbNxlw3DhlRf4L5x/1ANYbv8AkO+fJ8OUhSdAcyq6Sc
         0qgXixRHXLvhIcakCQcO/DjBie+Fi0dpJkdbHfaUe5fNZrKh0oKf4D5uB9VltsuhACSg
         JXUwGlm1UUDvOlJj0dOHP0Qj1ubs3Yrnlok8WCawlbFTRjH3oSUBxRK1PyGbTUEOOu64
         70jQ6HKYP3WNqN1NP8DL1BQ8ixB7DjKktz+SJvOWbJIBHCZj4JBS0GMgfiIJBAo/bWaX
         34heVh2JkWCMgzqyM++eFYqI6G7dmBAJOQ8gYS6jF9bC5cKLOEX2jtpbtaMa/2VMNc22
         5TDw==
X-Gm-Message-State: AFuF++mj8bj1H/VC1WbssTSspen+2tc35H+isVULq6mzW33gUW/D53w/
	i2wwRgJyqvqzvLUpWku7WU4+bclBtvd9Gx1D2WgEPOZ15+c3D5WfwYvJg/dCgKos
X-Gm-Gg: AYBFou3v0/TwvAJuBgmEeObJxQcbFVWCY49GFp73soTmn6sg52YWQWHQu1h5oYyDJcd
	p4ucLAKBR9+V+3WaarlO8Lq/dMxVQ+Oy52/RdPlQfWgkLD2v1KTkSP+flD3Zc4rDpWWZMd6ieXc
	vqViCw2mQEwsE3IYiBPYR45KeWZB/71QgTDnlqeUZ3ltGWOxSfhwS5FmZ+oZmbOPPeB7+gjTIbL
	6bfu+6tkp67YoVGvjTNyhBb8Mi07kMR1A8LdMP4Ny98EVVf7XKhKpA0Oav5RDC3lo3zoBJ9PFFd
	O77/HSApwd3GDewgsO/BY0MlcxEMFRNe8XNxrmVqObrD29QgUCPUdJ+sWaGkzPg3R2AA4p9HeV4
	NS/d6j54x7glIo1nPtD0uWRw7CtvhByCzkBlu0ExLsRpIwUm5dL1GPEa2YzlUqQfNmmy71verGe
	FIAD0nsYsc+jm4H8NzQgKFB4fISjOtFvfssBw27Q1sgvR7b0nm+9ltg9MHnX94RovHi5d/WvPsw
	oAgaP83yx37
X-Received: by 2002:a05:6a21:3994:b0:3cd:8bba:824f with SMTP id adf61e73a8af0-3de0e70bc28mr13563549637.4.1790689601101;
        Tue, 29 Sep 2026 06:46:41 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc7cf5a2f74sm474872a12.10.2026.09.29.06.46.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 06:46:40 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: linux-watchdog@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 2/8] watchdog: core: Add missing locks
Date: Tue, 29 Sep 2026 06:46:29 -0700
Message-ID: <20260929134635.2567137-3-linux@roeck-us.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260929134635.2567137-1-linux@roeck-us.net>
References: <20260929134635.2567137-1-linux@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add missing locks to watchdog_open(), watchdog_cdev_unregister(), and
watchdog_set_last_hw_keepalive(). Also protect old_wd_data with its own
lock to prevent its modification while in use, acquiring wd_data->lock
before releasing old_wd_data_lock in watchdog_open() to avoid a TOCTOU
race, and keeping misc_deregister() outside old_wd_data_lock to avoid
lock ordering inversion with misc_mtx.

Fixes: b4ffb1909843 ("watchdog: Separate and maintain variables based on variable lifetime")
Assisted-by: LLM
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
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


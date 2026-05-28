Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1FA34389A;
	Thu, 28 May 2026 00:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779928089; cv=none; b=l7L/ZqwgXLyGcFfQYOo3RYq8Dz2fko7no7KMsjn/FJ2AsuYh89UXzylM7BZMEw2liDsx79TFYVpofn51L4chsf0RMkNQvcjTtB9I3fBzX4rihHvgfaNOqgNig7ll+wO5nQVoJZKdTOp2lA0EiL26uG19R7eaOhubRNFutvDIxCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779928089; c=relaxed/simple;
	bh=GOXMm9quu6x7oDg6Jk1CTz4hx5XZqlwDa61SOPezt2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rrw6ELP1/o61iXJitQmNhiBW1KTPy76f0yOe2upNrmk9COaDams+ypASe6Kr0Z+PgLOXiFlY+EI2rLAt3JuNYfUUTwaIUp8X3hbr3z2UpniZ79tttXIB1W269oTeyl627i3dQJW9Vt7rqGR1y+QP417E2FhoeXCdHGEHx8smEhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=CtP+oO82; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CtP+oO82"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=VkrsBFKQKyxb92yofN7Exvmo5N+YI7gvv8pjiOGMeWw=; b=CtP+oO82xckCMaCkd9qFGXYyif
	yQgbCFcTENXaouSH8OheNKnKZ7jP5OJ/PvERSB0kYtLH8mp5xHSKsFoxd0cYGW2JYIfoP6Kka9acC
	kpj4FG7S8arqHIQsnq7W/YTlA9QQn0vlqyzjwnTl/xVg3zgGsr9OCniF9DLXfrcb7xsg1HDhSHoMj
	DIsThJFw/4FBlmedsfc6KUTmRCGHyykiTtAuZnW4N/vdu27aaM8yjdmBm1uUCIuR/K2L9byc3O4kO
	h63pHNjsuA/4yq0xoN4ct1Pf6giqOluruQPxVUuDR+Xo6g/55tMxo+Qr3f1re48l8IBPIuSUKyO1U
	BciDX9GA==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSObW-00000004rZ7-3Qbp;
	Thu, 28 May 2026 00:28:06 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-watchdog@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-doc@vger.kernel.org
Subject: [PATCH 5/5] watchdog: dev: convert to kernel-doc comments
Date: Wed, 27 May 2026 17:28:03 -0700
Message-ID: <20260528002803.1260126-6-rdunlap@infradead.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528002803.1260126-1-rdunlap@infradead.org>
References: <20260528002803.1260126-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert multiple functions to kernel-doc format.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org

 drivers/watchdog/watchdog_dev.c |   30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

--- linux-next-20260525.orig/drivers/watchdog/watchdog_dev.c
+++ linux-next-20260525/drivers/watchdog/watchdog_dev.c
@@ -176,7 +176,7 @@ static int __watchdog_ping(struct watchd
 	return err;
 }
 
-/*
+/**
  * watchdog_ping - ping the watchdog
  * @wdd: The watchdog device to ping
  *
@@ -236,7 +236,7 @@ static enum hrtimer_restart watchdog_tim
 	return HRTIMER_NORESTART;
 }
 
-/*
+/**
  * watchdog_start - wrapper to start the watchdog
  * @wdd: The watchdog device to start
  *
@@ -279,7 +279,7 @@ static int watchdog_start(struct watchdo
 	return err;
 }
 
-/*
+/**
  * watchdog_stop - wrapper to stop the watchdog
  * @wdd: The watchdog device to stop
  *
@@ -319,7 +319,7 @@ static int watchdog_stop(struct watchdog
 	return err;
 }
 
-/*
+/**
  * watchdog_get_status - wrapper to get the watchdog status
  * @wdd: The watchdog device to get the status from
  *
@@ -356,7 +356,7 @@ static unsigned int watchdog_get_status(
 	return status;
 }
 
-/*
+/**
  * watchdog_set_timeout - set the watchdog timer timeout
  * @wdd:	The watchdog device to set the timeout for
  * @timeout:	Timeout to set in seconds
@@ -391,7 +391,7 @@ static int watchdog_set_timeout(struct w
 	return err;
 }
 
-/*
+/**
  * watchdog_set_pretimeout - set the watchdog timer pretimeout
  * @wdd:	The watchdog device to set the timeout for
  * @timeout:	pretimeout to set in seconds
@@ -417,7 +417,7 @@ static int watchdog_set_pretimeout(struc
 	return err;
 }
 
-/*
+/**
  * watchdog_get_timeleft - wrapper to get the time left before a reboot
  * @wdd:	The watchdog device to get the remaining time from
  * @timeleft:	The time that's left
@@ -659,7 +659,7 @@ __ATTRIBUTE_GROUPS(wdt);
 #define wdt_groups	NULL
 #endif
 
-/*
+/**
  * watchdog_ioctl_op - call the watchdog drivers ioctl op if defined
  * @wdd: The watchdog device to do the ioctl on
  * @cmd: Watchdog command
@@ -678,7 +678,7 @@ static int watchdog_ioctl_op(struct watc
 	return wdd->ops->ioctl(wdd, cmd, arg);
 }
 
-/*
+/**
  * watchdog_write - writes to the watchdog
  * @file:	File from VFS
  * @data:	User address of data
@@ -732,7 +732,7 @@ static ssize_t watchdog_write(struct fil
 	return len;
 }
 
-/*
+/**
  * watchdog_ioctl - handle the different ioctl's for the watchdog device
  * @file:	File handle to the device
  * @cmd:	Watchdog command
@@ -845,7 +845,7 @@ out_ioctl:
 	return err;
 }
 
-/*
+/**
  * watchdog_open - open the /dev/watchdog* devices
  * @inode:	Inode of device
  * @file:	File handle to device
@@ -923,7 +923,7 @@ static void watchdog_core_data_release(s
 	kfree(wd_data);
 }
 
-/*
+/**
  * watchdog_release - release the watchdog device
  * @inode:	Inode of device
  * @file:	File handle to device
@@ -932,7 +932,7 @@ static void watchdog_core_data_release(s
  * stop the watchdog when we have received the magic char (and nowayout
  * was not set), else the watchdog will keep running.
  *
- * Always returns 0.
+ * Returns: Always 0.
  */
 static int watchdog_release(struct inode *inode, struct file *file)
 {
@@ -1004,7 +1004,7 @@ static const struct class watchdog_class
 	.dev_groups =	wdt_groups,
 };
 
-/*
+/**
  * watchdog_cdev_register - register watchdog character device
  * @wdd: Watchdog device
  *
@@ -1105,7 +1105,7 @@ static int watchdog_cdev_register(struct
 	return 0;
 }
 
-/*
+/**
  * watchdog_cdev_unregister - unregister watchdog character device
  * @wdd: Watchdog device
  *

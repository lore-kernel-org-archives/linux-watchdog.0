Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5573812CD;
	Fri, 29 May 2026 21:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780089631; cv=none; b=NVbFTALPp/e7CgWc1ldBmHFlKWj//gHbK7QgkfpKxOql5gWiRDaQeNHU2aEHpHXQOCvL4QTWCT5lbtDArxGWjDOWMciZ7+fKIysFkNiCGHONaYCAd83RHDHhoux7a145dttZ0AD8JQ6MZNS4xwWv5Dcg6tYzMuirN6nfN3Jq8Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780089631; c=relaxed/simple;
	bh=Tf0qU8LB8uYD1kHFNSO8MCcwtZ5dg+gLpqoCHJKo/r0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dZ9zyBPyWfgPIcZS7gkaAjhSjjOmELIZJVccPHUdQRLLch3ZKcERGMSZVjNFBDX++cBklXwSJvmhDbWKjuiHj7Fa9/S9wKYWp3AKk5Jz4FHCmiHXAtUdJLDZSNuEMlf9k0Tt8csgVuGMAVPJd0HHmZtXRZk9aXHMidIak1Gv9f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=oLAjWzBN; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oLAjWzBN"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=2wa/8Egzxo2dDMSvue2WkdpmvgoFhsomLNolAW13Grs=; b=oLAjWzBNZscOW1KuUyKbuIyS99
	wXoMriz96y6RQFsk9ihC5jGW+lSQ4PqFL19UjqTcy3OOPYZ+BACiBVL06MB3sx3xYtjH0OF+IKwsM
	25hMlCoj8urzrXLkibTLLNUxRWhmVz3YG3APMMEA2qyWlqtNjcQDw3gwWta2BOPTlNL18qttv8Rn6
	9l/ugDwgPVhRrGLyXJWNtzFEYU7tuYSb//9oMVMHhnQ30h+V1imXJ3xoaFoOSL2Wp9Ucj99TzzGCz
	vQN9LXleOIv/MfUzD50jioVdY/4QAi1aggtoeMOBo/BANp1llTTPmz1JxVGcGDo/1FETV6bgsK3qO
	f1CDntaQ==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wT4d2-00000008F6L-0QwB;
	Fri, 29 May 2026 21:20:28 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-watchdog@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-doc@vger.kernel.org
Subject: [PATCH v2 5/5] watchdog: dev: convert to kernel-doc comments
Date: Fri, 29 May 2026 14:20:24 -0700
Message-ID: <20260529212024.2119204-6-rdunlap@infradead.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260529212024.2119204-1-rdunlap@infradead.org>
References: <20260529212024.2119204-1-rdunlap@infradead.org>
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
v2: no changes

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

Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D495541B8F3;
	Wed,  5 Aug 2026 10:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785925777; cv=none; b=Z6ZPCJ5vfKmVpIMMIuan+4gVkwsQ/7NkH4IX1ID/Irh97VfqtmCzzbBOJgcS3LI+zV1kZh8nSQxrgj48srRmiR2qEmwvrI5qsOmumb04r3bDh7m0gpUUV5a8emdPsfuGU40o6iMoJh7GzXHirhFRFLnFhy7UogfEJNIsKXwKHGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785925777; c=relaxed/simple;
	bh=Lj0l/kgZlVC8s6kL7zG/a/ehexvneEl0lZuN2bqPZ4E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WYDaIe3dpwwe1Et5nbfdatByvc9KWDHmO6E2/E0AVhKaTJ7xXow/a517ybId4ilU+cnFYdBNTaNTuaAFSvt2b5M0T2Ds4MP/342ZtcW7FxT4ya3E48/a31qH9kvdzs9ZR2M714TKnb2glb1J3xCJYCSqs16I7f5DMUrtOXyn3+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=u7HamKwS; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=eLYgu5xH; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="u7HamKwS";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="eLYgu5xH"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4hFRVL4mp0zKnSK;
	Wed, 05 Aug 2026 12:29:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1785925770;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=D+NnOFt++Qccg9vI9tUljTdvemgVIQkPrlrG2XCd8vQ=;
	b=u7HamKwSFl0rLKTB08/8Hxa40kvfhvkj8S3rDSJ9AFrNzBx91+qZRTojk+58axKicCEFUn
	+xxGQxieWsQrfZX/Dk12eNu33300ByYVVndUlx9Qijq6RRxSUxU69RduS463gLXwTasIbz
	MEPnC9xfKTu13kORxr3tLyJ+vGr5Ub25i4lpHER7j57+9G8T62cnvK59qMtgrJQBBAUcen
	HrGxaGivZFoJSlt5nc9B4gn7fse+bt26LrL2TZJNwz+deRCtsBcuv0/C6C/9Su6i52mzEJ
	IoxJtCVlvggonCDsGMkR4pIWhRhjKsKDidawASpcuZy3gzw9AwH5zn5ZnJjpJA==
From: Qing Ming <a0yami@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1785925769;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=D+NnOFt++Qccg9vI9tUljTdvemgVIQkPrlrG2XCd8vQ=;
	b=eLYgu5xHL8by54ij2OQ+kZrJ4QimO6Kl9+PuCwM+s5XkwELUxhReBgLHOJ25XscA38vUPB
	IcCm3qAOrL5LKAgpBCAb2smk93yccd1AzB3l6237+dFlhpzNNcFMUaqUedtfgy/MauUqfW
	j3n3NntGqz0m2ZulemksGCxlOxJqCG02Kfm+vaLO9vuply5WUTxM5LRAp8DlRZuoxe2meO
	zdb1ofVwmCj/Ln4Jv75Auzkic75brfYP96EXnzqDnEmZyN1hMPEdrQO1b1dXmUHIbBEOlD
	4zBFZJgkzFmvSLIR4hIMc/DTa50KvPOHsyF7q0mOl99QOyTPzt0Z8NcsBme2XQ==
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Qing Ming <a0yami@mailbox.org>
Subject: [PATCH] watchdog: pcwd_usb: keep device alive for open files
Date: Wed,  5 Aug 2026 18:29:07 +0800
Message-ID: <20260805102907.5354-1-a0yami@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: wie3ezjzoe9n6c4knnhu39wwftjhzitg
X-MBO-RS-ID: cff55ee3c1d3013732e

misc_deregister() prevents new opens but does not close existing watchdog
or temperature files. Both file-operation tables continue to use the global
usb_pcwd_device after usb_pcwd_disconnect() frees the private object.

Keeping a temperature file open across USB disconnect and then reading it
therefore accesses freed memory. KASAN reports:

  BUG: KASAN: slab-use-after-free in usb_pcwd_send_command+0x4f/0x480
  usb_pcwd_get_temperature+0x71/0xd0
  usb_pcwd_temperature_read+0x5e/0x90

The object was allocated by usb_pcwd_probe() and freed by
usb_pcwd_disconnect().

Store the device object in file->private_data and hold a reference for
every successful watchdog or temperature open. Use disconnect_mutex only
while stabilizing the global pointer and taking that reference, avoiding a
lock inversion with miscdevice teardown. Serialize command submission with
disconnect and quiesce the device if probe fails after the temperature
miscdevice becomes visible. Reject commands after the device is gone and
release the object after the final file is closed. Hold the usb_device
reference until the private object and its USB allocations are released.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Qing Ming <a0yami@mailbox.org>
---
 drivers/watchdog/pcwd_usb.c | 176 ++++++++++++++++++++++++++++--------
 1 file changed, 136 insertions(+), 40 deletions(-)

diff --git a/drivers/watchdog/pcwd_usb.c b/drivers/watchdog/pcwd_usb.c
index d7c18c990649..9ef7a4a47284 100644
--- a/drivers/watchdog/pcwd_usb.c
+++ b/drivers/watchdog/pcwd_usb.c
@@ -27,6 +27,7 @@
 #include <linux/types.h>	/* For standard types (like size_t) */
 #include <linux/errno.h>	/* For the -ENODEV/... values */
 #include <linux/kernel.h>	/* For printk/panic/... */
+#include <linux/kref.h>	/* For reference counting */
 #include <linux/delay.h>	/* For mdelay function */
 #include <linux/miscdevice.h>	/* For struct miscdevice */
 #include <linux/watchdog.h>	/* For the watchdog specific items */
@@ -112,6 +113,7 @@ static char expect_release;
 
 /* Structure to hold all of our device specific stuff */
 struct usb_pcwd_private {
+	struct kref		kref;
 	/* save off the usb device pointer */
 	struct usb_device	*udev;
 	/* the interface for this device */
@@ -152,6 +154,7 @@ static DEFINE_MUTEX(disconnect_mutex);
 static int usb_pcwd_probe(struct usb_interface *interface,
 						const struct usb_device_id *id);
 static void usb_pcwd_disconnect(struct usb_interface *interface);
+static void usb_pcwd_delete(struct kref *kref);
 
 /* usb specific object needed to register this driver with the usb subsystem */
 static struct usb_driver usb_pcwd_driver = {
@@ -210,14 +213,23 @@ static int usb_pcwd_send_command(struct usb_pcwd_private *usb_pcwd,
 	int got_response, count;
 	unsigned char *buf;
 
+	if (!usb_pcwd)
+		return -ENODEV;
+
+	mutex_lock(&usb_pcwd->mtx);
+
 	/* We will not send any commands if the USB PCWD device does
 	 * not exist */
-	if ((!usb_pcwd) || (!usb_pcwd->exists))
-		return -1;
+	if (!usb_pcwd->exists) {
+		got_response = -ENODEV;
+		goto out_unlock;
+	}
 
 	buf = kmalloc(6, GFP_KERNEL);
-	if (buf == NULL)
-		return 0;
+	if (!buf) {
+		got_response = 0;
+		goto out_unlock;
+	}
 
 	/* The USB PC Watchdog uses a 6 byte report format.
 	 * The board currently uses only 3 of the six bytes of the report. */
@@ -258,6 +270,8 @@ static int usb_pcwd_send_command(struct usb_pcwd_private *usb_pcwd,
 
 	kfree(buf);
 
+out_unlock:
+	mutex_unlock(&usb_pcwd->mtx);
 	return got_response;
 }
 
@@ -327,8 +341,11 @@ static int usb_pcwd_get_temperature(struct usb_pcwd_private *usb_pcwd,
 {
 	unsigned char msb = 0x00;
 	unsigned char lsb = 0x00;
+	int ret;
 
-	usb_pcwd_send_command(usb_pcwd, CMD_READ_TEMP, &msb, &lsb);
+	ret = usb_pcwd_send_command(usb_pcwd, CMD_READ_TEMP, &msb, &lsb);
+	if (ret < 0)
+		return ret;
 
 	/*
 	 * Convert celsius to fahrenheit, since this was
@@ -344,10 +361,14 @@ static int usb_pcwd_get_timeleft(struct usb_pcwd_private *usb_pcwd,
 {
 	unsigned char msb = 0x00;
 	unsigned char lsb = 0x00;
+	int ret;
 
 	/* Read the time that's left before rebooting */
 	/* Note: if the board is not yet armed then we will read 0xFFFF */
-	usb_pcwd_send_command(usb_pcwd, CMD_READ_WATCHDOG_TIMEOUT, &msb, &lsb);
+	ret = usb_pcwd_send_command(usb_pcwd, CMD_READ_WATCHDOG_TIMEOUT,
+				    &msb, &lsb);
+	if (ret < 0)
+		return ret;
 
 	*time_left = (msb << 8) + lsb;
 
@@ -361,6 +382,8 @@ static int usb_pcwd_get_timeleft(struct usb_pcwd_private *usb_pcwd,
 static ssize_t usb_pcwd_write(struct file *file, const char __user *data,
 						size_t len, loff_t *ppos)
 {
+	struct usb_pcwd_private *usb_pcwd = file->private_data;
+
 	/* See if we got the magic character 'V' and reload the timer */
 	if (len) {
 		if (!nowayout) {
@@ -382,7 +405,7 @@ static ssize_t usb_pcwd_write(struct file *file, const char __user *data,
 		}
 
 		/* someone wrote to us, we should reload the timer */
-		usb_pcwd_keepalive(usb_pcwd_device);
+		usb_pcwd_keepalive(usb_pcwd);
 	}
 	return len;
 }
@@ -390,6 +413,7 @@ static ssize_t usb_pcwd_write(struct file *file, const char __user *data,
 static long usb_pcwd_ioctl(struct file *file, unsigned int cmd,
 						unsigned long arg)
 {
+	struct usb_pcwd_private *usb_pcwd = file->private_data;
 	void __user *argp = (void __user *)arg;
 	int __user *p = argp;
 	static const struct watchdog_info ident = {
@@ -411,9 +435,11 @@ static long usb_pcwd_ioctl(struct file *file, unsigned int cmd,
 	case WDIOC_GETTEMP:
 	{
 		int temperature;
+		int ret;
 
-		if (usb_pcwd_get_temperature(usb_pcwd_device, &temperature))
-			return -EFAULT;
+		ret = usb_pcwd_get_temperature(usb_pcwd, &temperature);
+		if (ret)
+			return ret;
 
 		return put_user(temperature, p);
 	}
@@ -426,12 +452,12 @@ static long usb_pcwd_ioctl(struct file *file, unsigned int cmd,
 			return -EFAULT;
 
 		if (new_options & WDIOS_DISABLECARD) {
-			usb_pcwd_stop(usb_pcwd_device);
+			usb_pcwd_stop(usb_pcwd);
 			retval = 0;
 		}
 
 		if (new_options & WDIOS_ENABLECARD) {
-			usb_pcwd_start(usb_pcwd_device);
+			usb_pcwd_start(usb_pcwd);
 			retval = 0;
 		}
 
@@ -439,7 +465,7 @@ static long usb_pcwd_ioctl(struct file *file, unsigned int cmd,
 	}
 
 	case WDIOC_KEEPALIVE:
-		usb_pcwd_keepalive(usb_pcwd_device);
+		usb_pcwd_keepalive(usb_pcwd);
 		return 0;
 
 	case WDIOC_SETTIMEOUT:
@@ -449,10 +475,10 @@ static long usb_pcwd_ioctl(struct file *file, unsigned int cmd,
 		if (get_user(new_heartbeat, p))
 			return -EFAULT;
 
-		if (usb_pcwd_set_heartbeat(usb_pcwd_device, new_heartbeat))
+		if (usb_pcwd_set_heartbeat(usb_pcwd, new_heartbeat))
 			return -EINVAL;
 
-		usb_pcwd_keepalive(usb_pcwd_device);
+		usb_pcwd_keepalive(usb_pcwd);
 	}
 		fallthrough;
 
@@ -462,9 +488,11 @@ static long usb_pcwd_ioctl(struct file *file, unsigned int cmd,
 	case WDIOC_GETTIMELEFT:
 	{
 		int time_left;
+		int ret;
 
-		if (usb_pcwd_get_timeleft(usb_pcwd_device, &time_left))
-			return -EFAULT;
+		ret = usb_pcwd_get_timeleft(usb_pcwd, &time_left);
+		if (ret)
+			return ret;
 
 		return put_user(time_left, p);
 	}
@@ -476,29 +504,55 @@ static long usb_pcwd_ioctl(struct file *file, unsigned int cmd,
 
 static int usb_pcwd_open(struct inode *inode, struct file *file)
 {
+	struct usb_pcwd_private *usb_pcwd;
+	int ret;
+
+	mutex_lock(&disconnect_mutex);
+	usb_pcwd = usb_pcwd_device;
+	if (!usb_pcwd || !usb_pcwd->exists) {
+		ret = -ENODEV;
+		goto out_unlock;
+	}
 	/* /dev/watchdog can only be opened once */
-	if (test_and_set_bit(0, &is_active))
-		return -EBUSY;
+	if (test_and_set_bit(0, &is_active)) {
+		ret = -EBUSY;
+		goto out_unlock;
+	}
+	kref_get(&usb_pcwd->kref);
+	file->private_data = usb_pcwd;
+	mutex_unlock(&disconnect_mutex);
 
 	/* Activate */
-	usb_pcwd_start(usb_pcwd_device);
-	usb_pcwd_keepalive(usb_pcwd_device);
-	return stream_open(inode, file);
+	usb_pcwd_start(usb_pcwd);
+	usb_pcwd_keepalive(usb_pcwd);
+	ret = stream_open(inode, file);
+	if (ret) {
+		kref_put(&usb_pcwd->kref, usb_pcwd_delete);
+		clear_bit(0, &is_active);
+	}
+	return ret;
+
+out_unlock:
+	mutex_unlock(&disconnect_mutex);
+	return ret;
 }
 
 static int usb_pcwd_release(struct inode *inode, struct file *file)
 {
+	struct usb_pcwd_private *usb_pcwd = file->private_data;
+
 	/*
 	 *      Shut off the timer.
 	 */
 	if (expect_release == 42) {
-		usb_pcwd_stop(usb_pcwd_device);
+		usb_pcwd_stop(usb_pcwd);
 	} else {
 		pr_crit("Unexpected close, not stopping watchdog!\n");
-		usb_pcwd_keepalive(usb_pcwd_device);
+		usb_pcwd_keepalive(usb_pcwd);
 	}
 	expect_release = 0;
 	clear_bit(0, &is_active);
+	kref_put(&usb_pcwd->kref, usb_pcwd_delete);
 	return 0;
 }
 
@@ -509,10 +563,13 @@ static int usb_pcwd_release(struct inode *inode, struct file *file)
 static ssize_t usb_pcwd_temperature_read(struct file *file, char __user *data,
 				size_t len, loff_t *ppos)
 {
+	struct usb_pcwd_private *usb_pcwd = file->private_data;
 	int temperature;
+	int ret;
 
-	if (usb_pcwd_get_temperature(usb_pcwd_device, &temperature))
-		return -EFAULT;
+	ret = usb_pcwd_get_temperature(usb_pcwd, &temperature);
+	if (ret)
+		return ret;
 
 	if (copy_to_user(data, &temperature, 1))
 		return -EFAULT;
@@ -522,11 +579,33 @@ static ssize_t usb_pcwd_temperature_read(struct file *file, char __user *data,
 
 static int usb_pcwd_temperature_open(struct inode *inode, struct file *file)
 {
-	return stream_open(inode, file);
+	struct usb_pcwd_private *usb_pcwd;
+	int ret;
+
+	mutex_lock(&disconnect_mutex);
+	usb_pcwd = usb_pcwd_device;
+	if (!usb_pcwd || !usb_pcwd->exists) {
+		ret = -ENODEV;
+		goto out_unlock;
+	}
+	kref_get(&usb_pcwd->kref);
+	file->private_data = usb_pcwd;
+	mutex_unlock(&disconnect_mutex);
+	ret = stream_open(inode, file);
+	if (ret)
+		kref_put(&usb_pcwd->kref, usb_pcwd_delete);
+	return ret;
+
+out_unlock:
+	mutex_unlock(&disconnect_mutex);
+	return ret;
 }
 
 static int usb_pcwd_temperature_release(struct inode *inode, struct file *file)
 {
+	struct usb_pcwd_private *usb_pcwd = file->private_data;
+
+	kref_put(&usb_pcwd->kref, usb_pcwd_delete);
 	return 0;
 }
 
@@ -582,11 +661,19 @@ static struct notifier_block usb_pcwd_notifier = {
 /*
  *	usb_pcwd_delete
  */
-static inline void usb_pcwd_delete(struct usb_pcwd_private *usb_pcwd)
+static void usb_pcwd_delete(struct kref *kref)
 {
-	usb_free_urb(usb_pcwd->intr_urb);
-	usb_free_coherent(usb_pcwd->udev, usb_pcwd->intr_size,
-			  usb_pcwd->intr_buffer, usb_pcwd->intr_dma);
+	struct usb_pcwd_private *usb_pcwd;
+
+	usb_pcwd = container_of(kref, struct usb_pcwd_private, kref);
+	if (usb_pcwd->intr_urb) {
+		usb_kill_urb(usb_pcwd->intr_urb);
+		usb_free_urb(usb_pcwd->intr_urb);
+	}
+	if (usb_pcwd->intr_buffer)
+		usb_free_coherent(usb_pcwd->udev, usb_pcwd->intr_size,
+				  usb_pcwd->intr_buffer, usb_pcwd->intr_dma);
+	usb_put_dev(usb_pcwd->udev);
 	kfree(usb_pcwd);
 }
 
@@ -644,11 +731,12 @@ static int usb_pcwd_probe(struct usb_interface *interface,
 	usb_pcwd = kzalloc_obj(struct usb_pcwd_private);
 	if (usb_pcwd == NULL)
 		goto error;
+	kref_init(&usb_pcwd->kref);
 
 	usb_pcwd_device = usb_pcwd;
 
 	mutex_init(&usb_pcwd->mtx);
-	usb_pcwd->udev = udev;
+	usb_pcwd->udev = usb_get_dev(udev);
 	usb_pcwd->interface = interface;
 	usb_pcwd->interface_number = iface_desc->desc.bInterfaceNumber;
 	usb_pcwd->intr_size = (le16_to_cpu(endpoint->wMaxPacketSize) > 8 ?
@@ -747,12 +835,20 @@ static int usb_pcwd_probe(struct usb_interface *interface,
 	return 0;
 
 err_out_misc_deregister:
+	mutex_lock(&disconnect_mutex);
+	if (usb_pcwd_device == usb_pcwd)
+		usb_pcwd_device = NULL;
+	mutex_unlock(&disconnect_mutex);
+	mutex_lock(&usb_pcwd->mtx);
+	usb_pcwd->exists = 0;
+	mutex_unlock(&usb_pcwd->mtx);
+	usb_kill_urb(usb_pcwd->intr_urb);
 	misc_deregister(&usb_pcwd_temperature_miscdev);
 err_out_unregister_reboot:
 	unregister_reboot_notifier(&usb_pcwd_notifier);
 error:
 	if (usb_pcwd)
-		usb_pcwd_delete(usb_pcwd);
+		kref_put(&usb_pcwd->kref, usb_pcwd_delete);
 	usb_pcwd_device = NULL;
 	return retval;
 }
@@ -775,30 +871,30 @@ static void usb_pcwd_disconnect(struct usb_interface *interface)
 
 	usb_pcwd = usb_get_intfdata(interface);
 	usb_set_intfdata(interface, NULL);
-
-	mutex_lock(&usb_pcwd->mtx);
+	if (usb_pcwd_device == usb_pcwd)
+		usb_pcwd_device = NULL;
+	mutex_unlock(&disconnect_mutex);
 
 	/* Stop the timer before we leave */
 	if (!nowayout)
 		usb_pcwd_stop(usb_pcwd);
 
+	mutex_lock(&usb_pcwd->mtx);
 	/* We should now stop communicating with the USB PCWD device */
 	usb_pcwd->exists = 0;
+	mutex_unlock(&usb_pcwd->mtx);
+	usb_kill_urb(usb_pcwd->intr_urb);
 
 	/* Deregister */
 	misc_deregister(&usb_pcwd_miscdev);
 	misc_deregister(&usb_pcwd_temperature_miscdev);
 	unregister_reboot_notifier(&usb_pcwd_notifier);
 
-	mutex_unlock(&usb_pcwd->mtx);
-
-	/* Delete the USB PCWD device */
-	usb_pcwd_delete(usb_pcwd);
+	/* Drop the probe reference. Open files keep the object alive. */
+	kref_put(&usb_pcwd->kref, usb_pcwd_delete);
 
 	cards_found--;
 
-	mutex_unlock(&disconnect_mutex);
-
 	pr_info("USB PC Watchdog disconnected\n");
 }
 
-- 
2.53.0


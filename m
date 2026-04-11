Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FAA238A292
	for <linux-watchdog@vger.kernel.org>; Sat, 11 Apr 2026 15:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775920172; cv=none; b=ao+nR2NZe/lSXhUVohu6rJE/zjdEPZW6IfLOOEBp4vwRiQpGwSVZMlQEUc8UVJpMMaj0v92lKNGOQVp09aL7c3FgsmDZUvZiN5o/IMNEYpbpPgAPdTuksjgkLthrXx9eFBO/YjbJqXPClAE9AWqkP0kweLk9yIA0ToKh64pj28M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775920172; c=relaxed/simple;
	bh=lwKz3S60lPfR/UruL7HyqieQfuBV1mhLCaYlQ+cddJE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eQVZZIyxv588j9HLWuVKVCjTIgTM++ONKLnu5u1dJ5jgU1Kueb/mhY2GFGmnmjXOIO1KRcMwbo1v1rvScsx/QxX/EpdFPmJrl6/zMQtX0+OF/7mV6LXrRRHaGBZT+ykWMo3Jgjnxc0KmU0/2RMYrsPiQOyrRYHYQuMZsVmREL38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ohBjPBHy; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ohBjPBHy"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-35d971fb6f1so2680150a91.0
        for <linux-watchdog@vger.kernel.org>; Sat, 11 Apr 2026 08:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775920171; x=1776524971; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DZ/+0gdfc0R4BMhHn3bRqzxYcwGAO2dazgMq5MOhcqM=;
        b=ohBjPBHylU15tWrWXX/wXpW3XlFOgB4Ro7Gh+5X+ZB1zfsMlSUlN7SLiy0+GiDRbbf
         oNaKyuUb56nApujgm4xQ+aSGceuDiV7a/se3acP5c5U69/uoZk5soUARHWdPAbzdbasV
         ubqgZZbS+UbYVTWVMTXPPNATWMeB9gyxjmrk0fK5tFQYQB/8/kB0QNVP0XLuQBX/IOcL
         xIkbth8wHLLk5xDv2ZUKEugedWBLo15Xsghhp2xK93tJNJ+SvTJFVCxsBQshiAujNbBd
         XZcKJO6jpLKRyBywU0xnpYUW4anxQm6+/KoolS3cxzxihKH2I4efB8LmtOX7Q+DwSZZb
         q41w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775920171; x=1776524971;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DZ/+0gdfc0R4BMhHn3bRqzxYcwGAO2dazgMq5MOhcqM=;
        b=h5eOx2wqrdwr/Cx3RWxUiTkwwbaxdot25A+XG+NE9+IYBgpnJ2fJTnjMQK9mqLLs6j
         Cs0gdU0JGLiczr9gBn8Lv7ahRsWrOWnFrVa8m1SIRJXZYuIRz3sEnf/9Cb2vpEe4qAW6
         UwPHT8pykMoUXQIok4RLBhnxBJYAC9eObdFEAqQT/nWenXbjGCgbgojrOeSFQceN7ECm
         R2dDrLQ5uQ6Rq5Ya/IjCxTQh2kBDeH/3uo6JSAWHWfXFejLgPg5iCZm+mFP0WvdtLb4A
         CKiPLzFxyM/PVQZcHBFvTLmZUMf/orYQ4tKJmY4OP+cVhLk5SNtrF2i3AIC/Qidu3ZyF
         YsvA==
X-Forwarded-Encrypted: i=1; AJvYcCWIOsfc41jJi+mRhuSXdbjyrhRZrultk+iCu+z0/PImGEYNQDem5+GGi4AkDQRRBBQ3Z9XVhFAGmTdnP/Fapg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwE/+VCVu5j8bQFUVrPiM5+KLxL1OgxJsnniSthN1LFVyxdlpVD
	2cjUOD8RmQSqEFhW6NhlL0girAp50bvYKtEfK6xIG6XT5LAoZdAOOk/Y
X-Gm-Gg: AeBDiet8WdVsNHIM+MUWoFhuuuhG3ienLNpI9OBaKHj3oN85GP6qlNwfmTTwKF5dmfQ
	iZIZ6mqlT/fvmeUqVwD1JtPtQ4Rn13PV5Osakm/yYEdjIkPpwtSzS9QJIn4VY6TPi4+aUYpb75V
	sQOrXl+Pmjzq2FgrN+3H7j1S6JoKJbtDHHSXqblg0Nrat5XEUBRzCBNPyayE7SfnIQ5GctvUX3S
	bKo4aQFtWUiM+rmYx4kJsrwDyk+o2t5m5DZ1nupbZ58Nb2BXwWVvV4XGHBgefSkJ7pn6k0JqFC9
	Av1FalQ7j45v90KDXc99NuYU9KOQZZYRKZq7M+86bTpkepnlXBYcn5DBX7tuLfRJzuyiKuPpMzv
	EA28Y+kfRhr2/eSWTRLy1uYeJLoebmS43rg/e7Fak6llaKIXh01NKWYp2I72F3ZhR0/Jxw1/FPl
	W3AJGCmU4enzGhvB18Lpiwg6qFVInXOZVbA8hUqIwdSJcB
X-Received: by 2002:a17:903:2c04:b0:2b2:4fcc:2687 with SMTP id d9443c01a7336-2b2d5a49c8cmr71870425ad.31.1775920170865;
        Sat, 11 Apr 2026 08:09:30 -0700 (PDT)
Received: from tech-Alienware-m15-R6.. ([122.171.18.84])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2d4f431c3sm58526515ad.79.2026.04.11.08.09.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2026 08:09:30 -0700 (PDT)
From: Sunny Patel <nueralspacetech@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-watchdog@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sunny Patel <nueralspacetech@gmail.com>
Subject: [PATCH v2] Documentation: Refactored watchdog old doc
Date: Sat, 11 Apr 2026 20:39:14 +0530
Message-ID: <20260411150922.20536-1-nueralspacetech@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <3e25ae54-e62d-484e-8d90-4f7825705e4f@roeck-us.net>
References: <3e25ae54-e62d-484e-8d90-4f7825705e4f@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Mark WDIOC_GETTEMP and WDIOS_TEMPPANIC as deprecated since
neither is implemented by the watchdog core and both are only
present in a small number of legacy drivers.

Add documentation for previously undocumented status bits
WDIOF_MAGICCLOSE and WDIOF_ALARMONLY in the options field.

Add documentation for WDIOF_PRETIMEOUT and WDIOF_SETTIMEOUT
status bits describing their respective ioctls.

Fix the following issues in existing documentation:
  - Remove version-specific reference to Linux 2.4.18 from
    the GETTIMEOUT ioctl description
  - Fix duplicate "was is" in printf format strings
  - Replace [FIXME] placeholder with proper descriptions for
    WDIOS_DISABLECARD, WDIOS_ENABLECARD and WDIOS_TEMPPANIC

Signed-off-by: Sunny Patel <nueralspacetech@gmail.com>
---

Changes in v2:
  - Fixed typos: "tiemout" -> "timeout", "characted" -> "character"
  - Fixed "small number if legacy" -> "of legacy"
  - Fixed capitalization: "New Drivers" -> "New drivers", "USE" -> "Use"
  - Fixed spacing: "WDIOS_DISABLECARD,this" -> "WDIOS_DISABLECARD, this"
  - Fixed double spaces in two places
  - Added missing newline at end of file
  - Rewrote commit message

 Documentation/watchdog/watchdog-api.rst | 59 +++++++++++++++++++++----
 1 file changed, 51 insertions(+), 8 deletions(-)

diff --git a/Documentation/watchdog/watchdog-api.rst b/Documentation/watchdog/watchdog-api.rst
index 78e228c272cf..3e9021a79671 100644
--- a/Documentation/watchdog/watchdog-api.rst
+++ b/Documentation/watchdog/watchdog-api.rst
@@ -2,7 +2,7 @@
 The Linux Watchdog driver API
 =============================
 
-Last reviewed: 10/05/2007
+Last reviewed: 04/08/2026
 
 
 
@@ -106,11 +106,10 @@ the requested one due to limitation of the hardware::
 This example might actually print "The timeout was set to 60 seconds"
 if the device has a granularity of minutes for its timeout.
 
-Starting with the Linux 2.4.18 kernel, it is possible to query the
-current timeout using the GETTIMEOUT ioctl::
+It is also possible to get the current timeout with the GETTIMEOUT ioctl::
 
     ioctl(fd, WDIOC_GETTIMEOUT, &timeout);
-    printf("The timeout was is %d seconds\n", timeout);
+    printf("The timeout is %d seconds\n", timeout);
 
 Pretimeouts
 ===========
@@ -133,7 +132,7 @@ seconds.  Setting a pretimeout to zero disables it.
 There is also a get function for getting the pretimeout::
 
     ioctl(fd, WDIOC_GETPRETIMEOUT, &timeout);
-    printf("The pretimeout was is %d seconds\n", timeout);
+    printf("The pretimeout is %d seconds\n", timeout);
 
 Not all watchdog drivers will support a pretimeout.
 
@@ -145,7 +144,7 @@ before the system will reboot. The WDIOC_GETTIMELEFT is the ioctl
 that returns the number of seconds before reboot::
 
     ioctl(fd, WDIOC_GETTIMELEFT, &timeleft);
-    printf("The timeout was is %d seconds\n", timeleft);
+    printf("The timeout is %d seconds\n", timeleft);
 
 Environmental monitoring
 ========================
@@ -227,12 +226,33 @@ The watchdog saw a keepalive ping since it was last queried.
 	WDIOF_SETTIMEOUT	Can set/get the timeout
 	================	=======================
 
-The watchdog can do pretimeouts.
+The watchdog supports timeout set/get via the WDIOC_SETTIMEOUT and
+WDIOC_GETTIMEOUT ioctls.
 
 	================	================================
 	WDIOF_PRETIMEOUT	Pretimeout (in seconds), get/set
 	================	================================
 
+The watchdog supports a pretimeout, a warning interrupt that fires before
+the actual reboot timeout. Use WDIOC_SETPRETIMEOUT and WDIOC_GETPRETIMEOUT
+to set/get the pretimeout.
+
+	================	================================
+	WDIOF_MAGICCLOSE	Supports magic close char
+	================	================================
+
+The driver supports the Magic Close feature, The watchdog is only disabled
+if the character 'V' is written to /dev/watchdog before the file descriptor
+is closed. Without this, closing the device disables the watchdog
+unconditionally.
+
+	================	================================
+	WDIOF_ALARMONLY	    Not a reboot watchdog
+	================	================================
+
+The watchdog will not reboot the system when it expires. Instead it
+triggers a management or other external alarm. Userspace should not
+rely on a system reboot occurring.
 
 For those drivers that return any bits set in the option field, the
 GETSTATUS and GETBOOTSTATUS ioctls can be used to ask for the current
@@ -254,6 +274,11 @@ returned value is the temperature in degrees Fahrenheit::
     int temperature;
     ioctl(fd, WDIOC_GETTEMP, &temperature);
 
+.. deprecated::
+	``WDIOC_GETTEMP`` is not implemented by the watchdog core. It is only
+	supported by a small number of legacy drivers. New drivers should not
+	implement it.
+
 Finally the SETOPTIONS ioctl can be used to control some aspects of
 the cards operation::
 
@@ -268,4 +293,22 @@ The following options are available:
 	WDIOS_TEMPPANIC		Kernel panic on temperature trip
 	=================	================================
 
-[FIXME -- better explanations]
+``WDIOS_DISABLECARD`` stops the watchdog timer. The driver will cease
+pinging the hardware watchdog, allowing a controlled shutdown without
+a forced reboot. This is equivalent to the watchdog being disarmed.
+
+``WDIOS_ENABLECARD`` starts the watchdog timer. If the watchdog was
+previously stopped via ``WDIOS_DISABLECARD``, this will re-enable it. The
+hardware watchdog will begin counting down from the configured timeout.
+
+``WDIOS_TEMPPANIC`` enables temperature-based kernel panic. When set,
+the driver will call ``panic()`` (or ``kernel_power_off()`` on some
+drivers) if the hardware temperature sensor exceeds its threshold,
+rather than only setting the ``WDIOF_OVERHEAT`` status bit. Support
+for this option is driver-specific, not all watchdog drivers implement
+temperature monitoring.
+
+.. deprecated::
+	``WDIOS_TEMPPANIC`` is not implemented by the watchdog core and is only
+	present in a small number of legacy drivers. New drivers should not
+	implement it.
-- 
2.43.0


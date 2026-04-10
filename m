Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5F738D68F
	for <linux-watchdog@vger.kernel.org>; Fri, 10 Apr 2026 07:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775805925; cv=none; b=a4JLWY8xvGPcKfyU6Bb7S0nsbBlGpz/G8c/V60iLZtU/pfw99AO0mwHCjIO+HZd3AwM8B8I8DeJJ23j3K1hczMh8eOHzxmlLrAT5aYsRUoMsMlUFFBfQlkv412qC+5bv0/CXwsvvbVKGZTywHUEnUXvBVXbHNDhUAcDgplisVy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775805925; c=relaxed/simple;
	bh=ua1/GjFq5UBIw4chHlHvFZCaOtW3aUXSxAj6LfiyLnw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XOlVeKDjXpBHutdEv87OZ8DnJfAaLL21PMC1F+ZT4zUDMvNEf+qzVSIuz2RtsxrOHAzlMmIP9UKukokPm9i/FSzjaHqZOV3GcUqG1ViT9nkLbQr/e/8UbcxfomDPha/dCEtnFJC16x/AcD9zbJJQLGZIuvBZ7J8P+7yPwPoVZ38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z1QJAP2M; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z1QJAP2M"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c736261ee8dso717425a12.1
        for <linux-watchdog@vger.kernel.org>; Fri, 10 Apr 2026 00:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775805923; x=1776410723; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KGRPycyP0bYCi0FYmQRd0IwF9nhHr5uM+DqBSnm5Sws=;
        b=Z1QJAP2Mo1YWgBAbgU8hWFOig6Z+QXHU75CagN2wfKdOfcDtDGrJBoFjGHbudssrH3
         o6m/n3115/DMSjK779+2P+/ckFryB7IxMvNL6NTV2FgVvFutoRGGV3+L5FhPg8xbk9dA
         J2NHoYBBByiDwG9iXv1edq3U7EGC797ZB5HvpbzyEEHYiOAgchk39gPFQxBRkNNjPOJR
         yyz9z9lQ6HrVWH8zdCAuSC+Qlt1PFnuPwaNYvnCoGznwq+LXM/jllRWjiFrV+9+UReBi
         yr2rEg6tX59Hh6wC1aLqaFyGilTb2rf6u8k+LsD287XQga3ekw+ax0XTd1B8cIHf2eXG
         YeOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775805923; x=1776410723;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KGRPycyP0bYCi0FYmQRd0IwF9nhHr5uM+DqBSnm5Sws=;
        b=maJRr1nUpgePp+nWveXnS4yl6epF7jkvHde+zc2JiJEZumJNQE4jYslG2azWJxVDlU
         OgB5xMml45LNpkv7Spgw1CUukoB5IGwTI04lqNXG/gvAX8FJgvbxV5knUnXuxywpsQlu
         DmJSu3l9eq9l+jqEMg/rAXFmFxpZa6KERcmurKB4AZPjOO9h/1vPixodUdKXy00jfCWG
         axr1zp4UWgToA3FLvqMs3H3nGthte4r2Vo7DKOSoe6LMY/L5NIjhMc+rX2yufWNL5quJ
         RtdgNOSuAElt6taJh70bBXZgaNdUmWrFYZCEUz5J61aWJ/dbrjmbU6kheuQI/Z/q1zjX
         aWGA==
X-Forwarded-Encrypted: i=1; AJvYcCXWlIujAWUwmhk1ne5Mfl2lKHoWhH33aaD+fwMjHIPf/ETNUYCpthwVw9gCD8pwHG1EcMquExoeOxGrh9oKYg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+mozhdLfzOSWQv0TiolLg7kUf0Dg/D7QKVhH4HwIbEbTAbCA+
	RV1gSZHu/DLRBWgB10UnzwjTwlDyCuFOd4E3h0dYLV5IAYFNdufJQJRE
X-Gm-Gg: AeBDievWzhiSWlIc1ZlSr6AqnwUlQJKKIe8z9z7Hz2dUaBUcAEIISKJd7WxL+mWdpla
	DO9MFCdB9Pn7VtJLY0T4Hdkqj4RBpsU3RQ5neQybcR72LAYTRKY1v9lV0eA2chnULQCC8vLqEqu
	Ih6TF2yMWac59PqwoJlby2i6quNv3+zYZfmGWi8bd5A8Ugp8vgx0yYCCvWpJWDOdUjjhWwr8arK
	dReJHfqe9cZpl+8H1ZRB5fgM90wvyk3aYN6MXHoG7Ej9kTKcVB4C/5CokMNEBl0C9cogH4Qwfo3
	6Gha3uvSQQGO8Lnmlg0UYa+zgyS3jy5KgYPzE6DAWLseWIeZqG+wqR0Ag4fWMxMSbEgiOQwftg/
	eJHNUbBPTpwxHVixN+HY4izhUXCErv0j54z69QGDPsD2s0fEJgTtCXQ1HJFk5T3Yk7NhFSAyxFt
	1PiZa/UkGbpaNTydlii5BRN5z2CFmHpqJ50uIJxc6i50lD
X-Received: by 2002:a05:6a20:2451:b0:398:bcee:4502 with SMTP id adf61e73a8af0-39fe3f15038mr2590195637.33.1775805923490;
        Fri, 10 Apr 2026 00:25:23 -0700 (PDT)
Received: from tech-Alienware-m15-R6.. ([122.171.16.65])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7922de0626sm1375083a12.13.2026.04.10.00.25.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 00:25:22 -0700 (PDT)
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
Date: Fri, 10 Apr 2026 12:45:50 +0530
Message-ID: <20260410072211.14441-1-nueralspacetech@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Good Point. So again revisited the watchdog core
api and list out the deprecated one and marked
as deprecated in doc and also mentioned it just
for legacy driver and not for newer one.

As someof the legacy driver still have reference 
to old api so just marked as deprecated in doc.

Also checked with other watchdog related api
which are deprecated in driver but still present 
in doc but didn't find any.

---

Revisited old doc of watchdog and did some cleanup.
Also added support for new api in doc. Which is
WDIOF_MAGICCLOSE and WDIOF_PRETIMEOUT.

Reierate the core api and Mark WDIOC_GETTEMP and
WDIO_TEMPPANIC as deprecated.Both are absent from
the watchdog core and only present in legacy driver.

Signed-off-by: Sunny Patel <nueralspacetech@gmail.com>
---
 Documentation/watchdog/watchdog-api.rst | 59 +++++++++++++++++++++----
 1 file changed, 51 insertions(+), 8 deletions(-)

diff --git a/Documentation/watchdog/watchdog-api.rst b/Documentation/watchdog/watchdog-api.rst
index 78e228c272cf..e11575db93e6 100644
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
+The watchdog supports  timeout set/get via the WDIOC_SETTIMEOUT and
+WDIOC_GETTIMEOUT ioctls.
 
 	================	================================
 	WDIOF_PRETIMEOUT	Pretimeout (in seconds), get/set
 	================	================================
 
+The watchdog supports a pretimeout, a warning interrupt that fires before
+the actual reboot tiemout. USE WDIOC_SETPRETIMEOUT and WDIOC_GETPRETIMEOUT
+to set/get the pretimeout.
+
+	================	================================
+	WDIOF_MAGICCLOSE	Supports magic close char
+	================	================================
+
+The driver supports the Magic Close feature, The watchdog is only disabled
+if the characted 'V' is written to /dev/watchdog before the file descriptor
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
+	supported by a small number of legacy drivers. New Drivers should not
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
+``WDIOS_ENABLECARD`` starts the watchdog timer. if the watchdog was
+previously stopped via ``WDIOS_DISABLECARD``,this will re-enable it. The
+hardware watchdog will begin counting down from the configured timeout.
+
+``WDIOS_TEMPPANIC`` enables temperature-based kernel panic. When set,
+the driver will call ``panic()`` (or ``kernel_power_off()`` on some
+drivers) if the hardware temperature sensor exceeds its threshold,
+rather than only setting the ``WDIOF_OVERHEAT`` status bit. Support
+for this option  is driver-specific, not all watchdog drivers implement
+temperature monitoring.
+
+.. deprecated::
+	``WDIOS_TEMPPANIC`` is not implemented by the watchdog core and is only
+	present in a small number if legacy drivers. New Drivers should not
+	implement it.
\ No newline at end of file
-- 
2.43.0


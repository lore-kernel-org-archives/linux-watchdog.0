Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597EA37DE81
	for <linux-watchdog@vger.kernel.org>; Mon, 13 Apr 2026 04:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776053551; cv=none; b=bi3o+rB3yDqUYHoJ5sSYWVUhxBJaT3NE69VhCBPp471IKZ+laazz8FZmN3urmUR3V5VY6DsF2HbxYzu2LS3F3+/d0UhN+4Po6mHoil+LjAwwIR3E9mKLMk5deuvnoWETVoxOgvWqsNx0cEBBhYXfytEUvKPZSHfiCvWJeqVFVnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776053551; c=relaxed/simple;
	bh=Nfx8SY0UEvaq6+gSxlXjMVt/bs4KEn/ejYgsUpz3yFU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nJQ7wL2hjXs2OsBTe6yHy9rw1Ypgenpi8oQ+pCVBAKhXln3r9/NSRNRJSX4mcQ8GhAcx56GrVsiYMy2f+2qkJyNnns7lNvvFs/oZOW6Maoi5sUhihVYmLMzv2Y3RSG9VEV3xWceLhaiH98Q7t3RCRKfzs8oB16/pvMWa+DMx1PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PVt1hTfd; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PVt1hTfd"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-82748257f5fso2132592b3a.1
        for <linux-watchdog@vger.kernel.org>; Sun, 12 Apr 2026 21:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776053544; x=1776658344; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EiR3khxQhFmDzcy0QJGcEyjroXltDHGy0h+uzT9wKzQ=;
        b=PVt1hTfdiTbS4jYbHQY1h6aJn5MhPlqg4nuCk7bYFfKjFsGgt1UOzV91D5wChlKE1H
         4sPhNmMdF5zqI4izWGIAWx+nRXcdsyxkKE3sqmIc6Kf0B3a+Ep9ttoyR6BN/1qNXSluy
         ukazZiOuHc0gsi0pOV03bhR7Liy5m1DkbiQ621onz96DByGNz8R/R3Amr9Ltqsv29J8i
         /EzpmrTMzy+1qLJTI9ySQPib9H7tokrejir3Jeljk49NZXjiyHiA0urzwAYmR+LdpHL7
         XUQzZAU34C0tnQkVt3oVWFTEpYg/aN/+gMskdXSR6VKtx2rxEK9RXKLWxN23Rh9dPST8
         EK6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776053544; x=1776658344;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EiR3khxQhFmDzcy0QJGcEyjroXltDHGy0h+uzT9wKzQ=;
        b=biENgSmGg/EByvCRgQbrBaHHbE6k2Y5AUk5NUYdPsQ4C3/O7Q0jp6esyFeGn8K8ZWQ
         +S6HeaPCwiBnY1+c3hrtJVyTWnDZgrf4Zcv0KzwY91NztTBF8Zlm2LhtIcchPCSKdGEe
         9a2AHV5EKnXyYea5hYh0t9yt1VMDHbnitXD/Z3FPa3qqshah5obbpKC6AgmQlZJW44VX
         jAh5y4dbiFtBNpsCyVU5tia6VgUdSi1tu3iWxKFNoLpubUvPPSQqrmV5jPemy/vtjXU2
         EqfRo0S1p9jvrgPjbpZ9AdtvfC8GtXOrtSjth2ESFKYf/K21neJLMX/V46YCnYo9jLv4
         DXfw==
X-Gm-Message-State: AOJu0YzkKM4fAesPTQLxL6ig/JryHRNt8N2Xvu5wNCtF2PLNP9bztytH
	U5FXQYt8VIMvPWhx79Gs3P5iT8JEAVwHRS4jmMxqH+1eboWYsBDMVUXy
X-Gm-Gg: AeBDievKbMmqJuJXSKBoCyfYJDIUtJl5w2uMpSZz51bFFSGbrmR//ZezFhXKV9K9HVE
	WRBjnX5r+Ow7FXI9o2PLR+y6kNmBUKPULwGj7MAp7QxzxfBIVdobDNHJgTc2uleOovHcswvOBN6
	tRXefrnKZWwkWcUrVQ3n8TUqEUQVqYRw/u3H3Ar338+udjepCHSfVj2Nv2IIwcPkc26fYarIHeL
	a7HFnWIuHLK368KbP293Bf4dvFjmuLDE6y2262UtHv8ZDSci5D3HGZ/AXcRFByEFjlmXIhzABkR
	GZFsT0Ed9yi+p62tWdUyuhHq1RY0bY1Y/mg6eZJ7qFeev2m6rLUQydeqjwSJnjOTA1PsSpcSQqG
	YmOK98XLI5DphquG7+wF757dTf5KSPvf6yNj827lo3FBrZsvcBRIOXjMfOND4Zn7a/C1PaPA1qG
	DwKmY74ZMCmUnygpyrgbGUbjM2HKfuiaVjydg1fWhF7dSD
X-Received: by 2002:a05:6a20:1e42:b0:3a0:21ed:7e66 with SMTP id adf61e73a8af0-3a021ed7f66mr1782966637.25.1776053543674;
        Sun, 12 Apr 2026 21:12:23 -0700 (PDT)
Received: from tech-Alienware-m15-R6.. ([122.171.18.84])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c79219c618asm8578587a12.18.2026.04.12.21.12.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2026 21:12:23 -0700 (PDT)
From: Sunny Patel <nueralspacetech@gmail.com>
To: linux-doc@vger.kernel.org
Cc: linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	corbet@lwn.net,
	wim@linux-watchdog.org,
	linux@roeck-us.net,
	rdunlap@infradead.org,
	Sunny Patel <nueralspacetech@gmail.com>
Subject: [PATCH v5] Documentation: Refactored watchdog old doc
Date: Mon, 13 Apr 2026 09:41:55 +0530
Message-ID: <20260413041215.10362-1-nueralspacetech@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Changes in v5:
  - Fixed WDIOC_GETTIMELEFT printf statement to correctly reference 
    "timeleft" instead of "timeout".
  
Changes in v4:
  - Fixed WDIOS_DISABLECARD description: corrected inverted logic —
    the ioctl disables the hardware timer entirely rather than
    stopping pings. Clarified that userspace, not the kernel driver,
    is primarily responsible for pinging under normal operation.

 Documentation/watchdog/watchdog-api.rst | 65 +++++++++++++++++++++----
 1 file changed, 55 insertions(+), 10 deletions(-)

diff --git a/Documentation/watchdog/watchdog-api.rst b/Documentation/watchdog/watchdog-api.rst
index 78e228c272cf..736436a68f65 100644
--- a/Documentation/watchdog/watchdog-api.rst
+++ b/Documentation/watchdog/watchdog-api.rst
@@ -2,7 +2,7 @@
 The Linux Watchdog driver API
 =============================
 
-Last reviewed: 10/05/2007
+Last reviewed: 04/08/2026
 
 
 
@@ -42,7 +42,7 @@ activates as soon as /dev/watchdog is opened and will reboot unless
 the watchdog is pinged within a certain time, this time is called the
 timeout or margin.  The simplest way to ping the watchdog is to write
 some data to the device.  So a very simple watchdog daemon would look
-like this source file:  see samples/watchdog/watchdog-simple.c
+like this source file: see samples/watchdog/watchdog-simple.c
 
 A more advanced driver could for example check that a HTTP server is
 still responding before doing the write call to ping the watchdog.
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
 
@@ -145,12 +144,12 @@ before the system will reboot. The WDIOC_GETTIMELEFT is the ioctl
 that returns the number of seconds before reboot::
 
     ioctl(fd, WDIOC_GETTIMELEFT, &timeleft);
-    printf("The timeout was is %d seconds\n", timeleft);
+    printf("The timeleft is %d seconds\n", timeleft);
 
 Environmental monitoring
 ========================
 
-All watchdog drivers are required return more information about the system,
+All watchdog drivers are required to return more information about the system,
 some do temperature, fan and power level monitoring, some can tell you
 the reason for the last reboot of the system.  The GETSUPPORT ioctl is
 available to ask what the device can do::
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
+The driver supports the Magic Close feature. The watchdog is only disabled
+if the character 'V' is written to /dev/watchdog before the file descriptor
+is closed. Without writing 'V' before closing, the watchdog remains active
+and will trigger a reboot after the timeout expires.
+
+	================	================================
+	WDIOF_ALARMONLY		Not a reboot watchdog
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
 
+.. note::
+	``WDIOC_GETTEMP`` is not implemented by the watchdog core and is
+	considered deprecated. It is only supported by a small number of
+	legacy drivers. New drivers should not implement it.
+
 Finally the SETOPTIONS ioctl can be used to control some aspects of
 the cards operation::
 
@@ -268,4 +293,24 @@ The following options are available:
 	WDIOS_TEMPPANIC		Kernel panic on temperature trip
 	=================	================================
 
-[FIXME -- better explanations]
+``WDIOS_DISABLECARD`` disables the hardware watchdog timer entirely,
+allowing a controlled system shutdown without triggering a reboot.
+Userspace is responsible for pinging the watchdog under normal
+operation; this ioctl stops the underlying hardware timer so that
+the absence of pings no longer causes a system reset.
+
+``WDIOS_ENABLECARD`` starts the watchdog timer. If the watchdog was
+previously stopped via ``WDIOS_DISABLECARD``, this will re-enable it. The
+hardware watchdog will begin counting down from the configured timeout.
+
+``WDIOS_TEMPPANIC`` enables temperature-based kernel panic. When set,
+the driver will call ``panic()`` (or ``kernel_power_off()`` on some
+drivers) if the hardware temperature sensor exceeds its threshold,
+rather than only setting the ``WDIOF_OVERHEAT`` status bit. Support
+for this option is driver-specific; not all watchdog drivers implement
+temperature monitoring.
+
+.. note::
+	``WDIOS_TEMPPANIC`` is not implemented by the watchdog core and is
+	considered deprecated. It is only present in a small number of
+	legacy drivers. New drivers should not implement it.
-- 
2.43.0


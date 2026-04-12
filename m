Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6877B212548
	for <linux-watchdog@vger.kernel.org>; Sun, 12 Apr 2026 08:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775982142; cv=none; b=GWdclfxUKYA8itqMpVVO0RLTcxvpJICbWs87irguEZXHqg2hotbiMC2HuX9I7qaQvb1pzi++TXvyb7+g17FXiItra8iM6AZwzfA940jsflL1E2t6ZuBznj9Tj5hDFOOQ/jv1CWwqN/FEilk7FG4Y6ymf11m8FGz9xZVS6J4YZ8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775982142; c=relaxed/simple;
	bh=07CBgzXeAUWv4NrmNUnsSFnmCkQR2o04FGbGs92uPQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rxFhk+0RQM2i4qJpiS3AEcgK4mo0+8fwWGWI7UkqLigVqLK0znl0OSdGA3b2jutGIwzMwTUR9Cpm3rCAlyBJwv8enWJ5PPaj4SpdktGFR85kPertpKuB/9CLGGatuCt0DoNCyUOtq5YPcIXbQKxZoCVGzCpuH8/rqU3FANc4tNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aQLfiFB9; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aQLfiFB9"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-35da9c0c007so3257888a91.2
        for <linux-watchdog@vger.kernel.org>; Sun, 12 Apr 2026 01:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775982139; x=1776586939; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NIdNWDTJB8MnCsFnYSBxZ8TNMLf27pK1qRPFQutjdXY=;
        b=aQLfiFB91mXJE7xmdEgsnoQ3zJWvpbSFYG4vhs0XdpL0gdwH90WLM+P5PQUlPPz/LF
         pQSG9M+C2JpPXyf7rFr3NpobOs7rsGE1/aavAfv7Yml56XK5lPhom43Yw+OUyc9YkQhe
         fymHieeFwSZhXlsvkwnpe70Nu/LWLtjJtI6r/Ah+XKKX+ltE3OKpc12rGknh3umzCUV6
         cPL/xvSfst4tjwEGk0hxDyPZ0G47MPrVDst2JG2ZcZvW7N2eKEnEWqvVfRjl8Ny1hSvH
         BxzkkfuhEGCDmoJLFhd4BWIvfBHd1BMFREkWfjJKHAFuDGUnD1s1W8zH2+y/OInGf+0N
         zatg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775982139; x=1776586939;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NIdNWDTJB8MnCsFnYSBxZ8TNMLf27pK1qRPFQutjdXY=;
        b=Ix7uvmZvW3UClePV6UyO5FGK+B0xQ3N5dUDmOxfWpcSjdtxAjt2+NvDD1TNAN4sZ0/
         szw58VoO5O9E8ZEMtYJoWjMPTvCLwncl5drd8ILOas6f+8E6/dTgiWbsogpMKYoFz1Qp
         kpNKBb3Kc0/joX6tXCBJMx1xN+2K2nrRnM53fBxXkNICBNOBeWMj+XgOFKcx+SJOHboC
         t83TlzxXYT0KKkc9RMhu8m3lTz2HvrnRkAMnjCAaK2dyvaN1mBBCBbaMk8WMjWrhEw3t
         gAgCWAfsRjUsbPBuq+509JfjFayC/rX9Ettp+SjJSGQ/jQ0KhpNSnbMj1p2/iIueZz4p
         0Wbg==
X-Gm-Message-State: AOJu0YwIvuwqe+XDb9Ye4+cOXdHAdjCiRBhtLuIwqOuvLc3J9DWBFVw9
	gzJY4uEVxksyN1JUC5y1/VBgUw9HqIX/DpZ3e4UUZuTWm3cNl+7V7IIG
X-Gm-Gg: AeBDiesPCw8TAMwLzoHjGBd3kkv0bvOehttVvaUBcKwWBe5xe8d/Ssrib74ABhDEq5K
	BQ0tF4ZGZN7IJ6ujZmdRegRH/Jok5TPNcMpPQTMkWyvIqmjhLb30mXBYpfrzD/QHBC4Io6oAMVe
	GpPDYwrubroAYhlQzJkFKt2SG2yb17bYmtjR1XflF+XUQlVoYO63zNbVaPoMjRZS4DWKm56rm2o
	rFDz2B3iTKnYjOF7FZgJHUVP7RqydGAUF9SbtcpTGq+tnsi28yAmmmkb0TEn/25gNVXMXhBfr09
	HsYXKA7Evg8rrYogHAMH+5p3BO+/0iX2PXar5rnzVtVG7FE+uhFT4s1NDSSOKVFRxGBGiK02H+V
	NirP1aUwRvewmoqBmiwmp6duxRgeAy0ocspbP8DZQNAU/Z9E88rqGQYRrMsCo+WqLLB7vyS9g0C
	cZvtWGw0hN+d6v1Amf7r+FSL1c+z0LviNC2UWMvqw3NU+FCQOnx4qf2pY=
X-Received: by 2002:a17:90b:390d:b0:35b:929f:7e92 with SMTP id 98e67ed59e1d1-35e42827fbbmr9779773a91.18.1775982138636;
        Sun, 12 Apr 2026 01:22:18 -0700 (PDT)
Received: from tech-Alienware-m15-R6.. ([122.171.18.84])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35e4131d1desm8593167a91.9.2026.04.12.01.22.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2026 01:22:18 -0700 (PDT)
From: Sunny Patel <nueralspacetech@gmail.com>
To: linux-doc@vger.kernel.org
Cc: linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	corbet@lwn.net,
	wim@linux-watchdog.org,
	linux@roeck-us.net,
	rdunlap@infradead.org,
	Sunny Patel <nueralspacetech@gmail.com>
Subject: [PATCH v3] Documentation: Refactored watchdog old doc
Date: Sun, 12 Apr 2026 13:52:05 +0530
Message-ID: <20260412082210.31352-1-nueralspacetech@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260411150922.20536-1-nueralspacetech@gmail.com>
References: <20260411150922.20536-1-nueralspacetech@gmail.com>
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

Changes in v3:
  - Replaced .. deprecated:: with .. note:: to avoid Sphinx
    build warning due to missing version argument
  - Fixed WDIOF_MAGICCLOSE description: corrected inverted
    behaviour — without 'V', watchdog remains active and
    reboots, it does not disable unconditionally
  - Fixed comma splice: "Magic Close feature, The" ->
    "Magic Close feature. The"
  - Fixed WDIOF_ALARMONLY table alignment (malformed table)
  - Fixed "driver-specific," -> "driver-specific;" (semicolon)
  - Fixed identity row indentation in watchdog_info table

Note: This is sent as v3 and not v4. The previous submission
was v2 and this directly addresses the review comments on it.
The version was not bumped to v4 to keep the revision history
consistent with the actual number of review cycles this patch
has gone through.

 Documentation/watchdog/watchdog-api.rst | 63 +++++++++++++++++++++----
 1 file changed, 53 insertions(+), 10 deletions(-)

diff --git a/Documentation/watchdog/watchdog-api.rst b/Documentation/watchdog/watchdog-api.rst
index 78e228c272cf..83848d02959d 100644
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
+    printf("The timeout is %d seconds\n", timeleft);
 
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
+for this option is driver-specific; not all watchdog drivers implement
+temperature monitoring.
+
+.. note::
+	``WDIOS_TEMPPANIC`` is not implemented by the watchdog core and is
+	considered deprecated. It is only present in a small number of
+	legacy drivers. New drivers should not implement it.
-- 
2.43.0


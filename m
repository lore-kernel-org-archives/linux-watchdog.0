Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70A93191CA
	for <linux-watchdog@vger.kernel.org>; Fri, 10 Apr 2026 07:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775806115; cv=none; b=RjhQ2VgkNucmw4eV3pPn9lUq3JdRo8npS+6HtlrRo0WPLNbShvgZIsK9wAXQEIkBju6G1yByT7F5+EEsJk22aqZ7dujAGaOZ6pEeNgyvl7tQ6X5M+YOqsmSoQvDhHGll4a1E7inlOu1r5urVnJzEjWIXyuss/oKPJiWrndrDma4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775806115; c=relaxed/simple;
	bh=ua1/GjFq5UBIw4chHlHvFZCaOtW3aUXSxAj6LfiyLnw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GoanLjza5FkWO+lZQHluq5fgy1qxTUOegcW5QPuxLYNHqisSUSX0NTSPT6iGVqyDkIRiAo/2oXyY8oqs76uxt2StVWWVXp+ogn2GVEZIFk+vmj9gK+GujpM3VJV23t0O1xRwUMJOPS1y9f/fujOA1YTVkCiN831tTS9ryyS6WoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fjo7hpSU; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fjo7hpSU"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-824c9da9928so1582370b3a.3
        for <linux-watchdog@vger.kernel.org>; Fri, 10 Apr 2026 00:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775806113; x=1776410913; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KGRPycyP0bYCi0FYmQRd0IwF9nhHr5uM+DqBSnm5Sws=;
        b=Fjo7hpSUYTyPzHwGCV4Z98vGsOChF5IZu3U+fTfeCZ+Zqy2n6RFdYfwkf3YAlvH4ei
         OdeTI3HMrln1kQaDBccoijALUemNy2iE5XecdW/IhrZjR8P3U7eQx0Ltmtcof8+q2j7M
         UOMSu8WS0V/lzx1hEfJw46sa7+9BMoMEl8Iiz8f/MQpOFMnd+kcJgjbmsSyWIG6d/tb1
         mkel3GSGfjq3H/KpWKCDMEJz+wG2VSZ/War3okHy0KCEj3EFkdnoaFzPLErOLixvDS88
         V813wbj8Z0PJtGltmTu2hf+UBUJj/9mmeQnPsuEn6zf+oLcO30Km6p1obE39koXziQNW
         Ej8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775806113; x=1776410913;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KGRPycyP0bYCi0FYmQRd0IwF9nhHr5uM+DqBSnm5Sws=;
        b=g4Hw4A9F/+umXUr5He0HvkYuT+WrLpCw/t9820BFv/89nUgKA7GaXKvF0pD3W/r6Tm
         tXQRZi+0AynRZHsKjHCPSCoFe1V60W2Z/rQoByASEC52aNzKc2C+VyLlv5yqQkWckaw/
         nJ0zd9oTotgu2WsOMPCcFhzGCevBx9HYYpsGaFbVfjPlwubVlQrs4+H2fHOP7tZAixz5
         dZU+08mH+j7TR1GdETaDY+BmA9nfooppkQL48aGFWu2hjwWUIdJ6OaKh2lJVxYLWvbNp
         ENLyrhcIOYX8dd8LRw6UNAewWLGlf81DjQsPC7rCylQa7X9+MiYHe244So0v1Z6kjIoD
         UyXw==
X-Forwarded-Encrypted: i=1; AJvYcCX1jCDHvdixVRz7qVODI7eEYeHB+g2xAy1zP++/bmJJtoqLOhvqJBR+R6KmfcLcFvNWMbD7WSzQg/g1h4xmiA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz90V353nPgQD/z09pCXkIPa5I/uYlEe/sZWUVuerLrOCA4tBwA
	iFsjkEeBS4+6U3VsgkdC8H193Gq3yY7d71dVB//5W9uSlVo5x2E9mI5a
X-Gm-Gg: AeBDiet5WjJqSxbSwd1PqIXSUaGxE7L9Re9qCnU2l1pwB2iUZ/mrHVhm2JREsWeZ+W/
	idwntD6JY/kbItpRgqsfcmxC2tPekF1rAOYzQ9KuiI7MHf83Ai1lPD5JtFxX8JJSuWICFjznHI8
	kbJ6W9vN4g+1DFJCSv6DxSzNj5PaRZNgsOnl/lhKXz28FCEl/IjYPAqNXUHp0J7tQMW4h3KmH94
	V2H++rwddixLEpbkOE5Ngid1coq+NcaLVd3YnXxVvm0bI6mVikvswoCRtDgvQLTm3WOdtw8XDXW
	1NBG8+/VS2r8LG/j1K24TF4SV/Y+UyFOV6hIB4Oqmyvc+HbGOhguu9mec8ChfK+P5uBISOHSjgz
	tyUzmX/YGi2FewaKjEHVRCvQwVur4/lttkHyICa6jMO1WMMil4l+Kj8zFN2WXRInrJYJYDWNNxG
	eSWIjrJMTX8lYY2XCpJiqmdSBvcqdwgN9Gxk5Fla23cGu4
X-Received: by 2002:a05:6a20:1588:b0:39b:989e:6d34 with SMTP id adf61e73a8af0-39fe3c1c2d6mr2534138637.4.1775806113302;
        Fri, 10 Apr 2026 00:28:33 -0700 (PDT)
Received: from tech-Alienware-m15-R6.. ([122.171.16.65])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c79216fd6edsm1796906a12.3.2026.04.10.00.28.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 00:28:32 -0700 (PDT)
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
Date: Fri, 10 Apr 2026 12:58:11 +0530
Message-ID: <20260410072825.19114-1-nueralspacetech@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <132f7e64-4fc6-4274-a04e-e53f0b957665@roeck-us.net>
References: <132f7e64-4fc6-4274-a04e-e53f0b957665@roeck-us.net>
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


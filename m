Received: from mail.avm.de (mail.avm.de [212.42.244.94])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C1E32860B;
	Tue,  5 May 2026 09:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.42.244.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777973208; cv=none; b=T7Y/Fh85rvKNnk8eDCu5jNUIU1RDZWQlNko2Lh9Ra/U3j2RwQK3K8n6OB5tqvsSRsaZW9f56FzPFTbX4pCASlZF+f8+2FxQXcQaHHpSpPVJ/n98qcuSLh1Ky4AYwqvBFpQGp9e782N0mRGbsbiIPWPh8UK45uqRcPDzFjVnRbbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777973208; c=relaxed/simple;
	bh=ttX60hNNc0JOKvmlZKq7C+/hMW4CwXG+bLrbojIUd7U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RDGJV6nOuyoGpC2Cb6XwFqaoGe0cPd0C1ufesQtFjuFPVdDuoJFYOTnC3tlvCTNT2XsKxj98JCL691ADfkP91pl2E6oCPZgvVLYg67u8Nnk4SuDbpDRr+cQHneBg1ac1cwTV9F8KLkhfoW++pkV19sXDzpyB2smhqiBszfWoEx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de; spf=pass smtp.mailfrom=avm.de; dkim=pass (1024-bit key) header.d=avm.de header.i=@avm.de header.b=nfkFDEUf; arc=none smtp.client-ip=212.42.244.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=avm.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=avm.de header.i=@avm.de header.b="nfkFDEUf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
	t=1777973200; bh=ttX60hNNc0JOKvmlZKq7C+/hMW4CwXG+bLrbojIUd7U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nfkFDEUf+sWhJ5ZgsSteKzTmgnV03e9zBLaj2NEjMQeFPzwOMooZsjiSVhENU6WJ1
	 TBBnu7Aj/h5B04CoveSKE38NgrF0fLWBst+TLlZLMREp9g1ans/7Zy2O0UGS+0cIzh
	 +5kx+3DpHrIr18wdUeV5OugFj8Fex7eMqQJ/Pneg=
Received: from [2001:bf0:244:244::71] (helo=mail.avm.de)
	by mail.avm.de with ESMTP (eXpurgate 4.56.1)
	(envelope-from <p.hahn@avm.de>)
	id 69f9b7d0-23fc-7f0000032729-7f000001b352-1
	for <multiple-recipients>; Tue, 05 May 2026 11:26:40 +0200
Received: from mail-auth.avm.de (dovecot-mx-01.avm.de [IPv6:2001:bf0:244:244::71])
	by mail.avm.de (Postfix) with ESMTPS;
	Tue,  5 May 2026 11:26:40 +0200 (CEST)
From: Philipp Hahn <p.hahn@avm.de>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>
Cc: Philipp Hahn <phahn-oss@avm.de>,
	linux-watchdog@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/5] watchdog: Move `struct` before name
Date: Tue,  5 May 2026 11:26:13 +0200
Message-ID: <e66ec58f3b8252b3676cc9fe68818af95123210c.1777972790.git.phahn-oss@avm.de>
In-Reply-To: <cover.1777972790.git.phahn-oss@avm.de>
References: <cover.1777972790.git.phahn-oss@avm.de>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: FRITZ! Technology GmbH, Berlin, Germany
Content-Transfer-Encoding: 8bit
X-purgate-ID: 149429::1777973200-A947AEEC-CE429B98/0/0
X-purgate-type: clean
X-purgate-size: 5888
X-purgate: This mail is considered clean (visit https://www.eleven.de for further information)
X-purgate: clean

From: Philipp Hahn <phahn-oss@avm.de>

Write `struct ` before the structure name as Sphinx otherwise uses the
following word after it. See
https://docs.kernel.org/watchdog/watchdog-api.html#environmental-monitoring

Signed-off-by: Philipp Hahn <phahn-oss@avm.de>
---
 .../convert_drivers_to_kernel_api.rst         | 24 +++++++++----------
 Documentation/watchdog/watchdog-api.rst       |  2 +-
 .../watchdog/watchdog-kernel-api.rst          |  2 +-
 3 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/Documentation/watchdog/convert_drivers_to_kernel_api.rst b/Documentation/watchdog/convert_drivers_to_kernel_api.rst
index 9eddb962f8e4c..004fe6ef76e94 100644
--- a/Documentation/watchdog/convert_drivers_to_kernel_api.rst
+++ b/Documentation/watchdog/convert_drivers_to_kernel_api.rst
@@ -11,12 +11,12 @@ This document shall guide you for this task. The necessary steps are described
 as well as things to look out for.
 
 
-Remove the file_operations struct
+Remove the struct file_operations
 ---------------------------------
 
 Old drivers define their own file_operations for actions like open(), write(),
 etc... These are now handled by the framework and just call the driver when
-needed. So, in general, the 'file_operations' struct and assorted functions can
+needed. So, in general, the struct file_operations and assorted functions can
 go. Only very few driver-specific details have to be moved to other functions.
 Here is a overview of the functions and probably needed actions:
 
@@ -36,7 +36,7 @@ Here is a overview of the functions and probably needed actions:
   from the driver:
 
 	WDIOC_GETSUPPORT:
-		Returns the mandatory watchdog_info struct from the driver
+		Returns the mandatory struct watchdog_info from the driver
 
 	WDIOC_GETSTATUS:
 		Needs the status-callback defined, otherwise returns 0
@@ -88,8 +88,8 @@ refactoring. The rest can go.
 Remove the miscdevice
 ---------------------
 
-Since the file_operations are gone now, you can also remove the 'struct
-miscdevice'. The framework will create it on watchdog_dev_register() called by
+Since the file_operations are gone now, you can also remove the struct
+miscdevice. The framework will create it on watchdog_dev_register() called by
 watchdog_register_device()::
 
   -static struct miscdevice s3c2410wdt_miscdev = {
@@ -113,10 +113,10 @@ them. Includes can be removed, too. For example::
 Add the watchdog operations
 ---------------------------
 
-All possible callbacks are defined in 'struct watchdog_ops'. You can find it
+All possible callbacks are defined in struct watchdog_ops. You can find it
 explained in watchdog-kernel-api.rst in this directory. start() and
 owner must be set, the rest are optional. You will easily find corresponding
-functions in the old driver. Note that you will now get a pointer to the
+functions in the old driver. Note that you will now get a pointer to the struct
 watchdog_device as a parameter to these functions, so you probably have to
 change the function header. Other changes are most likely not needed, because
 here simply happens the direct hardware access. If you have device-specific
@@ -151,12 +151,12 @@ A typical function-header change looks like::
 Add the watchdog device
 -----------------------
 
-Now we need to create a 'struct watchdog_device' and populate it with the
-necessary information for the framework. The struct is also explained in detail
+Now we need to create a struct watchdog_device and populate it with the
+necessary information for the framework. The structure is also explained in detail
 in watchdog-kernel-api.rst in this directory. We pass it the mandatory
-watchdog_info struct and the newly created watchdog_ops. Often, old drivers
+struct watchdog_info and the newly created struct watchdog_ops. Often, old drivers
 have their own record-keeping for things like bootstatus and timeout using
-static variables. Those have to be converted to use the members in
+static variables. Those have to be converted to use the members in struct
 watchdog_device. Note that the timeout values are unsigned int. Some drivers
 use signed int, so this has to be converted, too.
 
@@ -174,7 +174,7 @@ Handle the 'nowayout' feature
 A few drivers use nowayout statically, i.e. there is no module parameter for it
 and only CONFIG_WATCHDOG_NOWAYOUT determines if the feature is going to be
 used. This needs to be converted by initializing the status variable of the
-watchdog_device like this::
+struct watchdog_device like this::
 
         .status = WATCHDOG_NOWAYOUT_INIT_STATUS,
 
diff --git a/Documentation/watchdog/watchdog-api.rst b/Documentation/watchdog/watchdog-api.rst
index 78e228c272cf8..2c138eaa43397 100644
--- a/Documentation/watchdog/watchdog-api.rst
+++ b/Documentation/watchdog/watchdog-api.rst
@@ -158,7 +158,7 @@ available to ask what the device can do::
 	struct watchdog_info ident;
 	ioctl(fd, WDIOC_GETSUPPORT, &ident);
 
-the fields returned in the ident struct are:
+the fields returned in the struct watchdog_info are:
 
 	================	=============================================
         identity		a string identifying the watchdog driver
diff --git a/Documentation/watchdog/watchdog-kernel-api.rst b/Documentation/watchdog/watchdog-kernel-api.rst
index 5649c54cf6fbe..e2c1386c95509 100644
--- a/Documentation/watchdog/watchdog-kernel-api.rst
+++ b/Documentation/watchdog/watchdog-kernel-api.rst
@@ -257,7 +257,7 @@ bit-operations. The status bits that are defined are:
   To set the WDOG_NO_WAY_OUT status bit (before registering your watchdog
   timer device) you can either:
 
-  * set it statically in your watchdog_device struct with
+  * set it statically in your struct watchdog_device with
 
 	.status = WATCHDOG_NOWAYOUT_INIT_STATUS,
 
-- 
2.43.0


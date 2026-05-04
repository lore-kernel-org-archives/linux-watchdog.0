Received: from mail.avm.de (mail.avm.de [212.42.244.94])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B023DA7EE;
	Mon,  4 May 2026 13:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.42.244.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777902754; cv=none; b=F0Pe75JZgA7d09wu5PUtlzwHvSUhxTPuJVVHewR4RTyCTfS6Es1FH7so+aTspj1wdFN21U7KAxofi0HBXwBajP98lZLSaYak437tlILF3lwrKTEZGbQzCEfG16zBgDFwEFvFnN0rhtsgJV+YchBc1f/EjxDreLS7FniM+Y8U/5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777902754; c=relaxed/simple;
	bh=R/q6aYtyjcn/R9tkiLEtiY8Wq2ifImCddQQVrHnTSgw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gyo4cnZYIWeyR36e/iqaFuo66AZ3be3t/Rr4hLszlpWxReugFM7yW0a2K0nO7ZeFJ4SzqHHNmHcn7hzUItnrxaVwkm1QUhEgmhrXWADiUdibwbhoFISgQNy9lyrXsaS+mTD3cyWr3okDiwOdUS+oR++qVpP6wv8mlRNdyczQU/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de; spf=pass smtp.mailfrom=avm.de; dkim=pass (1024-bit key) header.d=avm.de header.i=@avm.de header.b=Wmuk4gPD; arc=none smtp.client-ip=212.42.244.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=avm.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=avm.de header.i=@avm.de header.b="Wmuk4gPD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
	t=1777902749; bh=R/q6aYtyjcn/R9tkiLEtiY8Wq2ifImCddQQVrHnTSgw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Wmuk4gPDgp94JILpidCIi9Og3uXXh6fsFCg13oSYu17ldqfM7nFb3Wi/eS+YYoKuz
	 eBgdao/gbfTioqwj6lWguGxFxP0673tBWn+H+mzDBcWGVOUeB3aPAxGZ2lORZuykeK
	 8Q6tDW3Z1wvdnfr+qreMEDOITomnw/jxoM5D7VNE=
Received: from [212.42.244.71] (helo=mail.avm.de)
	by mail.avm.de with ESMTP (eXpurgate 4.56.1)
	(envelope-from <p.hahn@avm.de>)
	id 69f8a49d-23fc-7f0000032729-7f000001a2f0-1
	for <multiple-recipients>; Mon, 04 May 2026 15:52:29 +0200
Received: from mail-auth.avm.de (dovecot-mx-01.avm.de [212.42.244.71])
	by mail.avm.de (Postfix) with ESMTPS;
	Mon,  4 May 2026 15:52:29 +0200 (CEST)
From: Philipp Hahn <p.hahn@avm.de>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>
Cc: Philipp Hahn <phahn-oss@avm.de>,
	linux-watchdog@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/5] watchdog: Change suffix .txt to .rst in references
Date: Mon,  4 May 2026 15:49:59 +0200
Message-ID: <bb1aa3129d5e52bc4c8e1ec3340b88f80f726fef.1777902230.git.phahn-oss@avm.de>
In-Reply-To: <cover.1777902230.git.phahn-oss@avm.de>
References: <cover.1777902230.git.phahn-oss@avm.de>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: FRITZ! Technology GmbH, Berlin, Germany
Content-Transfer-Encoding: 8bit
X-purgate-ID: 149429::1777902749-B0404EEC-CB73EDC4/0/0
X-purgate-type: clean
X-purgate-size: 1767
X-purgate: This mail is considered clean (visit https://www.eleven.de for further information)
X-purgate: clean

From: Philipp Hahn <phahn-oss@avm.de>

Fix link to documentation, which has already been converted to reST.
Also remove apostrophes which are no longer needed.

Signed-off-by: Philipp Hahn <phahn-oss@avm.de>
---
 Documentation/watchdog/convert_drivers_to_kernel_api.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/watchdog/convert_drivers_to_kernel_api.rst b/Documentation/watchdog/convert_drivers_to_kernel_api.rst
index e83609a5d0071..9eddb962f8e4c 100644
--- a/Documentation/watchdog/convert_drivers_to_kernel_api.rst
+++ b/Documentation/watchdog/convert_drivers_to_kernel_api.rst
@@ -114,7 +114,7 @@ Add the watchdog operations
 ---------------------------
 
 All possible callbacks are defined in 'struct watchdog_ops'. You can find it
-explained in 'watchdog-kernel-api.txt' in this directory. start() and
+explained in watchdog-kernel-api.rst in this directory. start() and
 owner must be set, the rest are optional. You will easily find corresponding
 functions in the old driver. Note that you will now get a pointer to the
 watchdog_device as a parameter to these functions, so you probably have to
@@ -153,7 +153,7 @@ Add the watchdog device
 
 Now we need to create a 'struct watchdog_device' and populate it with the
 necessary information for the framework. The struct is also explained in detail
-in 'watchdog-kernel-api.txt' in this directory. We pass it the mandatory
+in watchdog-kernel-api.rst in this directory. We pass it the mandatory
 watchdog_info struct and the newly created watchdog_ops. Often, old drivers
 have their own record-keeping for things like bootstatus and timeout using
 static variables. Those have to be converted to use the members in
-- 
2.43.0


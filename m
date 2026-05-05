Received: from mail.avm.de (mail.avm.de [212.42.244.120])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5165819B5B1;
	Tue,  5 May 2026 09:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.42.244.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777973208; cv=none; b=SvsNUbSWVvOoonRMRU+YpkpsHegOg9rD3mh3DQ5K90XW8m+24/OnfQ4hRLS0QPro4FDFdlVC3qpRMG6FnBHqn5Cq4F1UYUQ8NMonEF8PFxSQTm9nm4ZGuL7lZUZtwNUpVJcwusQcRc4EybdDMWgP8lk8gNW7v2sn8qC3eFV3ipo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777973208; c=relaxed/simple;
	bh=R/q6aYtyjcn/R9tkiLEtiY8Wq2ifImCddQQVrHnTSgw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OmgMJTA/6+kZ5ZGViUUKGgtC1HnbUVrjPfwZ0d7qUcEnCQ7+UGY/P2C0Uu7xO/jFzp4TfRys/SPSoE1JiA7rquTq54hfPm01KrUZoVQCmgdmsZOA4mbqUhj6orP4thOFxGmRRQUEiPh3g6pAsEp2s12IJxvEoZmX/YfDG0ZDDTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de; spf=pass smtp.mailfrom=avm.de; arc=none smtp.client-ip=212.42.244.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=avm.de
Received: from [212.42.244.71] (helo=mail.avm.de)
	by mail.avm.de with ESMTP (eXpurgate 4.56.1)
	(envelope-from <p.hahn@avm.de>)
	id 69f9b7cf-839b-7f0000032729-7f000001e384-1
	for <multiple-recipients>; Tue, 05 May 2026 11:26:39 +0200
Received: from mail-auth.avm.de (dovecot-mx-01.avm.de [212.42.244.71])
	by mail.avm.de (Postfix) with ESMTPS;
	Tue,  5 May 2026 11:26:39 +0200 (CEST)
From: Philipp Hahn <p.hahn@avm.de>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>
Cc: Philipp Hahn <phahn-oss@avm.de>,
	linux-watchdog@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/5] watchdog: Change suffix .txt to .rst in references
Date: Tue,  5 May 2026 11:26:12 +0200
Message-ID: <bb1aa3129d5e52bc4c8e1ec3340b88f80f726fef.1777972790.git.phahn-oss@avm.de>
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
X-purgate-ID: 149429::1777973199-D4707EA9-7356F148/0/0
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


Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9BA547A0D4
	for <linux-watchdog@vger.kernel.org>; Tue, 16 Jun 2026 17:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781630247; cv=none; b=dRvjWGbqb+gk4x2o+GhTPPY/Sj4LaYNFKub5DGV1BZ2i4ODcbNn3qRX9QFiBXH8m23GI6IRec+lt33NjpQFnxZkO4qFry68hEIx7w5665gS7B2SJmGAhnuFNwURFqAB8a2J1l+zuQ/1UypppZfzr1jQ8h4Do1eGIUJaR74TG7Fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781630247; c=relaxed/simple;
	bh=cKEjTH5FepfckGls7NfuPMq4B+e1REnNf7woc4KIzL8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CdcksbxeyXz97wC35YEpjBRSZiTn8X05TufwLnCm9WsUdtHVgOlACjSvM8P7eUieteoXpVPR/Vl44IssjzWfs5g2KzX/UIkq5us7v1E3IZPcxmsWtxyFlh6/cYKkvq+k7YXPU+WXx8/lI/GX7og10jTQrUUq5Lv3rGpGazycIPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c95NyAtR; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c95NyAtR"
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-9638c832c48so1690597241.1
        for <linux-watchdog@vger.kernel.org>; Tue, 16 Jun 2026 10:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781630243; x=1782235043; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ACjYfZcNSd5x2yaB7hlSXDD3CpAKDRqX3yYNuCKhZ9M=;
        b=c95NyAtRGvgIZ53JmVNjCouaSFby1MmsTPvTnHtombOctmFwo+KkMdS+bXsxVF2CRS
         HiCkVUg+LVQiVsa8OZQyRfe5Xlp+T96CBnGudzd5C3nBpo0Fwlhgo3EAuuPpunAlYYmJ
         eJyAKcRtdFP5oeUZpUIgLo+Cm986prw3aOzlCfo32xQyBV8v5xLBftF7DvWlYA40ERUJ
         +PVDYNwUUNE2n18z3MKyxAVMHBeTev+dJ+Pg0wSMLQ7+QKyzsq+1w4OsAq6uJy5RpxJQ
         2XDHNpD4G8fsqGOPXvrKBaAuOjDCHs7YmQDqNqlLAEcVYv6hc4KvPktS7SjhR9+OpsBJ
         4iCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781630243; x=1782235043;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ACjYfZcNSd5x2yaB7hlSXDD3CpAKDRqX3yYNuCKhZ9M=;
        b=HZqZ+0dtxVb87CLNzpz6hdrLhKtoMtSmgcQ/oKri2Qjc24Hq+b9o28Z/vrAPxNItt/
         exFbFk+nUjtqG6cXnJbx7b/v1tnofIjn4+k5SSgos6/8d9a3DWMoA0zqyOAX+7n06EWF
         nLn422Oa91SOSLqT3dHRgOy0aFJ9cmA3mvQlRVHNeLoN7kUQFUk+AgFPUnbBYJVXFAb7
         lTMCLi1C8ICmOFPtSeUxXCHOGcANWkECDYAxY+3FMgZ6hJUxE+O+wmyfspt0c8234ByW
         ic3faij2TKF0DufxwAREu/8jXgUugB5M02iy6BqzD1ZXBxYffF6PktfYNif4vOj82C0r
         xKJg==
X-Gm-Message-State: AOJu0YyVJzk3HWJ95hWD7ahXB3kmAwPJ1d3xBTw3G6SKdsALZzIazUmO
	noPCpkoKpydm0YX6hhkGnnNvad/E37mNT96X9MyD9Tq9u+U9GsikVQ4iuuMthg==
X-Gm-Gg: Acq92OEfZFJW6tFvJ02PxSEJ+UP+a9qj+epqeDAOtxKmdpze+BUi/sTGoqA7WOiIOtM
	7C8d1dM53CB0GcbHiIqmr0P0CkOLi+/CBlDwawwJ1oQRmC3siQX9oFWTvrb+o050RZMScyJfgKE
	e5o9zT6Gh0AoJN30BFlFvL5EmT9lnypz+ZcrE1PF/blDWE7p14hO3rExx0RoThy7WWoiVo3wQfk
	LYS6u0TnWCRHx+rrnIw4Hb0SdfNmuFic4Ig3HBEEhA6GRsjlJSe0gq55uQlwVWv97iR5JtFOxlS
	BFc8bOWHgt/DLdYukdHm+Uglabscl5Jrn4UkONVtXk7mJPfaMIDotY3nytxEFdHZcKWZ55qWfKT
	xIAozYaJSeUgfq8yGuBYdq2ReflqckpvI8siqwxxFnk4t8AI18DdPQSdSaFJeGEIdJjyB/MfXSZ
	fyuCj4fBE+gcDQR5B/zmIzo+y9FtkhIpcgQfuyIUHILBEDs8E5PBEO6UMFW6dYhIVENE92KbOqC
	p9eh5M=
X-Received: by 2002:a05:6102:955:b0:6ef:db57:ed3f with SMTP id ada2fe7eead31-7246d73e4dbmr176977137.29.1781630243277;
        Tue, 16 Jun 2026 10:17:23 -0700 (PDT)
Received: from Lorenzo.localdomain (179.177.183.8.dynamic.adsl.gvt.net.br. [179.177.183.8])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-966ceca5f6fsm1069135241.1.2026.06.16.10.17.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 10:17:23 -0700 (PDT)
From: Lorenzo Egidio <lorenzoegidioms@gmail.com>
To: linux-watchdog@vger.kernel.org,
	linux@roeck-us.net,
	wim@linux-watchdog.org
Cc: linux-kernel@vger.kernel.org,
	Lorenzo Egidio <lorenzoegidioms@gmail.com>
Subject: [PATCH] Watchdog: fix pretimeout noop governor logging and description
Date: Tue, 16 Jun 2026 14:19:54 -0300
Message-ID: <20260616171955.658-1-lorenzoegidioms@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Overview
This review is dedicated to a pretimeout governor implementation of Linux kernel watchdog ("noop"). The overall module organization and the registration mechanism are done rightly and in accordance with the kernel standards. But, two points were noticed that could result in either compilation errors or difficulties in maintainability.
1. Potential problem: pr_alert usage with the wdd->id
Within the callback function:
static void pretimeout_noop(struct watchdog_device *wdd) { pr_alert("watchdog%d: pretimeout event\n", wdd->id); }
Problem
The id field of the struct watchdog_device is not ensured to be present in all Linux kernel versions. Actually, in many recent kernel versions, this field is either missing or not exposed in the public structure API.
Consequence
Compilation may fail with the following error at compile time:error: 'struct watchdog_device' has no member named 'id'
Portability of the code to different kernel versions is lessened as it depends on the details of the internal structure.

Suggestions
Do not directly access wdd->id. It is better to use a general message or a stable field which is safe across versions if available.
An example of a safe alternative:
pr_alert("watchdog: pretimeout event\n");
2. Mismatch in MODULE_DESCRIPTION
The present module declares:
MODULE_DESCRIPTION("Panic watchdog pretimeout governor");
Problem
There is a difference between the module description and the very name of the governor:
.name = "noop"
The code clearly states a "noop" governor, but the description talks about a "panic" governor, thereby causing misunderstanding.
Result
Developers and maintainers get confused
The module metadata is not correctly described
There is a decrease in clarity in logs and documentation

Suggestion
Correct the module description to be in line with the actual operation of the implementation.
Example:
MODULE_DESCRIPTION("Noop watchdog pretimeout governor");
Conclusion
The implementation is good structurally and it fits well with the Linux kernel watchdog governor framework. On the other hand, the usage of wdd->id could result in the incompatibility problem with the different kernel versions and the module metadata carries a description inconsistency that has to be fixed for the better clarity and maintainability.

Signed-off-by: Lorenzo Egidio <lorenzoegidioms@gmail.com>
---
 drivers/watchdog/pretimeout_noop.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/pretimeout_noop.c b/drivers/watchdog/pretimeout_noop.c
index 74ec02b9f..ddb5192fb 100644
--- a/drivers/watchdog/pretimeout_noop.c
+++ b/drivers/watchdog/pretimeout_noop.c
@@ -17,7 +17,7 @@
  */
 static void pretimeout_noop(struct watchdog_device *wdd)
 {
-	pr_alert("watchdog%d: pretimeout event\n", wdd->id);
+	pr_alert("watchdog%d: pretimeout event\n");
 }
 
 static struct watchdog_governor watchdog_gov_noop = {
@@ -38,5 +38,5 @@ module_init(watchdog_gov_noop_register);
 module_exit(watchdog_gov_noop_unregister);
 
 MODULE_AUTHOR("Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>");
-MODULE_DESCRIPTION("Panic watchdog pretimeout governor");
+MODULE_DESCRIPTION("Noop watchdog pretimeout governor");
 MODULE_LICENSE("GPL");
-- 
2.51.0


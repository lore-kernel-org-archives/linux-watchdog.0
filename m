Received: from mail-dl1-f67.google.com (mail-dl1-f67.google.com [74.125.82.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2B52D838E
	for <linux-watchdog@vger.kernel.org>; Tue,  5 May 2026 02:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777949058; cv=none; b=fpJD+YJcbJOc1Gqf4ShClIwDHmBbu/DPPMoaGKMJOc5gtV4pO5/UJ2w/cXpyA2xAeRdEnIz/cOc0aoYCdy12y8gAcopAR8MWOErlh82/HVUaqr1KuNV4VdSqs571HnnyXJM0cQPa7v0tpFdFmOEGyXrxQVfG+7uvFBGwM+iqaAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777949058; c=relaxed/simple;
	bh=+ijqfV2M+nUWmrZ01hUk8qlmqmFkkygkO48bqXlWhKY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lgvhV7Dmq8w2ZP/ckxVgfEMebA3QI2y29xymeLcPckexyw7nIDz2fOd0WbtJpQeOc9o9EXgZF1M24CEHTXhvbq/X2Acf6CfuVSLtKHRxS1AZIQ/vV+Yv5byqk9E6Cfas/HKUtMWxyGOxUjouPFfQWPaIO3+io8y5g5mqovJfKYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bOt6secU; arc=none smtp.client-ip=74.125.82.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bOt6secU"
Received: by mail-dl1-f67.google.com with SMTP id a92af1059eb24-12dfbcc0703so4890216c88.1
        for <linux-watchdog@vger.kernel.org>; Mon, 04 May 2026 19:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777949056; x=1778553856; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2Mtg/2Y1Yctt44dTC7tgSUAiz3kq2xes5Jal3lx1c8I=;
        b=bOt6secUqjKrg6zJdgj5syGnSQWbI9FRkwUR6VO2jnTMYxGMTgCUmoyE4stkDArtbE
         eyX/T0Xcbk31SSPKvjzYHavrv7+EM+UnbQH3NCUl+hD5LGOJ2hyqOjd/Pi8Tiz/7dS+M
         ZB4J2tXV1AtAqszPanNuERFqhkSX6NQJ/8HXDpph33ZVV2B6vAPX5T4oipvgr8/aKb+2
         /5I9D2UrJFhdGzzYU64ofUJtFPL6s8ixkI9PAlHFVRrNBpjNAFAGXGaUggbfTQgKazAp
         Cr6Dh108KZcfawtVwmbS+CxdVWxQKFKMA3+WfYrJjO56N0MRWghLRssxYRZCW6rq3Fah
         fheg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777949056; x=1778553856;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Mtg/2Y1Yctt44dTC7tgSUAiz3kq2xes5Jal3lx1c8I=;
        b=puPv4QPXDFK3R0sIGQ2VOnevyALlBynpURlvIYJUEMiVfwDoC/QnyeCIbYxS51XrCM
         T9eNemslixhQNQCKVpCag7WU1N7jgUoeZV3jbmjpoVTwhmXN7gurJnn/bT6YHkOMWp1g
         8OJSUFQ92ltnwvCGgK5CVwlDtSF/B1SNDaOFk1MKyVyhWFCbg6EUhXZXijmdxbNVzHCs
         kVwMyYWdMY+YDo+SZ7T3RNsAzXdzMs2XdrLFVImEKMyrTvoaTYwRRugGuVJWZ2PD035j
         xD+wjZGAllN8/dV6CEaJXcjLzODkjAUJESHj9jPLPWypTVO8Y+slRu2bc9qOVrYmcd4H
         mWSg==
X-Gm-Message-State: AOJu0YwWGpbVQ17BLMiq33RxzuWZA1Qd7C+h7rLvodtuJZnUd6KhtwOD
	MI2opV+XZadjU2UDPYrEFISk606aM2bK4iMGMwNgpKa0mboE5RcA3Pw64rKhkJOE
X-Gm-Gg: AeBDiesksfb3fZ9g633osbqiVoZjil56JTAHim5wRNUpBH4FhCK4qNBsvc9WESLL8/u
	oGWqKVbXmB7CShZpL3S9L4E5XeOf+/ok7Lh884HuFTz/ZYFlglaoQJfIveWkjItImD33LyPPyOP
	I+3AqV3tyZ7hIkAVUom/IVQtf6G3A418coRSX3QTzdRto+eNGSzwPZbWpzepvKIobWN2xfpEVv4
	U77euDrSxDww9z4sOPU2tGeN9oAF1eSLd1I1ax27/ZLI1F7kPAM8pj5AhbKdlNFeBlRV1/O7J3f
	ULlXWruGIB0vF2gQQo27jYXGA9QBVGrgjvxEoLTb7v+TLO6S/PkrgddJ0AkQCAC2pihGurEIrzz
	ewR740J7HCRF0kqwbz98whK02HX7INS3feWBToT843ZrM+M7ACshN5P9fTnlGrf1XIxjhFaNwTi
	eK5t9Kvamf1hSjweqNoErikJ9bwInQDoAthbEKKZvdSkweZlPYJC4vc+/CFvJlM0KmYgRnjgPoS
	0mqK6CXkZ2jV54FuyH5u93tLw518sS4EVHzG5n30nppG6cx93t7N9OXHgIRahOtD17s+2vE1+qZ
	p6YNCGQ+FiGhMk7oG4Hiyn++kty8
X-Received: by 2002:a05:7022:43a3:b0:12d:b7e5:a691 with SMTP id a92af1059eb24-12dfd7a0e78mr5809301c88.7.1777949055822;
        Mon, 04 May 2026 19:44:15 -0700 (PDT)
Received: from ethan-latitude5420.. (host-127-24.cafrjco.fresno.ca.us.clients.pavlovmedia.net. [68.180.127.24])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12df82a141asm21094589c88.8.2026.05.04.19.44.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 19:44:15 -0700 (PDT)
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
To: linux-watchdog@vger.kernel.org
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	stable@vger.kernel.org,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Daniel Lezcano <daniel.lezcano@kernel.org>
Subject: [PATCH] watchdog: s32g_wdt: remove incorrect options in watchdog_info struct
Date: Mon,  4 May 2026 19:44:09 -0700
Message-ID: <20260505024409.60301-1-enelsonmoore@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The s32g_wdt driver uses two incorrect constants in the options field
of its watchdog_info struct. This bit mask should contain WDIOF_*
constants, but the driver uses two WDIOC_* ioctl constants (in addition
to correct WDIOF_* constants). This causes many incorrect bits to be
set in the bit mask. The functionality indicated by these ioctl
constants is supported by all drivers using the watchdog framework, so
this patch simply removes them.

Fixes: bd3f54ec559b ("watchdog: Add the Watchdog Timer for the NXP S32 platform")
Cc: stable@vger.kernel.org # 6.18+
Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
---
 drivers/watchdog/s32g_wdt.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/watchdog/s32g_wdt.c b/drivers/watchdog/s32g_wdt.c
index ad55063060af..6422a694fc65 100644
--- a/drivers/watchdog/s32g_wdt.c
+++ b/drivers/watchdog/s32g_wdt.c
@@ -56,8 +56,7 @@ MODULE_PARM_DESC(early_enable,
 
 static const struct watchdog_info s32g_wdt_info = {
 	.identity = "s32g watchdog",
-	.options = WDIOF_KEEPALIVEPING | WDIOF_SETTIMEOUT | WDIOF_MAGICCLOSE |
-	WDIOC_GETTIMEOUT | WDIOC_GETTIMELEFT,
+	.options = WDIOF_KEEPALIVEPING | WDIOF_SETTIMEOUT | WDIOF_MAGICCLOSE,
 };
 
 static struct s32g_wdt_device *wdd_to_s32g_wdt(struct watchdog_device *wdd)
-- 
2.43.0


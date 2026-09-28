Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9930466B09
	for <linux-watchdog@vger.kernel.org>; Mon, 28 Sep 2026 10:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790593190; cv=none; b=SlZ/tDtT/FWEXPt0B5dpRrTSVoj6UftFLNPF9tnfq08+Gpltvx4bR8DleFggOS/vd61g4T1G5/LsnlH6uj86QMsAa4b5CEyjx3Yarr7VM9ewmZ91huc2/gNHdyfjPYVigQ0BnUImiBU869RJR+Z0TFlaawtfn9DNOFCJbYOgr5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790593190; c=relaxed/simple;
	bh=hIbE1WkiEyYr2rgywtMnsnYfOGO9WVejcPv35XwQqV0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Mnuv6C24D5EcAo6uAp6B7shk7ZEp4LMyvuewbflGsuW+KJLGayq0gfHza5ILC6rgE8FP4QE8K+DPSZg5w0zQM3SBEpYHxs4xUKyo5sh1yfrXbUArnSflY94PSjM6oYhVt8Wv6+M/2vlCY90bEOkX9ZIyQx4mJ46puYBy7U9VFwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lHzjMdxm; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lHzjMdxm"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-396cccbba91so1293489a91.1
        for <linux-watchdog@vger.kernel.org>; Mon, 28 Sep 2026 03:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790593188; x=1791197988; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Jt8WLvuVpcaKdOY0WmZ2Johj0kI46QjfNZqar/F/0wA=;
        b=lHzjMdxmYUQpUbyl6b/p6kZ/o2CHeWhd70KWfRgC+dLVoWVe74Z0jw+KfzGhiDy23X
         2qYbc6pYrgn9janX79WtK3uFvpiF3jqDe3W/LRTYiOS5jQC7zShLnwAOnqYKo7kNXXhU
         bpCR8J+ZavyoyrcKsM1YEd1t2n/Cm5KmlRQ78NewkL6+lMNoDvrVuqvl3rhopRg6IS2j
         2lDoKagXlWAmjEIWREbFnYwVTBbDrppbVw/4PvSgHupp+oE4k3PBUQMwTMYIpQOwECg1
         84cInnImhJvYzZJ9Prw4cm5HG83VJRPzkjdlsgW5iUXmeRNV57CnF/fMfXoNJnUzTSay
         uHZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790593188; x=1791197988;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Jt8WLvuVpcaKdOY0WmZ2Johj0kI46QjfNZqar/F/0wA=;
        b=JSe0EZ8teNeT/k+cLxV/5jKUcEoCMf6mLHAo5AC8gKpSCyxVDnTewFY2jVs6e0XQc8
         /T5vxX4b216kg2CHhkCLJp/eE7YstCXX21rPjKk14T042tYfx1Gzyv8yLhlIF6VBtCwQ
         W59+LYsQGy1csJQqb1u08CpqobN4XPgriC1DZGCQ6UObQPHhX5tbkOZU7zF99vVAr7aR
         kqWU1kcW5ws5pD22iLj6QyqCevbW6MJVWWCXRns34HouFNh3vbRjKl66NXtVVToWWqnt
         hLn5qdJUbDJXr/a8nfhUL6pm5NYOOOr/O1UJ5v3um2xZVOem+xZiNYo3fZ8y4+kqCeCy
         uMhQ==
X-Forwarded-Encrypted: i=1; AKwUvByQsVVe3q6eTEF8o5Di4PIUYxLYYsErgYwEvZtCV7RG2EbUhNisTwaCrF+1TUI+edCxXENTRglY8QRgT3Kbvg==@vger.kernel.org
X-Gm-Message-State: AFq9FYKbneFfd3+vndcc0X7Aw8rn7Ade+nybsJdxC3JTQPv5bckz70yM
	LtbBrHHc2EES+4vHe6k43BebLsbTl7xaTfBiOVG97ZwRl58BdkvoE9fe
X-Gm-Gg: AYBFou0KB47HY/VWAW3+zFQy1WGPzGmg1aBdI07mw3dHNWrVEn5V2lKq7ktghV0UluR
	SiaMJoPpnf0OL7+rtJ9l/4+x279PXQMt3TGTE6b6x2I9fvSyil8eC0c27M5U30YMlwBR/PI/WAV
	ZgNBivSXEhzD0wmKb2eEChlz5anxboWZqugzxxIehua6JcXS3yQpd6ETdQ1D59GBiG/HPQ1J47z
	KebcZonRyZHtXIBB5EVp4X13Af8HumnzhiFl5bSOrsoqpTn0A9wavukgIeDe4IbKMkdiAUwhT5i
	udpNPQ7LPCuZQVx3kvNcTMU3iy54Qq2HAv+vDP92Yi/88K/KWL6lV7wCjku3jHVboRQwsDLj+6r
	k1jq1SflsGkmFw4rgVCj1If8asbXDk7diAFJdDkWNgwXdvX1DHVrJRLjlr7PBqVKl8ezNZ/hDSu
	I1IsoKV1GFPuXkSQdytwE3DYmawLFRHpGEyK03aY0O8I77bq0dFjgattK7+MTM6aaE7MBpiX1b/
	kmQQk+kvhSKHnjLEqBgG98jiyi6qapMAJkqwZgnXlYnwMkyYnqsQ4bwc6or958UeM2ODftp1qhr
	p5MdVCyeiix0jgCekVvv7BaYb7fXRAXjWZkxhPZVHA2btSf9B4xxp3FYf7lZ
X-Received: by 2002:a17:90b:4b0a:b0:39e:21a7:5df5 with SMTP id 98e67ed59e1d1-3a0985eb6c7mr10896774a91.24.1790593187942;
        Mon, 28 Sep 2026 03:59:47 -0700 (PDT)
Received: from spider.bream-herring.ts.net ([103.6.151.236])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0cd1c4ec9sm15924338a91.16.2026.09.28.03.59.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 03:59:47 -0700 (PDT)
From: Matthias Goergens <matthias.goergens@gmail.com>
To: Guenter Roeck <linux@roeck-us.net>,
	Wim Van Sebroeck <wim@linux-watchdog.org>
Cc: linux-hwmon@vger.kernel.org,
	linux-watchdog@vger.kernel.org
Subject: [PATCH] MAINTAINERS: name the hwmon-next and watchdog-next branches
Date: Mon, 28 Sep 2026 18:59:44 +0800
Message-ID: <20260928105944.2186541-1-matthias.goergens@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The T: entries for HARDWARE MONITORING and WATCHDOG DEVICE DRIVERS name
groeck/linux-staging without a branch.  The repository's HEAD points to
branch master, which mainline already contains.  linux-next merges two
branches of this repository (Next/Trees): hwmon-next for HARDWARE
MONITORING and watchdog-next for WATCHDOG DEVICE DRIVERS.  Name each in
its entry.

Signed-off-by: Matthias Goergens <matthias.goergens@gmail.com>
---
This is part of a cleanup of all T: entries whose repository HEAD is
not where development happens: one patch per repository, sent in small
batches.  The plan is at [1], and why it goes out in batches at [2].

[1] https://lore.kernel.org/all/20260924033200.3615554-1-matthias.goergens@gmail.com/
[2] https://lore.kernel.org/all/20260924101844.2403008-1-matthias.goergens@gmail.com/

 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 140eafcbbd78..6dd05753c41b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11483,7 +11483,7 @@ M:	Guenter Roeck <linux@roeck-us.net>
 L:	linux-hwmon@vger.kernel.org
 S:	Maintained
 W:	http://hwmon.wiki.kernel.org/
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-next
 F:	Documentation/ABI/testing/sysfs-class-hwmon
 F:	Documentation/devicetree/bindings/hwmon/
 F:	Documentation/hwmon/
@@ -29359,7 +29359,7 @@ M:	Guenter Roeck <linux@roeck-us.net>
 L:	linux-watchdog@vger.kernel.org
 S:	Maintained
 W:	http://www.linux-watchdog.org/
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git watchdog-next
 F:	Documentation/devicetree/bindings/watchdog/
 F:	Documentation/watchdog/
 F:	drivers/watchdog/

base-commit: 62f4c998b297cf233997a2b4cd6fc2d2df0319c9
-- 
2.55.0


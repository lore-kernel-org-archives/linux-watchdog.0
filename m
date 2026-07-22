Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133A93E8695
	for <linux-watchdog@vger.kernel.org>; Wed, 22 Jul 2026 16:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784739465; cv=none; b=mSItLSYej2hmYpt9QOv60LNS+xUeQrZfhZp251a6tRGVSOwZU0H3SZWCjKF7yG2zUJdG4DKIeOTrvOvIqJU0COlJzU8HkC6rci4Hw5w2FLT5nbGucOsvC45bwVWjYqif8bDzwbIIfZhe+6pfE/rSzxwXOzBmiAMbYHwDT24VkEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784739465; c=relaxed/simple;
	bh=ukqzFap0i1Ty18ZDSMXKokqXVqef2g/RXxiCDDt1Z/c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d3kFtdweQFkPdGK5UR0wzdMN9ZLB/gSIzczJD8T5hJIPCU1A/h8iLDNhxbUsSEArHmnmy2PeFmt7Z/sWcDf01sjYUrq4IBDsxNsEoWRgDocLzlWA53vroRPOuwCLf+vcBzK4LX0fMFxfopsK+CinjzdKtkLsxsqvonhwW8HwOaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mclDEpaT; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mclDEpaT"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2caced6038eso86372775ad.0
        for <linux-watchdog@vger.kernel.org>; Wed, 22 Jul 2026 09:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784739462; x=1785344262; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FgfxsTeX5y5t6agkqQJSdyDPpE41GXMwVFRresZVrFo=;
        b=mclDEpaTftg1cJi/T5z9wWjV9j1FIrtoaFtMrA3YalyXyOk8EwysOppNqkj2RbmMCa
         hLAuBfXhjf8Fr+5FYsu3zza+Cu47HkKdceKmYGsFnDmDxozYO8/V4naEvji0cO2GOUam
         d6QcYXDUWDf3Qs3JzmglwOPQo9Lqqrpqyt3zr9NlMK2iG2CDfnmRVHN9aemNmXy+65Q7
         6E9RZYv50KxBQo5YxKsCgcduL/gMlBFDenrTmxwptZW1IOKRBzBWzElErlUhs1Bbqh6O
         woYhGsRBcQZzd1ptJSi4IV7Vlt5cPerwzSjppqdDajxIMquMmmb0AaegKscpnparTwXj
         qTwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784739462; x=1785344262;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FgfxsTeX5y5t6agkqQJSdyDPpE41GXMwVFRresZVrFo=;
        b=ibhBuwZkXx49yXW70IrauB3/h1+orO+kDuIBsoqFSkkdIEpdP3GbtGJt/V3IfkVHkt
         BnCXGpYqqPd+TAHEIH9Kx0L7O0CPd1PcfZvEsN8+101Qu2g/9V2bvmVw3C1l9KGzinWE
         wayMf4gJ9hb88u2dNMNJXFubZxc200EqfHQ6PQ7BhOIH6ZHjLAifDk9dmNfQ+yBI1xwX
         Zl8yLyydjpN9Q5uj+sv0tq/9iOoJA9tGaAuJY3b/57ADcjWdkrurROUO6qBWkjAUQSyX
         hZty1WUHm2M4FBes3bUHo+Gf4RShGiGGHQCNql9Pb+Yl1zJd/aCl4nMYmxOAlF02tphq
         bdrQ==
X-Gm-Message-State: AOJu0YxMN1Ztk5WEJ1eIvzY5pyNgmle/x6aEy+AbCinKqe/cpOWYYVZf
	8pdp3G83x2SPP4VFd1/cd1MTlxPR8oQzm7pEsRa7hG0q5wtl+0tOof6cgy5W9g==
X-Gm-Gg: AR+sD12JIYCxtm7qSS83yKxsDM+XVAGZlZAXNALedHbabK5ofQ8I79Pv6JWoyi0KzxB
	GBFx06Y1CLbI3/XbqQeSsISHZm2GJPEkOEYQAEELWZnMiZXnfCWisv/OqYspP0zqI+PBj8iqz6u
	X4W6aNTEuGFUoazx/fzxyiLjRDKx9XHeEFDtMU3XxLVqtiJ81vcXJQgCB16yBanoi50DyuRwhCI
	3UG/RDlAbQ8A/gXLHXXwvhAyd/S6YuIrC0aqlWVGpfWnedh9JzxtFfj26yU4iMluBphDj9YW8qE
	p3v8pm6GI1YgNiu1oWXdkHjphbsAZofwMGrAZGXDrHP7O3lt1waD1cVzk8n7webTHExjSFPpUCK
	vTzk/S28rc02WaplPYYmL5rbbJnlbwI6+lDUmYSYAh9jGrpbFG9fo9y8obnyBFaSDOvyPiPc45X
	WfuZ7PPIdcIYexURo=
X-Received: by 2002:a17:903:2c08:b0:2bc:e299:4b3f with SMTP id d9443c01a7336-2cf8dcd914emr46113935ad.10.1784739462291;
        Wed, 22 Jul 2026 09:57:42 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf8f31319asm18545415ad.60.2026.07.22.09.57.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 09:57:41 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] watchdog fixes for v7.2-rc5
Date: Wed, 22 Jul 2026 09:57:40 -0700
Message-ID: <20260722165740.2307124-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Please pull watchdog fixes for Linux v7.2-rc5 from signed tag:

    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git watchdog-for-v7.2-rc5

Thanks,
Guenter
------

The following changes since commit dc59e4fea9d83f03bad6bddf3fa2e52491777482:

  Linux 7.2-rc1 (2026-06-28 12:01:31 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git tags/watchdog-for-v7.2-rc5

for you to fetch changes up to bcfcd7619f277842430d197556463b401b839ee9:

  watchdog: airoha: Prevent division by zero when clock frequency is zero (2026-07-08 07:08:50 -0700)

----------------------------------------------------------------
watchdog fixes for v7.2-rc5

Notable fixes:

- airoha: Prevent division by zero when clock frequency is zero

- core: pretimeout: Fix UAF in watchdog_unregister_governor()

- ni903x_wdt: Check ACPI_COMPANION() against NULL

- s32g_wdt: remove incorrect options in watchdog_info struct

----------------------------------------------------------------
Ethan Nelson-Moore (1):
      watchdog: s32g_wdt: remove incorrect options in watchdog_info struct

Manuel Ebner (1):
      docs: watchdog: Fix brackets

Rafael J. Wysocki (1):
      watchdog: ni903x_wdt: Check ACPI_COMPANION() against NULL

Tzung-Bi Shih (1):
      watchdog: pretimeout: Fix UAF in watchdog_unregister_governor()

Wayen Yan (1):
      watchdog: airoha: Prevent division by zero when clock frequency is zero

 Documentation/watchdog/watchdog-parameters.rst | 4 ++--
 drivers/watchdog/airoha_wdt.c                  | 3 +++
 drivers/watchdog/ni903x_wdt.c                  | 7 ++++++-
 drivers/watchdog/s32g_wdt.c                    | 3 +--
 drivers/watchdog/watchdog_pretimeout.c         | 2 ++
 5 files changed, 14 insertions(+), 5 deletions(-)

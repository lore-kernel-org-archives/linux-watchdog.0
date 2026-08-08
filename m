Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28DAD23EA8B
	for <linux-watchdog@vger.kernel.org>; Sat,  8 Aug 2026 00:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786148118; cv=none; b=nBy9lMwsYzUo7nLVOpbha81fd4CEZDQgPbLFb6ZAtZqgABynHF+IF60vgPU/YJtgVbKBUKlSQPVSNiWt8qOUidRV4zRDfoo/+LBzHsFosMz6yg6zHcJIsGhRJd7LaqVA7babhqONMNBR9CCCjFPr9WM3s/nUNUtt87ApdL8yVNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786148118; c=relaxed/simple;
	bh=3zlUphwH6acfRYe8ZMJVU3CIiHdtOMTV81yvpUfyz4I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SNB6D7F8NnfL3liWg0cNQjzmIHV802SyTJaZLlTDbrV2JegNpVIpf95hMxs12r6NXqo8n7jKtoNcV16zYKO+bZdVIm41SQRI+alF/3TDgeVfRYJc61Ql+F9Gb0f/tlbfyINVLN6HKfCwSN4MtOjR44BqK3mZN+nADayJT0HtQEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fMdkyiSt; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fMdkyiSt"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-38e347638adso106258a91.0
        for <linux-watchdog@vger.kernel.org>; Fri, 07 Aug 2026 17:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786148116; x=1786752916; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AhD792iStzhLZKTQ5qLXe16VBDj8Bn7auApI4KkEbnI=;
        b=fMdkyiStnDhugMy5OsWUclKwT532qj4ddyF6/qRlkUj5gpTAb84FqSjbYoPdDcCKX4
         DGCHdtcc0biHYXpxYtklGbkUOXV/49XJddMqCXFno8tuNAiqS9ayUEKr2cvZGezcBIcA
         H4VF12+BTwPjy3CCCVt7PNqOc4mpUPubHW7kDPOcILx3Bvk1BOcZ9XwjQ7Qg6b0XNUGa
         jta0KroApR3UnBTmsgodURqcyShQexe3WjKipe/VnMWsJ0EsKflfH90rtJuHByyuJuZs
         JRLaQAVIAHU+KrIyXLMLNu0YpB5BqEsZnudHt4S5sSXjMFeOODuynRpcCQ7Aieb05waG
         gDLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786148116; x=1786752916;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AhD792iStzhLZKTQ5qLXe16VBDj8Bn7auApI4KkEbnI=;
        b=pPqGyTBIGKxHa7QcGsLOvEtqfEO3S6RQ0uFHdhdeJfMTEx1UPng+gRjcuz+WJidzOz
         wym4weCB/UMo1ysFq1mZnHmpS6j5YO2NBzxmgX79abpzr/SXB0/yhFtq2xD8eq/T9v0G
         vWXfUU5wDq72Y3pgwkcDLaWCOSxidDsjqx3A6KQ5ga3mXvAWN+LPEnCuTWhrzmKU9oZU
         nKhkV6FQL4uwBEuLESomAYfX8fvE1BUYf2AGhTYUerd0vbFRxlaGZmWodtc9zRv3MqxS
         dRucQdJvTWZZ6UcjGUuF7hDOOJAf8CGP9PcmcUeIy/c3SuoUSTQu2OV1fpQFUM2HWxjo
         sTlA==
X-Gm-Message-State: AOJu0Yx2Wc/wClDa2FMQwGgTvbHm3hHgyVrpw+MLLfOBuG7EHFHLhnkM
	5ssiVB8z+HKzLZVCQfOFqp60L3IgxGuZdmjPyxBe2W0kuiNcLbtLg+sS
X-Gm-Gg: AR+sD13FHqzvQ9FWRZ70i27ZTXZK6Bb5GXpXZMisjso72Z7eqRXIWsPG9LhRucDI320
	zD3qssXUkvdo/MsTjrr3NJEYHpeHjdFCeSPNXzZRJZ35p4IwkPWdFY4uv1eD566lj5gjP9tL8ys
	VEQJYtRSTUgzGZzAQfPGTar2j5sFcJrBinriVJi+WwksgcUu52AnZ7ZChSCfUqlP6x3rfPFuc60
	zJEhMK+pZdR1K9kxx6gSuqp6HVN+htOC1qoI7xfF+kN2iLE13mvBLlIWFWg8w0NINltokh6WgjV
	inmSUpq3tzqvJApM+XLXcK61rlA4nrALdrSkmqnMgduG3SgU0JG4YKxNSziNALJVHYOCBAZLJke
	KR6BvyMZAV8Er8XFKv8eYH3iGfiwQnkD2zcvn4LFi00kK6rwNW1RrDdU6CEBJSHA+QuuMTL8CGG
	tpPbJaHmxAQmuHs6oMidYo0oqItZNEXUnvxfr8ez6bBLrJdiLnNCh8t02ABw8L00xQrsGGfCUe/
	Q==
X-Received: by 2002:a17:90b:2748:b0:380:7688:fbe9 with SMTP id 98e67ed59e1d1-392823a4a2bmr3805579a91.8.1786148116485;
        Fri, 07 Aug 2026 17:15:16 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39085f2b2easm6495736a91.11.2026.08.07.17.15.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 17:15:15 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] watchdog fixes for v7.2-rc7
Date: Fri,  7 Aug 2026 17:15:14 -0700
Message-ID: <20260808001514.2405698-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Please pull watchdog fixes for Linux v7.2-rc7 from signed tag:

    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git watchdog-for-v7.2-rc7

Thanks,
Guenter
------

The following changes since commit f5098b6bae761e346ebcd9da7f95622c04733cff:

  Linux 7.2-rc5 (2026-07-26 14:45:48 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git tags/watchdog-for-v7.2-rc7

for you to fetch changes up to 8444d66aa6b6e7fe0a26fa1a00a11cb4d0523783:

  watchdog: at91sam9_wdt: prevent timer rearm during teardown (2026-08-06 14:23:55 -0700)

----------------------------------------------------------------
watchdog fixes for v7.2-rc7

* at91sam9_wdt: prevent timer rearm during teardown

* bd96801_wdt: Fix timeout for enabled WDG

* atcwdt200: Fix return value when watchdog is enabled

----------------------------------------------------------------
Hongyan Xu (1):
      watchdog: at91sam9_wdt: prevent timer rearm during teardown

Matti Vaittinen (1):
      watchdog: bd96801_wdt: Fix timeout for enabled WDG

Surendra Singh Chouhan (1):
      watchdog: atcwdt200: fix return value when watchdog is enabled

 drivers/watchdog/at91sam9_wdt.c  | 4 ++--
 drivers/watchdog/atcwdt200_wdt.c | 7 ++++---
 drivers/watchdog/bd96801_wdt.c   | 5 ++---
 3 files changed, 8 insertions(+), 8 deletions(-)

Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B33E256C6C
	for <linux-watchdog@vger.kernel.org>; Sun, 10 May 2026 19:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778440748; cv=none; b=GXsp39EjE2hIce4rAQpldC6iPgj962QFPvrBpbylbKexuzxwAgwRIWoHm+Q1p+60/poVBoPMIz9KXC2xCCNvt3aiKjSrOrbOUNSlTOQLzKW8clT9vo4uFEVMWT8ODmIaLfV5s1XvvzmtBACSamXN6eN7AuVBNqbJlq20aDbzwdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778440748; c=relaxed/simple;
	bh=3agGI2WGaOiYr5q4GByDIn4KbJ8CZMnBx7VEdVfZqrI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ys5aidfgANvNnRapxpnWddT/fWmpVCWA5SnRSakKK8TynkyuddePDASuSIPM4ndKOMMhKA4GoTcXAOR6ayphhJjLXME4a66XKLOYtk5xiIvgY6qjpi99x9TmZiJrVPmPYMpwW6RV3I4xwPukR1C/847pTIhCjXaQHVvNTHzHC7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MiS6muzY; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MiS6muzY"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c80227c9572so1539288a12.2
        for <linux-watchdog@vger.kernel.org>; Sun, 10 May 2026 12:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778440745; x=1779045545; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QwwobxH4k9ePXnEoEZzRJmu0wB3sHAjdo5EH1/to2wQ=;
        b=MiS6muzYQp4aYz8Ha6Ycrf60btmcDmPYw5m5t9BoF75j32P1JyDmoBhP7UNrpo0wFo
         IEVQ7bNizrYibnKS/FdHju14SrDeCzPuSGLgdXmEsq7gnTdBAYJJ3ZGDukiVTcHnhv/D
         SUNSQ2JRfGiWM9WJlg8CZf8NIe/nTZyVbkP4tPZXq7EfICG7PKbSQ2p4LKpIcr4T9jB3
         1lRXTq4Qy5V0nGERYhQCpGn0lfM07gU35Sba4IIISsRHRmp6Exftb971p6jFeASng3iZ
         DwW9nl3LefpOtCeOOmI/OA/4nWv7+0ms+zIAXtN0kEppfodkFwmmfP0GFo7Sx8TFLYH6
         ff4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778440745; x=1779045545;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QwwobxH4k9ePXnEoEZzRJmu0wB3sHAjdo5EH1/to2wQ=;
        b=YtDjHHB+mrR2UjD8Rtb0imIDQJtj8Fqqfo/qlJT4je7z7dc4uhE3aSwSNxw0s1IE5a
         zRCGKbE/Psnckvih59OfiOI/m2azwCJ9Va7gN8YfWrkByj4SEnnMDLExLL2RfLSh7KLt
         yJfOFKKsA/EHoQqw53igqW3mCECDTbF6tnk6ZMnIK93gWvtsqIKG83bAMf8eBSYzCPSR
         bOJhAGrXZROKaMeeGNDhpqdWoqT8VmP8DQK2xLVJQvU3KkfLXpivA8qNgN9PknbgHhOA
         EAyxIwy55SF6MnPn+gJWozitpCTynrgsbEXJ0ncTK1hEmcjJwFOS3WLjFOo8K5nBt3bD
         FXPA==
X-Gm-Message-State: AOJu0Ywh6ukp8HJCGVs5s8yVIBNgGsSs/I/PcnjBcxiXoOJMwBWYrEVS
	A8eq/KOAtsk0O/4q1pIwiALJF7FXXg4nOna4WTNAA5WESCvbWmwzJP0NjwwuKscQftNKTg==
X-Gm-Gg: Acq92OHgutLy/tKXjIElmn+5JKjgxGH2Wr2Gy5RiVzRCMaj2o8cGBWvkvrmQuTUIlyJ
	N7AFkzcFID/f5tRdiGWE50POPCB2SaL7gyyZRljF0u6ZAIaFZjqgw62H3+6ZkmyoatrIJa6yNCv
	5Nh+nfWRTQYMl2hCwxMxb5BhsFp3Ke9MtFejXZ8D3TqehdPYQZ9t25qZpFBpT7ZXngXAkRr5F68
	4Zl74i75ydWZU0XoxDgLzWs00zNUkA9OmA7xiW+VGnedsRBouJ6ky8/kkDO9+3sfwSH4X+frhOY
	3F0R5g7o1VkksN/NWZAH0hrIAZHQlsaTSyY9fR5BMd1CGF/BarnyfHc3A77us19K/DOS21M/CpM
	vhdMbRfH++0M6aWiBYVX8EXDN0QAQrzhlS54P5v/wrNkT64eRAD/DraFmrfs6cTcxwecvcjv8+v
	NKYyN064CRang7cE2BODymQBuhapl1jQ3wQKSDmFXCSLzYh4M=
X-Received: by 2002:a05:6a00:ad09:b0:82d:62ed:b01d with SMTP id d2e1a72fcca58-83a5e344711mr21942826b3a.45.1778440745378;
        Sun, 10 May 2026 12:19:05 -0700 (PDT)
Received: from Strong10mede.domain.name ([122.161.50.8])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83967dbcf16sm20866026b3a.40.2026.05.10.12.19.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2026 12:19:04 -0700 (PDT)
From: Mayur Kumar <kmayur809@gmail.com>
To: wim@linux-watchdog.org,
	linux@roeck-us.net
Cc: linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mayur Kumar <kmayur809@gmail.com>
Subject: [PATCH] watchdog: sb_wdog: add missing SPDX license identifier
Date: Mon, 11 May 2026 00:48:47 +0530
Message-Id: <20260510191847.50499-1-kmayur809@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

checkpatch.pl reports the following warning:

WARNING: Missing or malformed SPDX-License-Identifier tag in line 1

Per Documentation/process/license-rules.rst, add the appropriate SPDX
license identifier to the first line of the C source file using the
'//' style comment. Default to GPL-2.0-only.

Signed-off-by: Mayur Kumar <kmayur809@gmail.com>
---
 drivers/watchdog/sb_wdog.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/watchdog/sb_wdog.c b/drivers/watchdog/sb_wdog.c
index eaa68b54cf5..03db71a43d6 100644
--- a/drivers/watchdog/sb_wdog.c
+++ b/drivers/watchdog/sb_wdog.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * Watchdog driver for SiByte SB1 SoCs
  *
-- 
2.34.1


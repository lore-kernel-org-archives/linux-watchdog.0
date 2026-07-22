Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0AD440A3A
	for <linux-watchdog@vger.kernel.org>; Wed, 22 Jul 2026 16:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784738243; cv=none; b=tSq0nXdninFhriYR5fDuaHy835KWENsMCciKJ7+hqLtVqMphsMnhBfMUU5W70ailSP/t3JHgBZaDTwEX6EHWxGtEW6M5TJxyt6+3pimTQpCOK72//Peh2JDwIdzLbRM/Mkd3CbH15L+gFdKKLhaGqbzwD9gRCsZa65VGIiC2rN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784738243; c=relaxed/simple;
	bh=O7YZSJohC2QjyBimpbFrdvngQLx/Jj/DTZkXWXd5Fnc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q9UjamUWaC0M18ludfEJX0rF6GdOMLW9gD5tfmx1tvK4j9sD9RdNYbOayzHHVkZ5PODlqg+GCT78dEwXFsXVINYsenjawTj/VQQE+4fUrAhXOOJ9Jn4Q0MJ8jQOVEa+RFCUsof+t8t0xga77ThtRTodh6JTh+yWehiBszcm9vr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LjhM5dd5; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LjhM5dd5"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2caea3f742bso152821045ad.0
        for <linux-watchdog@vger.kernel.org>; Wed, 22 Jul 2026 09:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784738238; x=1785343038; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=VkUZF3GUgBycLRVSuNCfQrxXc8ty9gReEhTHtUNTyK0=;
        b=LjhM5dd5OmUMIIM8bCD5fA5shs7B/Eq0HTObq+8Vy9QmCuefUKFrphsku+sI+DEVR+
         bOTz44TvxVXKXbGP8IEWAHtP+qqAq+ubGtnI+PIvTk4cPKmSNk5R+ijzls5Yjltl4cVP
         x+f1/b/EPKHboi5oyviv8i4/RPnE19tW8vapPlWyS+mkWxC+fG0LMZJw3ZRwTlmZHBVC
         GNiwHYM3lQFNbtU066e8DA+I119MS9iSX8vwlkeiZRFsKwa03FBSrWyNL73pwfedRSIE
         r9udyGApAHXPRDR+Zb5y5Q2zzBwPM4zYI8e08RupZ5LSyBL/gjzy4HhCrE3U/ysHS8fA
         kRtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784738238; x=1785343038;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VkUZF3GUgBycLRVSuNCfQrxXc8ty9gReEhTHtUNTyK0=;
        b=PS4g1ytYHKN2GhJS3RdeI/hqPdssceWEwYyk8+Kv4qX0BBALnnQf33jbJLljXTr0lB
         3TK7quf6ygYnClBWw3bYb7iVvKuC8KhwtoSGgi7bDFJ33iwP4DjLSSFKwU+e7VA0DptP
         JLieT1O5Hif0acKVwcbOR61ieEeO4maIV9/AEDnjnr7WzNtbqCzfVUgTsBbVswbMqVXR
         f4N/T8ZfvSMNFyL0jVD09SB3CH2zi7CXO8RDpf4ge5TvazuPL3BbgOveEXoeYL4NRsN8
         y9VTcrD8AN018hCy6v2YEqzbQhjF1S0FZoxxlwCNgjbXgjJjRBRIkn6+hTztml/D8VHb
         EX4Q==
X-Gm-Message-State: AOJu0YyKWBk24oCuwRR/B6UjKlUEzlag+YQ8tCp4J3Mv4i/g4pelkvtT
	UPWKOqpgfiU2YOeYD8EBZi+S30fvOtxZQG1RRCunBYnRNguNBwerV7M=
X-Gm-Gg: AR+sD13tzjfVP/0ryhEvr2QfHXX1JZSbCSACp2iijeB09+uZdKQoYIyM3klzprmt7C+
	fELkl5PJ15Euo5SCCR6e/VloePPvWUQHBrscZywgpfGDcQbjpW2o+8F6h9n3vzd7RgBxvWlLgLS
	WrpZGZSpw0AxXQOf8M1o8SSjyl7Ff2mnJOpkcYMTDTCSffHY7b0/6FKkvFI1VbBYmTrfi5bbl+l
	bWDN/lB5ePW6+1K5ViS5nyd3kZHtqbP3tkEDIjH4XYqWhiiVQLEGqXLdnDBcT1cAtbD+mGWFJgK
	LFnQ5RDQsJ2KeKDSRrn0ry3yiMd4wB+K8AkwrcRr+vIq3tggd+qfw/BklsnaEEZEL2OWiE9DNVZ
	ED1zqT3FisXWp3i6TWuITvbWEKVdjm1aFX3dK8nQKTUpkltrQkB32orVtEIFSOtSQz8E8gLx+ZZ
	L0d1vp/ajlL464gUawYVKj92DHIw==
X-Received: by 2002:a17:903:1210:b0:2c9:d298:6c06 with SMTP id d9443c01a7336-2cf34a0a6c0mr244194615ad.25.1784738237761;
        Wed, 22 Jul 2026 09:37:17 -0700 (PDT)
Received: from t-rex ([2401:4900:c212:546e:3d3e:f0d9:52c0:8a0])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3147dc8b0cdsm10801506eec.11.2026.07.22.09.37.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 09:37:17 -0700 (PDT)
From: kr494167@gmail.com
To: cl634@andestech.com,
	wim@linux-watchdog.org,
	linux@roeck-us.net
Cc: linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Surendra Singh Chouhan <kr494167@gmail.com>
Subject: [PATCH] watchdog: atcwdt200: fix return value when watchdog is enabled
Date: Wed, 22 Jul 2026 22:07:06 +0530
Message-ID: <20260722163706.14238-1-kr494167@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Surendra Singh Chouhan <kr494167@gmail.com>

atcwdt_get_int_timer_type() returned TMR_UNKNOWN (enum value 3) when
CTRL_WDT_EN was set in the control register.

Because atcwdt_probe() checks "ret = atcwdt_get_int_timer_type(drv_data);
if (ret) return ret;", returning TMR_UNKNOWN caused probe() to return 3
instead of a valid negative error code.

Fix this by setting drv_data->int_timer_type to TMR_UNKNOWN and returning
-EBUSY via dev_err_probe() when the watchdog is already enabled.

Fixes: e4e0848ad046 ("watchdog: atcwdt200: Add driver for Andes ATCWDT200")
Signed-off-by: Surendra Singh Chouhan <kr494167@gmail.com>
---
 drivers/watchdog/atcwdt200_wdt.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/watchdog/atcwdt200_wdt.c b/drivers/watchdog/atcwdt200_wdt.c
index 8e3b18aea368..b91c748b3603 100644
--- a/drivers/watchdog/atcwdt200_wdt.c
+++ b/drivers/watchdog/atcwdt200_wdt.c
@@ -274,7 +274,9 @@ static int atcwdt_get_int_timer_type(struct atcwdt_drv *drv_data)
 	regmap_read(drv_data->regmap, REG_CTRL, &val);
 	if (val & CTRL_WDT_EN) {
 		spin_unlock(&drv_data->lock);
-		return TMR_UNKNOWN;
+		drv_data->int_timer_type = TMR_UNKNOWN;
+		return dev_err_probe(dev, -EBUSY,
+				     "Watchdog is enabled, cannot detect timer type\n");
 	}
 
 	/*
-- 
2.55.0


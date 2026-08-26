Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEBB0382381
	for <linux-watchdog@vger.kernel.org>; Wed, 26 Aug 2026 06:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787724546; cv=none; b=imAVdZ2BR1AegXaobeZX5vP+ZvhpWY5SXoox5MxXU6ylxNKCznVcdTl+/NEJ1IC3y0YwZPL/mtOKrGaAneTVuiLcvhUr7TyiCKpLbonrAqTzpH9bqjxoqcbaMwzV40fVbJSq25tkkm3CKw82DzcLwfPg5wh9Bc/CSDdfyauF3Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787724546; c=relaxed/simple;
	bh=tWZ+ZGZ0QVzwaxgy5Wr42inmbKBJfSJfhhW9q0w0wYk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l/80020hkn4OCN2QtCbbKcvmM8FnKYaubHVrP7Si2jvYZxSpCobHUVGCfCP+A4dX+FW791P5NW6ZekEcEAIFJFyfIE9kkYLXnfpsyDgBg5b3gzCZTrRS4lRtYhDFUBLnF/vowzmI5cMm7NOBg1ytC2kmJe5fWOrYGmTU1mR9Qgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s16u9Gay; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s16u9Gay"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3900e39d935so889378a91.0
        for <linux-watchdog@vger.kernel.org>; Tue, 25 Aug 2026 23:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787724544; x=1788329344; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0PHxEoewrNEsAcP/BBaiuAY7I0YWhmUO4eoxhZ9mBWE=;
        b=s16u9GayNLIkee25ToeFRf5R6jSRfD2uRr4PwsdadfQiUq/uDoo4ugLGf/BvbMxQWe
         JN78xRrw6icLDpr/KRxwLPaH6mV//yPDGswrWhorTMZQ7rFHziIfTyQrrw8qElX4KOZ/
         C2HOmn9bA0PdiK9R/7prxnpVKN5Wyg/z0bquqxX/wJ2aFZykw5D8WF/OZS1qzgVIU51l
         yjDNRrYTopb2Z9sXTOcke2I9vGa8qLIf1P84+64FcibzbLUEwqOnzpa9XiB3RMccMnCY
         2/KtKQqu66BFWbvFLvp52X1d0ql99xO/V/sQoXfrWt32hoqNjCUqPJBFH5gmPT6SC1EW
         Dgog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787724544; x=1788329344;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0PHxEoewrNEsAcP/BBaiuAY7I0YWhmUO4eoxhZ9mBWE=;
        b=AX+2byLRy3iVZ1Yn3C8GRKm3MFRr2wmUP2KPeSf6Mxl7Hjw8EDdHtcD0eVCzNf9MH9
         mFMZe1DxlzhEVPTLQnRK8m7DrFlWHzmprLOkNii+eXDN2uyThunIeU8iq3SbN/nFX4nT
         3YXwWetPLVLFT33swIpgWY+DG6oabezs/Bh14v31Zqe7qtUaJhfsJoPMesS9WcEH1ye8
         2Tth4goeUBcCdGLOIzeJbfD7yY9ra3zFKykJChlheJbyBW5yFmCODL5KzfY9Sv7kK6iB
         CUdbI0sqww9N5EZkcorm098Jz2fNur9mA8dUQEJ5EHJSkWmhSJANLHOZerZvWwUW8wGh
         lXfg==
X-Forwarded-Encrypted: i=1; AHgh+RpkZKhrYJjOmgKfzk/vn59Qcfyk1RWCEh+G5uSaC1vnAMqPQwGzaGX2YkOsiZOLhWwh1JgzBe9K9dpX7Cv0MA==@vger.kernel.org
X-Gm-Message-State: AFuF++ndEWckQbf7VJeWx5IxFjhVpJkWUv8h+yBX+i1i+U3GilnAIZQi
	E+nllcdvsaX3mLD9Eu1jNl4HJgVs1efehmswy0QgiWVa1F6OeH/A8hM=
X-Gm-Gg: AR+sD13LOyYSRVh+Psdaqo0bVQISJckkhTqNrm+ImrNIOyYmF8DCujDo6U5iscwZ73J
	ZBjGBIVebpFPKqi+KoiqhWJwtyLNAWVkthL8UwDGg0knW1vfjMZ4AzSJM8a6Scw1MlHWUCj5LWe
	ntZrPYKkKuKOlRdG1W1dkwo5NemlNHdFJ29WfQ/DuwoxPQ3KQGYeQInMZZf6yRtl5UwEI1Ric2q
	12NNV/Y82GSeLiJfWswm59f78jHhYYxX28HOfXpr2V1Lq0ztxkji79UHbB2zUvswTjMcS1V9xag
	hDClSMfmjhJuHZaey0Qpb9TEHtU/xr6STRb5la1gL0Zemvs24rSy1PTol3rtVEQNF0g3THf8rDt
	3+2xc0YEJVp3rocvLQfcYJ9b8K5vmKU+UG9PgsqFIBhv2Wm0lFoN69GtvTLD2QM7Z7AYy5woDpV
	QLFAkpJ9MCr0zjPvS/55wPn0t/5fQ4Xh0ylzAALEqr+WId1SjsFTm9XzmRyEGszlt7BQWIlwYtp
	w==
X-Received: by 2002:a17:90b:2e4d:b0:396:4d8c:6c4 with SMTP id 98e67ed59e1d1-3966d88242emr9824090a91.14.1787724544133;
        Tue, 25 Aug 2026 23:09:04 -0700 (PDT)
Received: from DL2XHKPB4.dl.net ([103.63.104.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39668a57396sm2736799a91.13.2026.08.25.23.09.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 23:09:03 -0700 (PDT)
From: Triet Hoang <triet.hoang.dev@gmail.com>
To: wim@linux-watchdog.org
Cc: linux@roeck-us.net,
	linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Triet Hoang <triet.hoang.dev@gmail.com>
Subject: [PATCH 0/8] watchdog: Convert drivers to DEFINE_SIMPLE_DEV_PM_OPS()
Date: Wed, 26 Aug 2026 13:08:31 +0700
Message-ID: <20260826060839.203297-1-triet.hoang.dev@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series converts the watchdog drivers to use DEFINE_SIMPLE_DEV_PM_OPS()
and pm_sleep_ptr().

This is a straightforward cleanup with no functional change intended.

Signed-off-by: Triet Hoang <triet.hoang.dev@gmail.com>

Triet Hoang (8):
  watchdog: cadence_wdt: Convert to DEFINE_SIMPLE_DEV_PM_OPS()
  watchdog: da9062: Convert to DEFINE_SIMPLE_DEV_PM_OPS()
  watchdog: keembay_wdt: Convert to DEFINE_SIMPLE_DEV_PM_OPS()
  watchdog: msc313e_wdt: Convert to DEFINE_SIMPLE_DEV_PM_OPS()
  watchdog: of_xilinx_wdt: Convert to DEFINE_SIMPLE_DEV_PM_OPS()
  watchdog: pm8916_wdt: Convert to DEFINE_SIMPLE_DEV_PM_OPS()
  watchdog: sp805_wdt: Convert to DEFINE_SIMPLE_DEV_PM_OPS()
  watchdog: stmp3xxx_rtc_wdt: Convert to DEFINE_SIMPLE_DEV_PM_OPS()

 drivers/watchdog/cadence_wdt.c      | 8 ++++----
 drivers/watchdog/da9062_wdt.c       | 8 ++++----
 drivers/watchdog/keembay_wdt.c      | 8 ++++----
 drivers/watchdog/msc313e_wdt.c      | 8 ++++----
 drivers/watchdog/of_xilinx_wdt.c    | 8 ++++----
 drivers/watchdog/pm8916_wdt.c       | 8 ++++----
 drivers/watchdog/sp805_wdt.c        | 8 ++++----
 drivers/watchdog/stmp3xxx_rtc_wdt.c | 8 ++++----
 8 files changed, 32 insertions(+), 32 deletions(-)

-- 
2.53.0


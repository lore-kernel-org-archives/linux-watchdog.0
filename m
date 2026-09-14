Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EFB9411661
	for <linux-watchdog@vger.kernel.org>; Mon, 14 Sep 2026 08:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789376165; cv=none; b=Mui9grkml3fKdrfS1tsV85h5khqDnAJi/qusvC2gxY2hxBLvhGbrPnfcNWunAy2txD3WkIhWBGZFLL5d0IEIOZMF08ybIkLW0z8AgvnpygwKAEk8dBwg3I/M8MHuIYE1kr0iyvfRnssr4OTAprgC0KAfSQArgAZekQGygDmQyKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789376165; c=relaxed/simple;
	bh=2AYNHPYR8DvZ2JE4B5Z+TBHCYoIrFkkHKs6JSZq0e6s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jq4QTfpH0s+sZ9fDuqLUme1Gxfqcer8C39XB1y+ufR4vWyY7OaDAqUhnpqPsLRW6cHAfjiW2zt/4h2YdLxPEDs8WKEtaoSmtG7YW8um5wK6kMpxWwv90cBK38gXOHrMSYLI1jiAQ6abW5MgRKqSvkVu+S3GRXPs8TtDwx1nDKy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eODMheeK; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eODMheeK"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2d6e954afbdso22909905ad.2
        for <linux-watchdog@vger.kernel.org>; Mon, 14 Sep 2026 01:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789376156; x=1789980956; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lgNNFPbS45QrfrwS2UlBvdfwDy06m3LBDa/zfVAjFa8=;
        b=eODMheeKNUy2rphMojiQGxlLs8Uzx8QLR2MjUrClsavf25XC7T7FZDkQxHlAxsk5hU
         4R5UClfqxka3a+9M8MzSPi3iszZJUy4ik3fbDegyZNOwyAOAtPdxuf5P74kJExexN1Ma
         RWHMDBH5VyIwHLuVRQLYyAF96m1PiZ5hV/sfdUR/ONs/gK9+aTpiCPJ1dSfiUrxDdXsS
         EIMmUn/4a57AIXexvSH1hpweNRPvtq9dPkZHl5VXFM8cgBX4CVFpb0Xrr+gf8hGB56aR
         rwiFBsLS5yfM3MVpO4V09++NqZZeo17yvioYku152O8AxEdHKP5sR+X9hGaxAojInRv/
         uOHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789376156; x=1789980956;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lgNNFPbS45QrfrwS2UlBvdfwDy06m3LBDa/zfVAjFa8=;
        b=a34HTpWV1lZAZgHU6hVMVaPHq0RTxp/9jk4BxSTr/aeZ1D6T+KjmPktj691Qggw03e
         L5l1wnDCu3mLsfhkIaLpx4lh8otTWAxUhEyytKPQkdd4LNn3m7orH6t0FmecOyVHPYq+
         rZzYz3mPXB5URx4lSD7Yqmpb0EdnWjP3bgkeeDtqm+EMNt8mMbP5rReNxwKivJdnA4ew
         dbXCIYd4Hk+lTZkGAnqH/487daRyUef6/RWv1BOsbjiHJ5RUCWxA0vwvo7bBUtEGi0/Q
         ctzZ8g5XdeW9/5PsRd8AHccQkKS0v7iNmDM52V1oKDB01+8/CHeC6WVYvaAqI6OFqFF2
         vVgw==
X-Forwarded-Encrypted: i=1; AKwUvBxpr+x4hurx2WAW9qE7gGCMfK48RG2NhAhdLQx6Xn0m9bxuKId4VPD1r/LOXMqeamkwjOn81wPNmD+bjNr5qA==@vger.kernel.org
X-Gm-Message-State: AFuF++kCsWKCLiYO6jYPq/iFPc1FzV+Ut19GAODztROyHIklluiqvZR0
	Lf6JMN34Atzbr1labxfxf9X2uJvovxj8peqsKy4FjXsfnpljuBVpSnY=
X-Gm-Gg: AYBFou1GijcP6AYPXxD7AA2jtMW1Tr6Ow7+MrKvFt+ljQGV2nhCv2qbBGIxxZr3U4QS
	BncmgpyNTKv6gQN9u5EgiObVk34ggqbz3rNC230YDbw0TeGhkp7LmDgujGrXdbmzum57jY0tcaB
	TtgCsXPikJ0hJjz0/OdcOJHJwnVhvRN2XS5iIuqKSCgA0s1rcN74RY0erPBI145tTGWq2OyMSFR
	y3d4HwfFqmArxLj5GpxQV/JyeAkpBP66LHHtk3oX4CMViLIUf9SpeEaBeEA8H6XBPwBNtw1DKP5
	q6qgBH4M+nCkG2Yn5bR0xNDVmzpxajChlGd0uNcYpbiFbh3lXibfbrGgqDo/EVwEvf6OSbyFL1U
	TOphvOuIH4S6VtcPojcJTB3Za8eaqhw+OW2wvUPHcvTglpCjpHfZXj7DkJMkqjvIFdIe8VaLdMx
	IreAeGvZyMYfct2J+XfnjsOvAbh9c1bNHtsvsTZenTCZKSQu66WA52ubJFahfxnUWhonB04IIWE
	vDKm6lEF4eX
X-Received: by 2002:a17:902:e950:b0:2dd:3d1a:6958 with SMTP id d9443c01a7336-2dd6c5f4ef5mr37059965ad.6.1789376156080;
        Mon, 14 Sep 2026 01:55:56 -0700 (PDT)
Received: from DL2XHKPB4.dl.net ([103.63.104.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd2cfd8c84sm44569105ad.62.2026.09.14.01.55.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 01:55:55 -0700 (PDT)
From: Triet Hoang <triet.hoang.dev@gmail.com>
To: linux@roeck-us.net,
	tzungbi@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	triet.hoang.dev@gmail.com,
	wim@linux-watchdog.org
Subject: [PATCH v2 0/8] watchdog: Convert drivers to DEFINE_SIMPLE_DEV_PM_OPS()
Date: Mon, 14 Sep 2026 15:54:43 +0700
Message-ID: <20260914085451.891675-1-triet.hoang.dev@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series converts the watchdog drivers to use DEFINE_SIMPLE_DEV_PM_OPS()
and pm_ptr().

This is a straightforward cleanup with no functional change intended.

Signed-off-by: Triet Hoang <triet.hoang.dev@gmail.com>
---
Link to v1: https://lore.kernel.org/all/20260826060839.203297-1-triet.hoang.dev@gmail.com/

Changes in v2:
- Use pm_ptr() instead of pm_sleep_ptr()
- Align formatting of DEFINE_SIMPLE_DEV_PM_OPS() usage
---
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
 drivers/watchdog/da9062_wdt.c       | 9 ++++-----
 drivers/watchdog/keembay_wdt.c      | 9 ++++-----
 drivers/watchdog/msc313e_wdt.c      | 8 ++++----
 drivers/watchdog/of_xilinx_wdt.c    | 8 ++++----
 drivers/watchdog/pm8916_wdt.c       | 9 ++++-----
 drivers/watchdog/sp805_wdt.c        | 9 ++++-----
 drivers/watchdog/stmp3xxx_rtc_wdt.c | 9 ++++-----
 8 files changed, 32 insertions(+), 37 deletions(-)

-- 
2.53.0


Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB009416871
	for <linux-watchdog@vger.kernel.org>; Mon, 14 Sep 2026 08:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789376175; cv=none; b=fTw8eSIb67c6jm9uGvjcK05UWFQ7sjGEW+i04VQwWMYCPPTAuCM+Mo6baVZI0wyUxpyCAqNHKODaeTUk9S0h8K12uh6H7l/Jf1/U2becV6qIjEfZKqfosQaw+gNjpnlTkHcPgg72qpwBWXTbLUPOM0Vj2yJWEEkuH5RNP6sUcEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789376175; c=relaxed/simple;
	bh=buYFKyyOI6nkDO4XJeAK8t6bogKP2UdtNxsW2hJuAhk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pbmsu4cUihYz4L+aS67au8MPK9m6NS5S+ggD2TdvvMAWdXRExIfr1Jy42SoUsU1+muLWYRr9MEHXP1JjGyNExwXbu9BTH9Q1j/U4A+Cjt8cUuEB5Y1K1JS3YjKGqGzEzkWiYX4zGJ09ImWH+6nPwpW++UUmSZ7QeMJ4RPgIi2d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iBTCnQvN; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iBTCnQvN"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d747ee1f9bso18659885ad.3
        for <linux-watchdog@vger.kernel.org>; Mon, 14 Sep 2026 01:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789376167; x=1789980967; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WIQQRpZFhYMmIKFPbxaVocgdRA3zgYS4JXAKQ5jg9dQ=;
        b=iBTCnQvNUllMzmD9X3c2XuxcIvT69r3ezpV6V8/9ImHJThINhdvUb/Ci5RlyF0E3qG
         vM6VjGYP6KdjRessTFYUmPYwLWFSKuSECQbJZ04t7pIgDwdeNR9lOA1tWDTYtCAiMMQc
         /Z5sHAcVs7zwNCUVlaTrgElYKymdkFt50Uaad//0EK7R6FYX46MPUXwd9kNFON2/4nM3
         tSimxTaGHrbHYhE1g03urxMRAHBvXM3PjeoUZOfEer/15tGXtIlf5Tiq3yNAj6gL692i
         VzPY9+GSgW/74JoZBLLS4DJKf2op5+n3fllRQIPu2N9i4JzZe2WkCYfuGg8AmZhG/S4q
         bTqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789376167; x=1789980967;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WIQQRpZFhYMmIKFPbxaVocgdRA3zgYS4JXAKQ5jg9dQ=;
        b=RwsJhDqgf8fL2FYcNJ2fqbYQAeSZ0VIe6c/mAqxFf+qn0N4T5iJMlN2yhJVop22/hg
         82udmTySkpIFJZq6DcrmECcTW1XrfpaDkQZFT4XaMm1r+kis5J7ku+KWN3J43q+k1r6g
         5+lOvJV6OeKmZ8YZPqD9naXBQt8otAs0NblB5ogEDEXnRPM1Mw9hSXifZSfMDYlBnsN0
         MhhewTvXUBJBDkntgNfuLhcwAtYg+Kreb7nrbrDpluXV3tzAYZAsXVVKe3MVRcHMVQBg
         PHsNb1Yo14xUQPpnOWJy5ysUsn8vz8q0JjLVUdj7jOflWt1Icir3vIsUQijrZ9sMm+A4
         FBrQ==
X-Forwarded-Encrypted: i=1; AKwUvBzNgNKQ1+gsSW/UdN+iKRHeU2H5nAQ4zOh04zEoJIBvh2xTgrgI/U9BGkCg77izTpPiKmSlX/yKfkWQ53gFcg==@vger.kernel.org
X-Gm-Message-State: AFuF++mO2xDrcgzbgfPHeUFAEj2Zf9/ZuDcrg/F+qaKTfgwlI2vw29iy
	zPeUgzpn5g2qRBqgjgxc5yjz+z7YMS7pLGAC5euXdPjTnX6BS1TNEYU=
X-Gm-Gg: AYBFou03GuLLpoafMea5KkAy7U+1yT1wsGONKd1h+MP//NiHIbchwbQniE8DT8o3NS+
	3lqTkH7tEgSONW4DM8kgLq5pkPF36QruiquQZc/RsDZTRLcj07Gl3GWSVsIe+mVdz6l9JmJiJPJ
	y2IftYJlyQlx8o3xsYOT6KBWXkl16fi6nTgItMA1osc9mVjHGJ2Xn9G8QO7aacOn5IHfDWPvttg
	tRPR6gomYwr1+UEccNCblAy7k1bPG2KF5z3omMZVne8i4oe7CxJ+608u66fcYd3m/4DbxbLZnGK
	d6IVKu3yM5WjXbMwBmFa+anCwT1MCxL3snQOVhl341/y2YAD9DtYa2Fab9ZDHpTD7OR4vYxPQGf
	lIo5+Q2dEPczZ/PaHPGIjU8fZDtu30RMBbyqJG38JygxIOEUBbHdn/G2Pt0aS6moQagElk38WFQ
	ABnj1qLbfXb9i8NcJscOiEh92fe4XLSbbTMo3UD3sXctBrYFlJQU395ZwnSK4gKzsg/1NOEstW3
	bclji4FFyun
X-Received: by 2002:a17:902:cccc:b0:2dd:194:76ce with SMTP id d9443c01a7336-2dd6c5ef9aemr41764705ad.7.1789376167221;
        Mon, 14 Sep 2026 01:56:07 -0700 (PDT)
Received: from DL2XHKPB4.dl.net ([103.63.104.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd2cfd8c84sm44569105ad.62.2026.09.14.01.56.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 01:56:06 -0700 (PDT)
From: Triet Hoang <triet.hoang.dev@gmail.com>
To: linux@roeck-us.net,
	tzungbi@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	triet.hoang.dev@gmail.com,
	wim@linux-watchdog.org
Subject: [PATCH v2 5/8] watchdog: of_xilinx_wdt: Convert to DEFINE_SIMPLE_DEV_PM_OPS()
Date: Mon, 14 Sep 2026 15:54:48 +0700
Message-ID: <20260914085451.891675-6-triet.hoang.dev@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260914085451.891675-1-triet.hoang.dev@gmail.com>
References: <20260914085451.891675-1-triet.hoang.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert deprecated SIMPLE_DEV_PM_OPS() to DEFINE_SIMPLE_DEV_PM_OPS()
and pm_ptr().

This lets us drop the __maybe_unused annotations from the resume callback.

Signed-off-by: Triet Hoang <triet.hoang.dev@gmail.com>
---
 drivers/watchdog/of_xilinx_wdt.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/watchdog/of_xilinx_wdt.c b/drivers/watchdog/of_xilinx_wdt.c
index 352853e6fe71..16356d115b30 100644
--- a/drivers/watchdog/of_xilinx_wdt.c
+++ b/drivers/watchdog/of_xilinx_wdt.c
@@ -251,7 +251,7 @@ static int xwdt_probe(struct platform_device *pdev)
  * @dev: handle to the device structure.
  * Return: 0 always.
  */
-static int __maybe_unused xwdt_suspend(struct device *dev)
+static int xwdt_suspend(struct device *dev)
 {
 	struct xwdt_device *xdev = dev_get_drvdata(dev);
 
@@ -267,7 +267,7 @@ static int __maybe_unused xwdt_suspend(struct device *dev)
  * @dev: handle to the device structure.
  * Return: 0 on success, errno otherwise.
  */
-static int __maybe_unused xwdt_resume(struct device *dev)
+static int xwdt_resume(struct device *dev)
 {
 	struct xwdt_device *xdev = dev_get_drvdata(dev);
 	int ret = 0;
@@ -278,7 +278,7 @@ static int __maybe_unused xwdt_resume(struct device *dev)
 	return ret;
 }
 
-static SIMPLE_DEV_PM_OPS(xwdt_pm_ops, xwdt_suspend, xwdt_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(xwdt_pm_ops, xwdt_suspend, xwdt_resume);
 
 /* Match table for of_platform binding */
 static const struct of_device_id xwdt_of_match[] = {
@@ -293,7 +293,7 @@ static struct platform_driver xwdt_driver = {
 	.driver = {
 		.name  = WATCHDOG_NAME,
 		.of_match_table = xwdt_of_match,
-		.pm = &xwdt_pm_ops,
+		.pm = pm_ptr(&xwdt_pm_ops),
 	},
 };
 
-- 
2.53.0


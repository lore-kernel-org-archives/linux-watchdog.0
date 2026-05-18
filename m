Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC3B383C86
	for <linux-watchdog@vger.kernel.org>; Mon, 18 May 2026 17:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779124752; cv=none; b=GWEG0ynn47tKTJNbMUbRk+pISysHniu66i0zbCaGHAT/tWSYvjxhrOdgQcuqMzbZSrEheHjq4r9PuKr4CwTM8DkOM/yQwkRJ6ntPS/Zwj41yAaBMeDdoxhNXruNWmP4mVlBGRjNhfoA2ZgXZOQOk6nqQaF83Psz08eGoYDq33jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779124752; c=relaxed/simple;
	bh=hithE2VT3aXR7oGnU1Emj2CEQElJ9Gbcfa45yUo+Rac=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WRFh7FK4XtBFQurH5cFOnBfQ6R5bxm6ltXizhN7+Smcr603rJ94Y1FjLjFAts4Apo8wiQF18lfHIZBCFPD0iza082m++CuPqE+eELYDo53xQEkTsxblnnyl/edVIoWDnJLUtXKbMP5BpSftcgR2VGDi17E8/tCnQikWt3mu2HM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=lRRwCqTr; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="lRRwCqTr"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-45e7c636e74so948683f8f.0
        for <linux-watchdog@vger.kernel.org>; Mon, 18 May 2026 10:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1779124749; x=1779729549; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oJujmn9EEMC6CITis34UWwsyeBlzEQxUFfAce8SId3g=;
        b=lRRwCqTr53o5aYsUf7PBshO4LX2Gv71lK+8wxPNDma1U2s+t+4e7E8QJ6qhb1D7Ien
         xTTW3VU+LkXhEsiDRoA614ojmioc/brgdesJZQnnHW5lhr1Rqc3jRgdmo8pB/ESJTccZ
         KQEyHCo9yQxa1VTlIPbcJBo/nX9MgfwJ3vAb8VxFZ0k0CGHtG7wEK8tOMNdQnkuCQRjc
         6K/ysK1R/OfX/tMU+twuZsY2XtMzee+AXlPAsrzetpFrhbd9TwaECHywPnLKyzjCBCCX
         70Xkfc9XOSRaNHysR9uoxdWBviHFiY7Jl04jqXC0rLg8eqb1KzPM22No6ouuAB2jZR+x
         G6Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779124749; x=1779729549;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oJujmn9EEMC6CITis34UWwsyeBlzEQxUFfAce8SId3g=;
        b=SOaQuINvI/lz3URSeTwWvdaW3N4Gl8UfCg6E+BpcKKooWETcF27uRBjncPgnKgb5SH
         WSam+Rp6oM9NQbr71JREBCoozb50lUNJE/uL0108fRxml9KN4D4QoDz2k/ZJL/xC4yo3
         kfLLaTBKB0C7U3AROfjevwe+qMq4yfkqOqdMsY00Xkr/GUfxF//JzocC5QMEXKj7WLAV
         2KaOFBym2jiObysbDIcq8molzgJ83r5QHMGQX7AlU7I42hZWrtp494iTBjROeyoQ3GJ8
         35F0A8BE8EvB3zFzUtMZZ5UDrGwmpTHDuwbPXhMzCapaoM7pmOUlfyq2fZWwL64uwUUl
         /NYg==
X-Gm-Message-State: AOJu0YxP/Lq0Rck51SKFh//vme9iSbD1Za73PjG5y+bwIfKExctKYiT/
	LxIbZXLqK0DjJwfi0ePArgabFJ6JeMNrlwEYEK9cXemE16HvxqS4TA85hJxeaG94mTk=
X-Gm-Gg: Acq92OG3ZI/ZZBjL+IgXbZMp4OXLFcIRZfvT+eLsdyCP6uSEWFRw1q0IQrebpnnZBwr
	dXf5hDgk+BbpPpBWb7JL7bJLWl1PYBHr3L22igalqIsFSpziZ7KiNQ1l3Z3Lisgwv7uqb9IHp7E
	rpYm1+A5vwCLxDZ/IXKk7jSadx1uG6l0h3ipnvBCVVOnFK5hBvaZHxkmSX/Fqz9mEs20979tCO5
	p17lFBMJ3Hg73Ubo/W0e+7So3nBKt7eOhnlvCWRt3MLu2pwHsA9Am4k/9RjToEZ/i+IGrFRi6Wm
	BorcpWCbJu390s9Yi+UAqYDNfDxdwv4ynIBki5GDKqzaes5UUVwMJ6Gkok60iuQ41V4WP63TMft
	9/SzGL3FITSsLQmy6ZjqQOA3ImDHeiJF4pUqKNvuqS9HHbAORfZjuMEGuRgtBUg2fzCJp6BIHbn
	fslby7HaxeZi6X1sEEVBvexW+kh/B0TBe+s90y+N5OK6tex6uVGAGQUIlEsj1f+l6bNk/TrXoOm
	rjhkxpuuOB75g==
X-Received: by 2002:a05:6000:2503:b0:452:65d:e108 with SMTP id ffacd0b85a97d-45e5c5a5e99mr25479869f8f.3.1779124749553;
        Mon, 18 May 2026 10:19:09 -0700 (PDT)
Received: from localhost (p200300f65f47db041bee4d0e08e9609b.dip0.t-ipconnect.de. [2003:f6:5f47:db04:1bee:4d0e:8e9:609b])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-45da0a17ec2sm35933378f8f.24.2026.05.18.10.19.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 10:19:09 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] watchdog: ziirave_wdt: Use named initializers for struct i2c_device_id
Date: Mon, 18 May 2026 19:19:01 +0200
Message-ID: <20260518171901.904094-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1577; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=hithE2VT3aXR7oGnU1Emj2CEQElJ9Gbcfa45yUo+Rac=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqC0oGFCcOEqGhTwbURFpQ5azjYrjUKr9PxchPX Xk7UmEvKV6JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCagtKBgAKCRCPgPtYfRL+ TpGPCACKWF8ij7cl5Olma9IG7EasNru2kks++HbnCsAboqrxTueNkdHQobN0U0y62IO4fN6bcv9 SaoS8wNGGJOr9BNnT8XkbzlcR9cV4P5YmrE525FMRmT41wjK6pBDdnXGeGU5oci4AtoV4aXqzJW nEfjqYY/glI2MzwnZUlZzeMPHRUP2CG4mOn1Yagsa026X75Dyq0dTcbSvbFWwp5J+s60ghaUdxk Uy0Ug1Nbz4u7eu1zIyy8atp/iLYLjQDIoSQjTWauWwUxWkwr7jJA3KgVRUEcI/3VoH/QpIywEJ+ 76aL63G1pvAAnFAEDSGWV6RKun7QK+0C1/EMeJRTJNOzmiqt
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

While being less compact, using named initializers allows to more easily
see which members of the structs are assigned which value without having
to lookup the declaration of the struct. And it's also more robust
against changes to the struct definition.

This patch doesn't modify the compiled arrays, only their representation
in source form benefits. The former was confirmed with x86 and arm64
builds.

Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
Hello,

this patch is part of a bigger quest to use named initializers for
mainly struct i2c_device_id::driver_data to be able to modify
i2c_device_id. See e.g.
https://lore.kernel.org/all/20260518111203.639603-2-u.kleine-koenig@baylibre.com/
for the details.

This patch here isn't critical for this quest, as no driver makes use of
.driver_data, so apart from the better readability this is only about
consistency with other subsystems.

Best regards
Uwe

 drivers/watchdog/ziirave_wdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/ziirave_wdt.c b/drivers/watchdog/ziirave_wdt.c
index 5c6e3fa001d8..f3bb935c08c2 100644
--- a/drivers/watchdog/ziirave_wdt.c
+++ b/drivers/watchdog/ziirave_wdt.c
@@ -718,7 +718,7 @@ static void ziirave_wdt_remove(struct i2c_client *client)
 }
 
 static const struct i2c_device_id ziirave_wdt_id[] = {
-	{ "rave-wdt" },
+	{ .name = "rave-wdt" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, ziirave_wdt_id);

base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
-- 
2.47.3


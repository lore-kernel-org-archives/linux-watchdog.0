Received: from mail-qk2-f8.google.com (mail-qk2-f8.google.com [74.125.230.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09580248F64
	for <linux-watchdog@vger.kernel.org>; Sun, 11 Oct 2026 01:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791682604; cv=none; b=RQ1eqaOnLTT9nvjgqmQiHV6wmUutRgBSnkl1ZWZq+mMOYWKSVQUFdZ4lbAN56oknRZ8B57pI/EmqEwsXgGVZ7KbztcV6cWJXlX85z3eT5GoNWOBw1lNTGPN3X0dUnMhtjqP3wQ5Kh6u1RqucVxFYNU9bOtkgKGeNuunCfsW50gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791682604; c=relaxed/simple;
	bh=hco41XEl2buEUWtl9czQIcB2Oj9rlgT1hYq43dsuNTI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oywx6Q8/+GtOwMCC2SUJoSZ5Fiir8MtkvAx4L9w1/Exv4YT9AvozTGtjackZs+23Tf0EcSxeuSJsUEB3NiCFyQ2XeSk/yvnfY7mrPOGlrW7vZzIGa+5PBO+jUiviVyueFLnS8H70O6JT51hj8UmOWnr4wc1E5TSBpPCI27UWX8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XOhnPSRu; arc=none smtp.client-ip=74.125.230.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XOhnPSRu"
Received: by mail-qk2-f8.google.com with SMTP id af79cd13be357-93e63db6681so54351485a.1
        for <linux-watchdog@vger.kernel.org>; Sat, 10 Oct 2026 18:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791682602; x=1792287402; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=rqnBIiDXep9A/E7GHE0x8r23fh4KmbfjK4ifaUvrCeM=;
        b=XOhnPSRu8P6qNX758ph3AsO/DqDMz80iQ+p+xKTDS8SVV4MUyBxVXx7BPQL5kkSHO0
         /zLGlxExox+RoI9HWaoJF0v1zJaxzTsZ9XopQbESK5cOw6lENfMs/M057/aIqhhQS2OC
         yUX2abQwYlj4WJIGwaeW0ZHpF1+g74MO66BKtJ+tjNJl01Y2w+SNdR9D7yV8U3fFJdId
         GWf7VBGiFLIWfdzyF+uW9sx3aEfPpgRSo6pBRsrhbVNu979htCIyI1gWSqWeeEWIILrh
         xBIIZSytSpdea2LukhhEQSipwTfxii20ljNHFcff0HR5G1WiSnhnB9L0QXNfsUQNdJyB
         Yj7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791682602; x=1792287402;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rqnBIiDXep9A/E7GHE0x8r23fh4KmbfjK4ifaUvrCeM=;
        b=JNgTauFhU1FS3aFSm6U5o72ZI5r6+6IxKL5wTGUzm2jXMZDvVU4n3+Kh0Ap4aRSZPs
         EiQsctLGN3cDbDnuIbmZtihofBz3i/JtCEEnz186FK5JHrokOOeT2K4N2/viuMov0a9P
         oCWXaEjgc2nAbonEuWyu48yaOEtluZdUQMkoPAJuIDr3s6TEJwIVskA64QsHjCCVYZJ/
         5wcspIH2KlxS3ym5f0NxMFr+C8uHVbH/g53tWNiUNbLF4gr+d2DmskArlo+vtW1EXfR5
         pxhCVfKs2Vhi3NCNrlcueFs4F+iUsy37csdRLsyi/yREs8VOkBC94vj4Zrr+enR5tXFy
         KrZA==
X-Forwarded-Encrypted: i=1; AKwUvBx2TeIRrPZM+gHEDyQnm64TQaPuwm3lueAH733jCnr99aAtdFJ3DjhH1kuRgka6qVgkAVdhkBqZ2Qdm4Ty4CQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYIdWOuJsuPlhRpuqMg8C8ruAW1EQjMH7bLVqxGYiQ16puJo9gAz
	YG8YWmVj7HB1tsucklR/MiMkeG42z40NN0mp5iczvwbnen8nT+G1qkui
X-Gm-Gg: AYBFou0mdf62qvjlsXCbTDDg6/fnmGjnvM/qT1Jfstq0Rb1DopFUJD3Oq+P04TmlWXh
	uVlk0mkupAe0plWJI+hA3SSCT4PMC9spVH9kH1Jsoy+MUzTmSDwQWn4F5+f+9giOf7rwvgKPaxb
	RN2nfcKufHq10x8BZ44YXLurr2e22u+72dk/TJWKJhKB27Ratd5ACHxpX3u8wz+fg8II6VOTlvy
	eJFb2BcroR/TtnyJfwVNjzDsZ50iwy4M8GQShq1HT5RY/mogZ+GScUGUb7JDrIO125SdBwAatSE
	toQOU5XUcFWtPGgsDwJTs4pgxXorF+u13vnie3pl7RR842hpEK46BZnGGsDwizdgZxkpJnvbfKs
	zNuK6YuneVoPtPycnr8lItTzyjnInsFYoMTQNxsh7gVPhffn/f6kwF4bWiyxEtrbn9mUW81pZis
	JPyZMENOcQOY+JurI8TKtaQQmbz3QexIo2MdckjG2SBCJblt12dwgwV36w1P7je84XtkFN
X-Received: by 2002:a05:620a:448f:b0:939:b94c:3e85 with SMTP id af79cd13be357-93ebd1bb1c2mr1032711285a.24.1791682601680;
        Sat, 10 Oct 2026 18:36:41 -0700 (PDT)
Received: from omarchy ([2601:804:8780:3df1:6ff:277e:31c7:ac13])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93eb9848702sm540139885a.12.2026.10.10.18.36.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 18:36:41 -0700 (PDT)
From: zoan37 <agentzoan@gmail.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>
Cc: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Freddy Hsin <freddy.hsin@mediatek.com>,
	linux-watchdog@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] watchdog: mtk_wdt: Stop a running watchdog over system sleep even if not opened
Date: Sat, 10 Oct 2026 21:36:31 -0400
Message-ID: <20261011013631.1149228-1-agentzoan@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mtk_wdt_suspend() and mtk_wdt_resume() only stop and restart the
watchdog when it is active, that is, when userspace has opened it.

But a watchdog that the bootloader left enabled stays enabled at probe,
marked WDOG_HW_RUNNING, and the watchdog core pings it until userspace
takes over; that has been the case since
commit bbece05c0d3a ("watchdog: mtk_wdt: Remove mtk_wdt_stop() in probe()
to prevent the system freeze and it doesn't reboot by watchdog problem").
If the system suspends before userspace opens the device, or userspace
never does, nothing stops the watchdog and nothing pings it while the
system sleeps, so it resets the system one timeout (31 s by default)
into the sleep.

Also stop it on suspend and restart it on resume when it is running in
hardware, like sp805_wdt does.

The watchdog core keeps pinging such a watchdog until
mtk_wdt_suspend() stops it, so it stays fed while tasks are frozen
before the devices suspend. It may also ping once after resume, before
mtk_wdt_resume() has started the watchdog again; that only reloads the
counter of a stopped watchdog, and the watchdog stays powered over
system sleep (it is what resets the system from s2idle without this
patch). watchdog_stop_ping_on_suspend() is deliberately not used: it
stops the pings from PM_SUSPEND_PREPARE on, which would leave a running
watchdog unfed while tasks are frozen and could reset the system there
with a short timeout.

Fixes: bbece05c0d3a ("watchdog: mtk_wdt: Remove mtk_wdt_stop() in probe() to prevent the system freeze and it doesn't reboot by watchdog problem")
Assisted-by: LLM
Signed-off-by: zoan37 <agentzoan@gmail.com>
---
Changes in v3:
- Drop watchdog_stop_ping_on_suspend() again. It stops the core's pings
  at PM_SUSPEND_PREPARE, before tasks are frozen, while the watchdog
  keeps running until mtk_wdt_suspend(); with a short timeout that could
  reset the system during the freeze (Sashiko review of v2). The ping
  after resume it was meant to avoid (Sashiko review of v1) is harmless,
  see the commit message.
- The code is v1 again; the commit message explains the choice.
- v2: https://lore.kernel.org/all/20261011011536.1139162-1-agentzoan@gmail.com/

Changes in v2:
- Call watchdog_stop_ping_on_suspend() in probe.
- v1: https://lore.kernel.org/all/20261011004322.1118027-1-agentzoan@gmail.com/

Testing: on an MT8189 Chromebook (next-20261008 plus MT8189 support)
whose firmware leaves the watchdog off; a local module parameter
(mtk_wdt.start_timeout=31) starts it in probe the same way a
bootloader-enabled watchdog is picked up (WDOG_HW_RUNNING set, fed by
the watchdog core, nobody opening /dev/watchdog). Without this patch
the board reset about 30 s into s2idle. With this code (= v1): a
10-minute s2idle sleep and 40+ shorter s2idle cycles came back without
a reset. Not tested with a watchdog actually left enabled by a
bootloader. Built with W=1, checkpatch --strict clean apart from the
sign-off.

 drivers/watchdog/mtk_wdt.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/mtk_wdt.c b/drivers/watchdog/mtk_wdt.c
index 1630ab65d593..ff72e0fb1154 100644
--- a/drivers/watchdog/mtk_wdt.c
+++ b/drivers/watchdog/mtk_wdt.c
@@ -572,7 +572,8 @@ static int mtk_wdt_suspend(struct device *dev)
 {
 	struct mtk_wdt_dev *mtk_wdt = dev_get_drvdata(dev);
 
-	if (watchdog_active(&mtk_wdt->wdt_dev))
+	if (watchdog_active(&mtk_wdt->wdt_dev) ||
+	    watchdog_hw_running(&mtk_wdt->wdt_dev))
 		mtk_wdt_stop(&mtk_wdt->wdt_dev);
 
 	return 0;
@@ -582,7 +583,8 @@ static int mtk_wdt_resume(struct device *dev)
 {
 	struct mtk_wdt_dev *mtk_wdt = dev_get_drvdata(dev);
 
-	if (watchdog_active(&mtk_wdt->wdt_dev)) {
+	if (watchdog_active(&mtk_wdt->wdt_dev) ||
+	    watchdog_hw_running(&mtk_wdt->wdt_dev)) {
 		mtk_wdt_start(&mtk_wdt->wdt_dev);
 		mtk_wdt_ping(&mtk_wdt->wdt_dev);
 	}

base-commit: aac26bee2287c88af5be5a5ff96d783b19a28790
-- 
2.43.0


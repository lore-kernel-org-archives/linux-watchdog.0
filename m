Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792850941;
	b=Yy1Tudmv11x82UBMb56uXyfqKXU1PUE/J5wjEwtEf/dax/b9g90XSiWmkcwkBh/XNsW6
	 9UEh8cx+Di751zrPQmRV8ZuOkvGKaF72T+mUhoEibYAF8Mt/g5bQVut+4TuyUeiAKfAEs
	 4g2qViECi3EbnS2e9WfCAaOQ5sFHsoFa/2R7hFNEkrharFGTui8ROb8sqLxUduqWYWTJM
	 DI/hgqAmwYGb665tU8Qo449qw8h/FuzIuLfZlkyf+9xxl1xfXDa8MpprzHEi7uOF43ca6
	 hWvFdeA2GHp9dtOzoVCPzr0q9SpUiHukk1J1HvEF2LIvtc2MgP3mnh4KkBMY9AlhFVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792850941;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=EwKsrdatUTlg56QAFqz1oLMl5QbRHEGp0tdF9/HcfWk=;
	b=4taEXPyNWMxbu+sJkNVtdGrkiG/wdP/OB/xY8sgxrEi6qR56sRJlLhTDX9DIM75eESKd
	 mb7yWwX54y52jl4cV9GTFzKrqbmU/VBFjx6Illey9OV5V24UVXVtWNEB5r/xjhGTfc70A
	 Y0L7ydKo24ySXiv3ofwLLwGevsVQOYPFYRjnfBpGHeamvQrQKuSmDKSeM+THgiHV2U913
	 6aSf1yQEn5eJP+dGBTadJzK2QHgOWtjJzhzMhsDpj1Oo6ppY7/mMZ/EHNpUNxP9qlpWI2
	 l9YZ1aOxjg5rfDhPE5KwJBldpdUVDj1QGWaC3TLA2C4SGhvPZCaaJ/5rYBCb7dGJZ9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=lrvBAWhn;
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FEF7606A31B
	for <linux-watchdog@vger.kernel.org>; Sat, 24 Oct 2026 14:09:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7FEF7606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=lrvBAWhn
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a2084d62cdso13605545e9.1
        for <linux-watchdog@vger.kernel.org>; Sat, 24 Oct 2026 07:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792850940; x=1793455740; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=EwKsrdatUTlg56QAFqz1oLMl5QbRHEGp0tdF9/HcfWk=;
        b=lrvBAWhnbw45bOzK9RWYKvM6k57lVML5qCdb40NDOyS1EWgKvtMZDQKswmTw8CT3qh
         383rQxDQ9NvCQTKTptxW32GfdVHbQsuILkJ5fCluBw8DeeoA3zlqMmLqeUiXOOQWipAp
         2LCdXoAUyKU0RDegEbdp/e48zG6EA9b4A6QoVFxZ0J3BnoTiDLuTJDdV9c3AM/kmB8aI
         o/YSukE6NG2FOyrNNI81hkbNh3NrulnllZPY3IN4i30Z1ZGpBRFDRZCtS917rMiiI26Z
         BkugSmayF8HYNzJnzcDJKB/yUpxqMwiWLe50aYz+RDCti1Nh1Rtb/xfuzeXUqjKjLBTA
         OZpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792850940; x=1793455740;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EwKsrdatUTlg56QAFqz1oLMl5QbRHEGp0tdF9/HcfWk=;
        b=BAy26vIWYIMoX1ZRqHxTygZ3f6UYMDMGP4xp7+dnRh/Siqf6TMqqxlSfus/WZCqPkW
         Cs4gCnMDbkFxtkyTqjSiuYBSbI7+40Rhs0h349X7o3YMoQMfwZayW1Q31o1STFeW4YQl
         b0ZkS26rJKDlJE3Eujg4YNZ9sG9H9tf7qALk+OQzSS419yXg1lCfoHZGcNR9QRBHtS7K
         Y3I6nq1epG3tCazJbGZHk3lnjToER0wg3Nni2C3N0cfkTp6hENDBH5K5WEv4Nks8vcGP
         UKMM6Fi0FErVmoxjXb3qrYGIwDZD84loF8YB946oLxjCWVqCN+ZDjUEG3D6lgZvkMFG3
         ztVA==
X-Forwarded-Encrypted: i=1; AKwUvByD8YXjfYVtWRdMxD1OOzNQvgSrPt1/Su19i+GTQVI0aa7yBrpbiq5NMFKrcdjTYLOHeYjMtbYXx32DDetVYA==@vger.kernel.org
X-Gm-Message-State: AFq9FYI47ko8IxzSqNenLpZd+L3xFzPNugHM9XfiNwLb4Uwp7G77QJi4
	2WHEleAdsq4qMyBQL5algr/JmAY6VOaz1wIEf2SVSoeIucwMWVNBVKOs
X-Gm-Gg: AYBFou2Hb1dr4xM6sQUVs4VdQgCASGlEezSmE45Q64VgUqKyO//j+yi7ZqXCWskFamb
	uoxjuteLjf63vA0efTYjkniLsU5Jm41NzPCjBk7s4x77cP9i5IChi2K1QVtgBRxOqxTL78m/cdS
	XCgfOqMlEQXKB6u+DiEoCDnEAcxFRRYbeyw3vuU/PCjra94jLikgE31NEC6bJCo13WObO8wxKvq
	7ZRDbqcFc3GPEMTjyXH/izhVDlWa8KXwxI8/1qcgxiZEmhbabAESaYaf0QkVh12QbkHXw4DIKgN
	TaF/QxqvvQ35zodgn02DmJ90vRJ4jNCJS1WqzVC7yB1oquNGSw4PghzpHxJCjAI7e7qEFUQrfmX
	T6We+7cKoVF0EM1XwHDvEXyVzRO986DeL1CRGF+l/A83zsvvd19rLAQru2WgXqgmR8TJlOTyG7j
	cF0dXzWuuRLXUaiKumE0lB3fAte39qYvMo10gEw5vur8IM5XdTO/MLbc49Z5VmgFWAW/7hvjV4w
	XvqZfpVqhpW2UUiBA0+VVNacEUYq3FqFmupKHwf6qMB1d68a7wQIKQ=
X-Received: by 2002:a05:600c:870b:b0:4a1:777b:8a12 with SMTP id 5b1f17b1804b1-4a35ac95981mr31510735e9.14.1792850939744;
        Sat, 24 Oct 2026 07:08:59 -0700 (PDT)
Received: from NB-6746.. ([178.66.130.53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35a08643dsm46716525e9.4.2026.10.24.07.08.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 07:08:59 -0700 (PDT)
From: Artem Shimko <a.shimko.dev@gmail.com>
To: linux@roeck-us.net,
	p.zabel@pengutronix.de,
	Sergey.Semin@baikalelectronics.ru,
	mika.westerberg@linux.intel.com,
	andi.shyti@kernel.org,
	iav@iav.lv,
	tzungbi@kernel.org
Cc: Artem Shimko <a.shimko.dev@gmail.com>,
	wim@linux-watchdog.org,
	linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/2] watchdog: dw_wdt: fix reset line management
Date: Sat, 24 Oct 2026 17:08:49 +0300
Message-ID: <20261024140854.25664-1-a.shimko.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

This is v4 of the series fixing reset line management in the dw_wdt
driver.

Testing:

$ ls /dev/watchdog*
/dev/watchdog   /dev/watchdog1  /dev/watchdog3
/dev/watchdog0  /dev/watchdog2

$ ls /sys/class/watchdog/
watchdog0  watchdog1  watchdog2  watchdog3

$ chmod +x watchdog-test
$ ./watchdog-test -f /dev/watchdog0 -i -s
watchdog_info:
 identity:              Synopsys DesignWare Watchdog
 firmware_version:      0
Support/Status: Set timeout (in seconds)
Support/Status: Supports magic close char
Support/Status: Pretimeout (in seconds), get/set
Support/Status: Keep alive ping reply
Support/Status: Keep alive ping reply

$ echo mem > /sys/power/state
...
...
[ 1560.147058] PM: suspend exit
[ 1560.371470] usb 1-1: new high-speed USB device number 3 using xhci-hcd
[ 1561.031825] cdc_ncm 1-1:2.0: MAC-Address: a4:2a:95:e8:fc:e4
[ 1561.037736] cdc_ncm 1-1:2.0: setting rx_max = 16384
[ 1561.054408] cdc_ncm 1-1:2.0: setting tx_max = 16384
[ 1561.084713] cdc_ncm 1-1:2.0 eth0: register 'cdc_ncm' at usb-xhci-hcd.2.auto-1, CDC NCM (NO ZLP), a4:2a:95:e8:fc:e4

$ ./watchdog-test -f /dev/watchdog0 -i -s
watchdog_info:
 identity:              Synopsys DesignWare Watchdog
 firmware_version:      0
Support/Status: Set timeout (in seconds)
Support/Status: Supports magic close char
Support/Status: Pretimeout (in seconds), get/set
Support/Status: Keep alive ping reply
Support/Status: Keep alive ping reply

$ ls /dev/watchdog*
/dev/watchdog   /dev/watchdog1  /dev/watchdog3
/dev/watchdog0  /dev/watchdog2

$ echo 1 > /dev/watchdog0
$ cat /sys/kernel/debug/1e012000.wdt/registers | grep ccvr
ccvr = 0x09a7baab
$ cat /sys/kernel/debug/1e012000.wdt/registers | grep ccvr
ccvr = 0x0599dce0
$ cat /sys/kernel/debug/1e012000.wdt/registers | grep ccvr
ccvr = 0x01926467
$ [  110.392536] watchdog0: pretimeout event

Thank you.

--
Best regards,
Artem

ChangeLog:
  v1:
    * https://lore.kernel.org/all/20260320135624.223863-1-a.shimko.dev@gmail.com/T/#t
  v2:
    * Reduced from 5 patches to 3: manual reset handling is replaced by
      the devm _deasserted variant from the start, so the intermediate
      states that could leak the deasserted reset line are gone and every
      commit is self-contained.
    * https://lore.kernel.org/all/20261022134354.534642-1-a.shimko.dev@gmail.com/T/#t
  v3:
    * Squashed the last two commits.
    * Add error check for reset_control_assert() in dw_wdt_suspend().
    * https://lore.kernel.org/all/20261024121428.18862-1-a.shimko.dev@gmail.com/T/#t
  v4:
    * Dropped dev_err_probe() in probe to keep the driver consistent.

Artem Shimko (2):
  watchdog: dw_wdt: use
    devm_reset_control_get_optional_shared_deasserted
  watchdog: dw_wdt: manage reset line during system suspend/resume

 drivers/watchdog/dw_wdt.c | 38 +++++++++++++++++++++++---------------
 1 file changed, 23 insertions(+), 15 deletions(-)

-- 
2.43.0


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792676640;
	b=CBTUGuwm1Ms/95AQeMNHqmCI8v9gzCev204UiXI328Fi59DkJpTcf1j9cQ9kfI1ZwqAW
	 hyENX/QiG7kY3dW9vw4pdHrcsKUXVe43RvBFYvmShMKyC4iayttyUJFRNN+63rBbV9yCk
	 WCDfcgKlZjj2M+M291Az++ezLCH8SqDFf74q1nuSZEnEu0lgZ2gcLU5n/T4HrFpjiBc4r
	 /CM5+AdcikzYcfSxIbYo3LouwnwVpsmEmCnEWQKlvpz0fpIFBIichB0lLRShCEHqFHfpQ
	 SaPSkehL6nIyw5WsrCseNXly9yA7S9mpR7LjjB6YY8RDo9x50tiD7SQQYDp7JtpH0lw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792676640;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=OBrAstFxfei97/qGYpXR2Je94zT74yF0LdF3nW5YIug=;
	b=l1jyetsmmUK83nsPcWC+64zhjjYBN+K0NFJP+sY4MqYxpN8XORGKIfhSwmZef1z5FRg3
	 TbDUWE4FctxdR9ECycNDVOVb2CkB2ZdKifiNK8Pgdyl9sCIm1/3q0MhtsSy3OMItpbiTz
	 cY5322HBnUNKRXgwDzpd1+0cwyMDhqNhgN6QpejCaMZS8TZRoHNAKGEJOfDQPct3gkIs3
	 gncd9fwYjkBQ8lm6ZLF+GbeqfZga8ziWb0NboIpXmGS+LiWxreVxY96B2bHNihGQLlDDk
	 kHo1h68cadMMYngCWXR6NUhCvsUfEDoZxIXdKoVZz1hrG6jXQWkXvGTO63JxB3RiEhA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=NNVTXLU2;
	arc=none smtp.remote-ip=209.85.221.49
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38CB60A2631
	for <linux-watchdog@vger.kernel.org>; Thu, 22 Oct 2026 13:43:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A38CB60A2631
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=NNVTXLU2
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-48af4d4e61fso1204920f8f.2
        for <linux-watchdog@vger.kernel.org>; Thu, 22 Oct 2026 06:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792676638; x=1793281438; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OBrAstFxfei97/qGYpXR2Je94zT74yF0LdF3nW5YIug=;
        b=NNVTXLU2h8M+Zihavhx6ETDfpwf0+ysd6eNPBmJ2bUpCF82IefP7x17FNCpjm65J9z
         HdAzApEN7qBkViUIINKFRXordZaxBLxpkp5g7mxRlhGZVSBOvSr5yHtCmxrXqOSd+SLg
         mN69640QPyYrgmJHkv7jc4WBnV1e/gQ7/couGfVqCNWVKL3EdHLV11ib7qFIgNCygWa3
         51SUZdXLaunf5KEiPOQcqJJWhMZUXmldNf5w7OXg424rXonnGYiU6Ez128wq4t5IMKoE
         j0/aTlQGDg7Jqq0sYCFC4Mv6YMb2fBEtghCK3lHs9HUGAT1BRwmEiYwq1a3yc5vsRqX2
         7s1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792676638; x=1793281438;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OBrAstFxfei97/qGYpXR2Je94zT74yF0LdF3nW5YIug=;
        b=Vke8b/A3qW74y2l7kTOsgSBgBD0T8Iv1svtMaAJ4q5u5qIPbRSERzPk82W4DuPz5bz
         zfMAEcWhZdkqFcc6lNN49ATtPlIqxe9om5D2BJbmSYS53j4Mpp23cognNFMYWmk77FI/
         v44md1Ls6s+sg52SF+AnuW0id+PZC0/oTFJsFXge1ysjpX6CIM6t/X8hMERrbjG7w2tP
         6wTcUubfhZUk2l0oMDWAJhU0koxeRWw3YxSLeHJ8Hoi2MZ01pVdGdZRu65bmQ2WAPE6V
         bdUN7tcaOb8GxvP2i9bvJzkSP1cvzi5aRTzr1/HhXx9GPUWxm1DXUhufNW0TA2yNkH2D
         yxPw==
X-Forwarded-Encrypted: i=1; AKwUvBwbyRLebgIGEShrPeLYpRTmH0uDPfnBcpo01OMD3PtbTuJ9Du5JdiLGm4RlJGyoGSK2H5eNu9lhI/gwxSf/+g==@vger.kernel.org
X-Gm-Message-State: AFq9FYL2Rb/lB9DEykK84VgikVZhzhHjwLDwsJNFgLmBRDWz/PkTw7HB
	klZg0CjuKriBXu5qY3Y7JDhYYaK4abY5okeS5ZDJfghEuMNxncb4rCmE2tdT5g==
X-Gm-Gg: AYBFou2h8wX7ji2pRSIh/EwHYu5+3KqzZsCEdVm2Jd/St4E6LlvvqAKiOaMFkPNuiRp
	1onTB40r7E9WI0jAPgA24Tlvr6GQ4O5ezHIvR5j7BWQVrw3zLvyKkzWdK4Tq7OYNExQoLubPPM4
	Oft/5Vk/OmBQ/ZbuvhKOWm/VreK7Phj+ABGjSOiYwN6x8bb7BOi3K64beTDfTcnQnflncHgWQSI
	CY/81zS5MOvc9EEtN2AvY2EWwTgY0l3k2bbUlfTtEEaHviRG6DF/q00K1U5psT7TajMLpA4gBg+
	LG+n2YPqiYAWpgsMHogOhINLr81vOVgY5lvhBMfjehX7JOlPbQu+4HN5Zh21uWuywQsRoyys9x0
	GgArYZQD20o2MiR2MCobG+JdRWtMBZmEELG7AVMkY/7GNE8zwsMeZ/Ohp7kp9Ftm+4T/FKjyCF/
	KDCWu1sAGRztophCyuOMhIHoUilQsP7mwlMH57oEbGMRSjKn/KIabAPnsfhYBt/3WlXK2YM9VE4
	uz31q5QMQeNJkiiEUznQ3M96b1NkfdwnSG/QzWJr0Dt2y8Q1qOPJshAgC1fpESf1AAozuAUxhCP
	V4w=
X-Received: by 2002:a5d:4a8d:0:b0:48d:ecba:3cf8 with SMTP id ffacd0b85a97d-48e264dda0emr8042703f8f.43.1792676637773;
        Thu, 22 Oct 2026 06:43:57 -0700 (PDT)
Received: from NB-6746.. ([188.243.183.76])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e25835b1dsm13621390f8f.40.2026.10.22.06.43.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 06:43:57 -0700 (PDT)
From: Artem Shimko <a.shimko.dev@gmail.com>
To: wim@linux-watchdog.org,
	linux@roeck-us.net,
	p.zabel@pengutronix.de,
	Sergey.Semin@baikalelectronics.ru,
	mika.westerberg@linux.intel.com,
	andi.shyti@kernel.org,
	iav@iav.lv
Cc: Artem Shimko <a.shimko.dev@gmail.com>,
	linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] watchdog: dw_wdt: fix reset line management
Date: Thu, 22 Oct 2026 16:43:48 +0300
Message-ID: <20261022134354.534642-1-a.shimko.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <y>
References: <y>
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

This is v2 of the series fixing reset line management in the dw_wdt
driver. Compared to v1, the series is reduced from 5 patches to 3:
the manual reset_control_deassert()/reset_control_assert() handling
is replaced by the device-managed _deasserted variant from the start.

Patch 1 replaces devm_reset_control_get_optional_shared() with
devm_reset_control_get_optional_shared_deasserted(), so the reset line
is deasserted on acquisition, before the first register access in
dw_wdt_update_mode(), and is asserted again automatically by devres
when the device is removed. This removes the out_assert_rst label and
the explicit reset_control_assert() calls in probe error paths and in
dw_wdt_drv_remove(), and uses dev_err_probe() for the acquisition error.

Patch 2 adds reset line management during system suspend/resume:
the reset is asserted before clocks are disabled in suspend, and
deasserted after clocks are re-enabled and before the register state
is restored in resume. Error handling is added for the reset operations
in resume, with a cleanup path that disables the clocks in reverse
order of enabling.

Patch 3 cleans up the error paths in dw_wdt_resume().

Thank you.

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

Artem Shimko (3):
  watchdog: dw_wdt: use
    devm_reset_control_get_optional_shared_deasserted
  watchdog: dw_wdt: manage reset line during system suspend/resume
  watchdog: dw_wdt: clean up error paths in resume function

 drivers/watchdog/dw_wdt.c | 37 +++++++++++++++++++++----------------
 1 file changed, 21 insertions(+), 16 deletions(-)

-- 
2.43.0


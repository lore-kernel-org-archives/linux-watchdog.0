Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7526018DB2A
	for <linux-watchdog@vger.kernel.org>; Sun, 24 May 2026 01:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779587462; cv=none; b=pbLyz1/3YooETqjHR83Th298pDqnyrKPJiGRMNuRGCiIcItage6fmOWztdZd3aazVXp9iVepL4V32t6bzpeNFdf1UbFK6Ef1NiTE67h80rOAFDm9gdoGv0a6PF7ZIESpeqL0RZ5cnQSgSTH0I1zCSN/gXp5JisDTos8NWEj4Lzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779587462; c=relaxed/simple;
	bh=juyzX2H8t2ufgHgTPfab81qQZscnhnKWA/A3n1MQ5YM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aa2PXQP5GHZQp3yKbM5oMukinWasLsImra9tJXFWwXRfKzcqjB93Kj0AHHeiDUvu08NNxBmSc7TbO/lFPI1zqnLmI3UvRzKXrcL/Fogyag+Ex9sAhS7l+gM5paDgNSjuD/+cSXuvQAiCe/IBeREp2j8NncH/8T/LrZtgOShoOBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WYoCSRn2; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WYoCSRn2"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2b9ea536877so55965795ad.1
        for <linux-watchdog@vger.kernel.org>; Sat, 23 May 2026 18:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779587460; x=1780192260; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=T026Y8h5llVovJD076CzCoq0TucuAqiOWCUtKpQ8sTo=;
        b=WYoCSRn2A0QLUIuZQtJNfdwqx06mkH2/lAOP9pP136xDfZVNrh2blSadKj4dJxQQ8u
         S3Ot0A9NcUlMG/TllfQmeVTspXg9VT7U2W/+GDEjEVDIx0xV+mnxwfjJb9HCs/fMy8qX
         5ZobTKUuWd0p/7fvR2yWsZHhdqFUgX8E7i5brUtln+hTXn7XzmqCPnQGyNXUr/lBAilj
         p8ATtivEwXOQJZOI6lnO/11nft5efoNGbPmOzdqc4fyGNWdRdG/fRlKFn4e8v5WKh3aL
         bIKwIIltZJW43zSYYCH4retjeEV/UpnvLjBylIna3s7TpjjG9r9Jo7QjnvZYMe/MqwND
         Jg3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779587460; x=1780192260;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T026Y8h5llVovJD076CzCoq0TucuAqiOWCUtKpQ8sTo=;
        b=rzvEgT6lZ7txud0of5QK3kfhGBpsM1dIntabztX3neiUlYfVL/mm4CMotmxkIS6okj
         9grJzi3GXnrWIAYPFr7dZbN18a03UII/98buzhMkopPJmWHsoQuTO8NssNg6T1RfWlq/
         rErLtDVBFXa3xDjes6VgDvCTprwVeOHCYdb3kpDRzSVg/j9gVmQHPXW0cMmjnkSIS6pa
         J02oCgRe96fWhobHVTQDPTsW8Vdb7Lmnly+vmEy9ynz3DVhqmsucsjEoOGs3J7v6Hvdq
         D541tJXjvybAePbvHVQIhpsbr6vhSTI3PnZ4yYKbKw51JuseWuMYNUPmK6flJPXnwHHM
         UPjg==
X-Gm-Message-State: AOJu0YyrAcKyfM1iNyh7fUag8eaoGQgCqUTF4VKglhtZbYwVNmVZbsjo
	zEU+2W7+sHXnU1S4jAz6wlD1P2v8/i/MR85B5TUSHADzRHY1z1iTCQwOKOi7nA==
X-Gm-Gg: Acq92OERQbugg+lJ3TNGteGswS6IaLuZ/Lrn68C5D9XBiW63QO1Ap0YWVzRdCtO8Eye
	efePc6wb0InkPdxHR6OTTiFtD9sWhqXDpnASytOWA5Yf+NtGOeBznP4FEO1mmLZP+WVt/RI8r9U
	K9peWymKIH/80ZNMAuXms2c3oLbpiYuLvf72BFdhZG7n+/FsDJJWtD5vGEUJjqeQ17CYdguidVg
	U6QQTCamCzxj9Atlnefk4cxOUYU/WPUXwmL3bBi1wx9Io7SCrp1Du7BeEpNZhpAiyTQfdZIRQl/
	Vs3s/l9ulTGR9wSEUyYFnIwLkpevH2BbLB9twllYB83bq2k4Mhzt9yHa0W6B4h/1GH0HjxUZOd9
	CKHQvv6R9I2CVm4Qd7JuYvgSOCzc3KgrmP7HdMH1tdRCGk81BXnLU60GFTG2N3Y6pBpv1xVMsh0
	dkv6mhvFmZMgXpc1x8ma0s91k9XBNtHjUoErdFutV5hWBQV1z5fI9cthtvz3LTMlwnhl6YNlMLr
	Ojqob2U8Ny5zEEDvgdzn6SEIsdFakYEPV4=
X-Received: by 2002:a17:902:f546:b0:2bc:8e7d:3dce with SMTP id d9443c01a7336-2bea23e2057mr117698645ad.27.1779587460375;
        Sat, 23 May 2026 18:51:00 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb58c3168sm54822965ad.58.2026.05.23.18.50.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2026 18:50:59 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-watchdog@vger.kernel.org
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv2 0/2] watchdog: ath79: modernize and broaden build coverage
Date: Sat, 23 May 2026 18:50:40 -0700
Message-ID: <20260524015042.175271-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Patch 1 splits OF out as a hard dependency (the driver has always been
OF-only) and broadens COMPILE_TEST coverage from ARM to all
architectures, so the driver can be built on non-MIPS targets.

Patch 2 moves the driver off the legacy miscdevice/file_operations
interface to the watchdog_device framework.  This drops ~100 lines of
hand-rolled ioctl, open/release, and busy/expect-close bookkeeping in
favor of framework callbacks, fixes get_timeleft() to return seconds
instead of raw clock ticks, and properly propagates -EPROBE_DEFER from
clk_get().  nowayout, the timeout module parameter, and module .owner
are wired through the standard helpers.

Tested on an Archer C7v2; sysupgrade watchdog handoff still works.

v2: addressed review comments

Rosen Penev (2):
  watchdog: ath79_wdt: select OF and COMPILE_TEST
  watchdog: ath79: convert to watchdog_device

 drivers/watchdog/Kconfig     |   3 +-
 drivers/watchdog/ath79_wdt.c | 250 +++++++++++------------------------
 2 files changed, 77 insertions(+), 176 deletions(-)

--
2.54.0


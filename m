Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795496483;
	b=rXiGGdQLUwa10fT3WIRTR9r2+84hKysDcx7mXVbpxB+vEpWIvSI2HcGalqEWYkQuSyd5
	 Vb9PEMAoHeuQPFfmo4yqSt0fZq1aR0RY+vWijSgbiI5qVQdQulPU0DjtE7lOc5qI3c8Fa
	 I5dz6VS2hTlcIsowC0cr7RQ+B06UAkhZhFiKxlXy/km3WWMg8QTs6Cqv2jVeqTmnEZhCb
	 3WWuY5YxMh5+RtaR+UnzJw6zLO1TuvWdXgbypW3NxvXHEBjvMC7BsbTxFa7fyZYFCGy2c
	 r/dMf7i518Zv/TdCUvC/ijyPwO5ooH+VFYwc9B8G2pflWRWZgMa7vE/MfsxGLtJZniQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795496483;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=sITgWxD5iXuRoxacaW1y/ZEl91KWtEOEir54BjnX2Ms=;
	b=CvK4LsmvFYT1t4yHH2gRZNyGaShJnNLd5zhmcTFQmlCFFgRnLsvWU4kWjw+A/V/oiVZj
	 YpDDU7bbQSm3RTcBiaPuelI8x+0FXO08YP/rr3sJ8SZLr1hW9EAn/w+RVf9AKpmlq98In
	 9/n+YGtzSYMfqd8YMuPQntbZlvgC+ZUCKP4WMLl2/4EXHjFkaCbMBjXs4uQvowgvgRj4L
	 g3GpcKrn6LR/JYk9uPExAF8RdvDYfDwhBQRbGw2uYO1uVXE+iteRAlqsyY2u/rmNiOUJQ
	 O1y2v3/euFqhZeZtoJW2BbI2BUZ1OPpEq4hCbEDwibTd7azJzTSYzpw84ZtJF3O6rKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=u5UXp9OA;
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5934F606A322
	for <linux-watchdog@vger.kernel.org>; Tue, 24 Nov 2026 05:01:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5934F606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=u5UXp9OA
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a5177d78c7so38918295e9.2
        for <linux-watchdog@vger.kernel.org>; Mon, 23 Nov 2026 21:01:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795496481; x=1796101281; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sITgWxD5iXuRoxacaW1y/ZEl91KWtEOEir54BjnX2Ms=;
        b=u5UXp9OAtY9R3Tu6ra8aHem5hACKbhfVHyr+QcpVIcfTulfIjIIzKI3QaoiClWmPoW
         FpG0syLG8TjSSP7rM5t8vrccjmWkOr9w9vjDC0O5356VGLiKFPUt9I5egRVsA44W7gqo
         pJxJpgFTfESSsUyh7bXZP8MKapKCgG0PjUJ6LnrURI6wGJw5VccVeqEGSgh6Y+0GWpdM
         s6nvWH6C1uicnnNJQRwQAxjmsKiPLQZqR1s1Toyrh4dYWmkb9NwrUu+NkhSxPlLz57U8
         w4PeWxBiDapMjnc8GtiFvYsCthY6rjoI77d4v9/JVDqOrub8uZ/8vl26E8NXSZztiAR/
         3WjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795496481; x=1796101281;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sITgWxD5iXuRoxacaW1y/ZEl91KWtEOEir54BjnX2Ms=;
        b=ZLA9ASe5fyKdwbeuYu1mfa2b7txHqnEJbMpdnkvopIlkCYdSI7kYnNn/UHC9J1uoLB
         B9oj824Nmf7MFcgjWbmjNWzajNpzk3AGRfL6wA9tuu6Wk48hdz1T9jRUOt15XKkkysrm
         jzt6v0atnhtf1zEvNtvGtXbA37K9Qg8LWMgGH7uugWRU0R5iDXcc5XXgvbvE/F42XmAV
         UKwt7CNTbL7/tJP9QyM7Si8tsF7liiDmhE/PmZT67e0Lvc3enAUTmWS2qodWoUk6hNYI
         jDKQHH+xyJDULNOhTkanrQ/yoY7Q//xG8vDFyWhOYz1cpk0BZq2kUTq4JuEiZI515Iff
         rwZg==
X-Forwarded-Encrypted: i=1; AL+hErHXXvNEx0q0rx9GL37JKCVotLyBSYl/Qtx1/xp2dyonzOMecDYJg6amrUwOzii/9w3LL0YyDW98KaUOJjpSjg==@vger.kernel.org
X-Gm-Message-State: APuU4Z8/pQpPpPtsCZutjokch9ozx1RyQvmVS86TRG7Wm91ggmddNMyA
	C35uQX0iU9tTahoKdUdoQJ7f+0v7X5pHcGcXdTxGLeMkvk45RaRQKNV8
X-Gm-Gg: AZFdTZfhx7LWF17pHZGEcMn29QgIhyqWkmiv2XUfwN+9NbtrBBqnffrNzyrHjcUruFO
	TEIizE70WMgehWuiCpeSnstwLPIu29WsgLpCjzbXBqrTZ+bWMzB2yqbLPhECo5LzMepLMe2ELaH
	BfoI4hP/8EGElmEs12Rcln7+8Rro9dKcpyXHLSG7HZb1WhfRCsb8igvwJs9YzJ8PmLIzc3DxIst
	e7nvE5lcTf79y5tc1HCn34L/d3LYqiKLfPmqAScZXXjlbM8vz5chrvOatKq8P3iueABKrwkASAw
	T+t5DLM1S0CxDTKR6rJAK5yo8nNjtrVuD7L0r3EWYKKOirNohBgaDyGXr5lvkQ48htFPRRQ53P0
	60MLd0593EDUPnda+WeooD2UIWrokrv9MEyWqHZnAa59QQhzLvfGh3/sQa+0v3AiYxERmFIvYSc
	+Ng6zzjFmBPIY1sQM4ILdvjDAgc5BoOYuCOjod78qm//Q7TOg9m204ZPqkrc5xfXTbONKz8KgJW
	sJeGIGqLwLn2TLgmdQoRG4v6nxpuYSAo7onUD2tgtBqfOKtDSwh1h6HWkVEnheBd1zrp93AOdIt
	vInT735Mo7EGVrgTM6uSbAntGXtF46DbsrdVM9b6qO5qr+ZM+PGhxBhBLCg67AXq8rw7EXKdryf
	4EaY8oJRZZHX0tNuHMWX6RLz9hj+Fsox0gafk59WTcz7NhfVPDbJ2caA7SRwEjc3k3e6ZaF6VOy
	uj/lWnR66+goDZw+F6BKn7ji8PG9W7ub2ZDcPaG/bN27jqyGM8gstbgpAcs0y6XtpE9RL0ZknX5
	A==
X-Received: by 2002:a05:600c:3113:b0:4bb:5f45:c97f with SMTP id 5b1f17b1804b1-4bb88816b2bmr291844445e9.27.1795496480513;
        Mon, 23 Nov 2026 21:01:20 -0800 (PST)
Received: from localhost.localdomain (dynamic-2a00-1028-8388-a84e-f512-85ee-fdbe-0621.ipv6.o2.cz. [2a00:1028:8388:a84e:f512:85ee:fdbe:621])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb88442693sm353489155e9.1.2026.11.23.21.01.19
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 23 Nov 2026 21:01:20 -0800 (PST)
From: Josef Schlehofer <pepe.schlehofer@gmail.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/3] watchdog: max63xx_wdt: Support a WDI pin connected to a GPIO
Date: Tue, 24 Nov 2026 06:01:15 +0100
Message-ID: <20261124050118.87944-1-pepe.schlehofer@gmail.com>
X-Mailer: git-send-email 2.54.0
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This series picks up Pali's patches [1], which stopped at v3 in July
2022. Pali is on Cc.

The MAX6370 on CZ.NIC Turris 1.x routers has its SET pins connected
through a CPLD, but its WDI pin is connected to a SoC GPIO. The driver
currently cannot use this GPIO, despite turris1x.dts already describing
it.

This series adds GPIO support to the driver and binding, and updates
turris1x.dts to use the new wdi-gpios property.

Changes in v4:

- Address review feedback from Rob, Tzung-Bi and Guenter.
- Fix GPIO direction handling and remove unnecessary locking.
- Rename the property in turris1x.dts.

Tested on a Turris 1.1 running the Turris OS build of Linux 6.6.142
with patches 2 and 3 backported. The watchdog works with periodic GPIO
pings and resets the board after the pings stop. On v7.4-rc3, also
tested the binding with dt_binding_check and dtbs_check, and built the
driver for powerpc, and for arm64 with and without GPIOLIB. GPIO
behaviour was additionally tested under QEMU.

Patch 3 can go through the powerpc tree once the binding is in.

[1] https://lore.kernel.org/r/20220705001023.14660-1-pali@kernel.org/

Josef Schlehofer (1):
  powerpc: dts: turris1x.dts: Use wdi-gpios for the watchdog

Pali Rohár (2):
  dt-bindings: watchdog: maxim,max63xx: Add wdi-gpios
  watchdog: max63xx_wdt: Add support for specifying WDI logic via GPIO

 .../bindings/watchdog/maxim,max63xx.yaml      |  6 +++++
 arch/powerpc/boot/dts/turris1x.dts            |  2 +-
 drivers/watchdog/max63xx_wdt.c                | 24 +++++++++++++++++--
 3 files changed, 29 insertions(+), 3 deletions(-)


base-commit: aebb7274476403040d582c61478df8f4a7bf9cd3
-- 
2.54.0 (Apple Git-157)

